Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4CEC43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 03:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD07E20737
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 03:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IAUJvJUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD07E20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5348C6E23F;
	Thu, 26 Mar 2020 03:15:51 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680050.outbound.protection.outlook.com [40.107.68.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A5996E23F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 03:15:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3aDPriw3iuoWQ469G0lOM2peYeh0xsUBx0kiYzL1fv0DsadmuF4+4jrTH5TykztZ6EHXghUSLiyb6csD416Oc9TJ5BgYTgcQJIU8pez6+60r5OxLamPfmrZcQDwA5GLM9LVfmHtabVgftKnHrIBekAPhgx667bI+Qab3FMtNmYw1YRxQzHfvatIZeDMCO3fcMzkVNg9+DrvEUmPyuM2tE6T2aPN4swttvcXdgHIBpG7ml3HJJNsjE+WImunqDQOdtyepY9InZUnqLOj9B7kJJHFtPZxJ13BLFqg+9E/ReJX+pAsnIvhKTxIGowj1GbHXEpbx+0/j2cmaJuNKJqP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGDESlVuTo0otW8M0bFiQaj1zMsYnSslDY97A+FLvs0=;
 b=LN/LCYf0nHYfnY3ks9ClJvSI8bc7IJcSuUg1Ouyo5EOIKV+00myZRdzrAJOLLaL3TGCCcIQp7cVj2XwVYSD8St8PvJRA5XMm4FzMmPKKDiJC56BJMypN/7O8JFPSwldjfhQTR6S8mWIXlLj9TcQy2u9hHJxzp9wQfDNL3QIl9ZlURBFs0nC89VceE830d1C2mmsszZDqikGrdEJyk1f6y29vs/C8O8ReMpZ44Z2wYZxpSNCpMJDe4ycfAeKrgT4733p2ifX0w5Smcx5JMVHRuJDzzSYLKDVOX5SjXmO0Cwu1E36BenwDiRxNxfgsjxRYSB/ZoqjqUpYxCHexI9SEaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGDESlVuTo0otW8M0bFiQaj1zMsYnSslDY97A+FLvs0=;
 b=IAUJvJUdC4po8qorXgJulF9u7Nmhy78grOhjM3fUOx0Lcp+cBMR3LM0AdS0wxuewncaDEOUI8e3FBbtx8KpvUzI+W/Vxe8th6Em8+9GNo1Z9RF6Ja/94aSUU3VwXAlvhtjqCj75KbqpJekIyc94/3WFVTncNGSQowFc+81EDePI=
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (2603:10b6:208:ce::14)
 by MN2PR12MB3071.namprd12.prod.outlook.com (2603:10b6:208:cc::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 03:15:47 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::3504:685f:e9ac:7028]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::3504:685f:e9ac:7028%3]) with mapi id 15.20.2835.025; Thu, 26 Mar 2020
 03:15:47 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/4] SWDEV-227334 - No need support vcn decode
Thread-Topic: [PATCH 2/4] SWDEV-227334 - No need support vcn decode
Thread-Index: AQHWAoASWcXbxZfybkmuSjCJiVEt5KhaNJuA
Date: Thu, 26 Mar 2020 03:15:47 +0000
Message-ID: <MN2PR12MB2975DD3AD30E8B8AA9698BF98FCF0@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <1585125181-14195-1-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1585125181-14195-1-git-send-email-Emily.Deng@amd.com>
Accept-Language: en-US
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-26T03:15:43Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e330fb78-7dfe-4197-930c-0000b3cff1b1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51df136a-e44c-49b5-f746-08d7d133fa8e
x-ms-traffictypediagnostic: MN2PR12MB3071:|MN2PR12MB3071:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3071DDA1F08385FD9C17F1A68FCF0@MN2PR12MB3071.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(6506007)(66556008)(66446008)(76116006)(66946007)(110136005)(33656002)(186003)(66476007)(71200400001)(64756008)(26005)(316002)(86362001)(7696005)(45080400002)(81166006)(478600001)(8936002)(55016002)(9686003)(81156014)(52536014)(5660300002)(8676002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3071;
 H:MN2PR12MB2975.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2LzEpw8xGlgaSzbLSZiL1SQQ/g8/Oruhxw0OAnxOS18wR4e1kv39CeK6Nj7v1XU73fWmgJt6ykdH2ERueO/psYITYP312uQE/tEVjMEHKC6OaTDZ/XmPEhG+Z6CYkST5TaT/rueTabGVTyWZTlOJKZmIt6sv9S0UgRxr20oS8U1EasKKt3MFULve2bIZcEkF5rctxpM7JV+bxY4uAsCfRki/woWkcNXjZ7WSXtmTxsJuUcgAM+U3uk5iy7NR2N9DTYj381DmQ6GFUCcSkvMqUTqDYxH19EczYTJyzap73Ii0/kFEtwp2Cqbb298t3OFYEvi6egQSK8bRCzx5iXjKQ3xWWnkZ6GJ+jLQQIUUD8DPtvKQK5MeRIMUTJevnl7Ot9//Samj7NQEG5DnUpEA9jiRVAxJNAEyGNJ5JxMnx4FeX38zLtcGVQg4Z7uCTDTxQEpS4HBAqI1r65LhuTTNaAFBQJDScCR0qIBI2b3ta3Yg=
x-ms-exchange-antispam-messagedata: 27S2L2Eh1jlxOy46khaRZqv2OcSXGQuAaGe9+BJbkdLdnjUDVUqfjC/gsbUZiDVYCiLNiXl2I/mzUmwwmwLlCWdjSO6LEJM7QRTMUuKbSG+J0TniE4Y4RJelmf6VTEIExprrjo0RMdjnhFIEiuMq+w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51df136a-e44c-49b5-f746-08d7d133fa8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 03:15:47.2495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUtCR1CgxspB+sNWHRXBaIVrlkuw5iPITvddisC7JyBxm1gX2E3Nj+gkvCplMadr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3071
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

[AMD Official Use Only - Internal Distribution Only]

Ping.....

Best wishes
Emily Deng
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily
>Deng
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
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
>desktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7CEmily.Deng%40amd.com%7Cd7570f695fc64ab688
>b308d7d09733e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
>7207220147577735&amp;sdata=vTgILeBbCu5CRPs2aEPs4htoiucE3pYMjPiN2B8
>mEBk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
