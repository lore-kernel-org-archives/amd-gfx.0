Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8315C43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 05:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 847D920719
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 05:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xgeHXWVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847D920719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C15036E0D0;
	Thu, 26 Mar 2020 05:25:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 795FF6E0D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 05:25:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c41elpsI4a4XxRqDVMPIbmeRb4FoELGc9msy9Chsib6/80D/CI+smJgVX8jw2YfzwXYpKt5/CVbaVIcG7uQmH8sf3CYsNhGcH8RADbujGukL/Lz8zuII8/ygpyHthEF8vCD8nLW72QrxkPwnSpxPBRYRMM9j9LuiqNIUUVkN7caJ/+jBuUpt7jkexIpweDB0LZ0lQGmUZc39GacnYqVj67G4QB4t29E66Oni4GHL4EotLNdAPc0qOUV0MQoDYIo3xrHKVPQgHikj+Jl+HdBCDihSmBzG50VHLGm/ofhCwv9PEHUfRc3anCXSdSMdpbeajFuUZHfvPmW8WvLeKmj6nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRfIxE0Lh8YSqOH7NTf2oaJ0g5JUpcoRb1wh+s//ChQ=;
 b=T0UIoha8waTiUv8lIGn8tKrN6EXKIzUWNs0QYIsIV+EVfFxFBQNW261tcNnYUTulfTnz22uCPmGklYEXDEX5vU8buJEv0MwicHrehdW6mz6rUgNIk1oFQyVj/JxB/AJnpOT3t5WnJYgAowsJF5UKG8cV6U/V6qLytEr0naatHCCfK8h7+ngqgl5lZaQsHq0cnjhaq4cgTYFoA2ulv4I4cSbNZkb8YSmETU8voZeG4uMwXQH0Lk8rk2CaHwLiuk/KS9zoTGID7fLbUN7+JdinqV0ynORQ7deqUntoZy66cKpmV0nBlR/y9+riJuSmaVMaEX9DWVk4jw6W0sJpGPb8Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRfIxE0Lh8YSqOH7NTf2oaJ0g5JUpcoRb1wh+s//ChQ=;
 b=xgeHXWVXxhTeTw8Jki6MgS1a8lWH3da/kH1u0i78GuaFwKvkILE3mEUS8YSBOzC2Eg4UxkKEJLaeBKAB/iKstZnABsEkkKOqyF+AMVQjIRo3Xk5eVcm/6D9vlNhV8lkFLJedP+Nm15oJ+LUUk7UbT48cMNyHYIStYrWE91TBvLQ=
Received: from CY4PR12MB1703.namprd12.prod.outlook.com (2603:10b6:903:122::9)
 by CY4PR12MB1542.namprd12.prod.outlook.com (2603:10b6:910:8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Thu, 26 Mar
 2020 05:25:39 +0000
Received: from CY4PR12MB1703.namprd12.prod.outlook.com
 ([fe80::752d:b539:241e:c7c4]) by CY4PR12MB1703.namprd12.prod.outlook.com
 ([fe80::752d:b539:241e:c7c4%9]) with mapi id 15.20.2856.018; Thu, 26 Mar 2020
 05:25:39 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/4] SWDEV-227334 - No need support vcn decode
Thread-Topic: [PATCH 2/4] SWDEV-227334 - No need support vcn decode
Thread-Index: AQHWAoAZuSd7p641vUWcwf7vlFTEQqhaNK+AgAAkN+A=
Date: Thu, 26 Mar 2020 05:25:38 +0000
Message-ID: <CY4PR12MB1703C636C0DC3EDD441A11E884CF0@CY4PR12MB1703.namprd12.prod.outlook.com>
References: <1585125181-14195-1-git-send-email-Emily.Deng@amd.com>
 <MN2PR12MB2975DD3AD30E8B8AA9698BF98FCF0@MN2PR12MB2975.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB2975DD3AD30E8B8AA9698BF98FCF0@MN2PR12MB2975.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-26T03:15:43Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=60857c54-e5ac-4829-9dec-0000b9e8b42c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 070137ec-4a12-4c59-a878-08d7d1461ec7
x-ms-traffictypediagnostic: CY4PR12MB1542:|CY4PR12MB1542:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1542EBD2E6F60571D0B9DDE584CF0@CY4PR12MB1542.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(966005)(66476007)(66556008)(64756008)(66446008)(186003)(76116006)(81156014)(66946007)(478600001)(8676002)(26005)(8936002)(81166006)(45080400002)(7696005)(71200400001)(33656002)(86362001)(316002)(9686003)(55016002)(6506007)(52536014)(5660300002)(2906002)(53546011)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1542;
 H:CY4PR12MB1703.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HFiaDJTyg5JzGRQ+3QfwxQ1f9jESCbQxTGsy8pE88JVEXM6u/LGI0509FBK5qsttcApmDCzLaZ5EbdWEk9emLt3qleZh0lOTYJpuskJ/BJhZs0chKsVaxf+42QAlPStOXte686xa4Mrk5SeteJGBqdpWXSxu2yORe3fq9smap282tbRDYEns9P4/vDsy6ZeTxbKlegd7tcNZ07+bgespmhWPH1S/hpy16KikXCjgT8QQ7OhiRYzz3xbRGPn13jeeBnH6Rmc8AOrhT2CuQV4U/es7V3BAK5tuu6zz/dAY9rNa7LccrynPi3pi2oABjlW0aMEAj45qFftGBZC7aXbvaCkcEfK8ZIrmUuaJD4AY3Fi0Ka6DXAkwZPIt2+E3uIv6l8vgC/t36HOLQ614ckVhjRHueakrB8GRFwSTnYu7f0DOh1QFvWH/3iSnDpFMjP2wNFUP39a7pSnRtNlOS1Bzjij5n0d0IQEDsoT+6SYU+m5RQHluxhdRV2SpW1WA/ox3
x-ms-exchange-antispam-messagedata: /TbdQBxXg5lWDOl9EExHxSexzl1z1UoIDI3DYU5wfjoq1T9JbGM1Q3DGzis3Sa/74i5daND0UXXzLZWh3MUGG3hdm/4oIpwbf7GhA2aYKfSk3m1Z4gH3Zx6wwnPv8YesIWrZnBRuAjfiPF/h+L4GMQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070137ec-4a12-4c59-a878-08d7d1461ec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 05:25:38.9342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ffE4qwe638SuarYJ/9/PC8pKrXpZoQdSl7oSQydvG8RZZJ7KP68wfYHiQ3GpJwvj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1542
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Monk Liu <monk.liu@amd.com>

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deng, Emily
Sent: Thursday, March 26, 2020 11:16 AM
To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH 2/4] SWDEV-227334 - No need support vcn decode

[AMD Official Use Only - Internal Distribution Only]

Ping.....

Best wishes
Emily Deng
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of 
>Emily Deng
>Sent: Wednesday, March 25, 2020 4:33 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH 2/4] SWDEV-227334 - No need support vcn decode
>
>As no need to support vcn decode feature, so diable the ring.
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>index ec8091a..febd4c2 100644
>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>@@ -223,6 +223,10 @@ static int vcn_v2_0_hw_init(void *handle)
> 	if (r)
> 		goto done;
>
>+	//Disable vcn decode for sriov
>+	if (amdgpu_sriov_vf(adev))
>+		ring->sched.ready = false;
>+
> 	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> 		ring = &adev->vcn.inst->ring_enc[i];
> 		r = amdgpu_ring_test_helper(ring);
>--
>2.7.4
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists
>.free
>desktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7CEmily.Deng%40amd.com%7Cd7570f695fc64ab688
>b308d7d09733e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
>7207220147577735&amp;sdata=vTgILeBbCu5CRPs2aEPs4htoiucE3pYMjPiN2B8
>mEBk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7Ca2aeff978efe4cd76a7e08d7d133fee0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637207894223674822&amp;sdata=7Bh3wa53N8F0Nt1ofvOT5mLoKoI7izGj7UlewfwxQtA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
