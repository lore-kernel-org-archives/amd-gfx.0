Return-Path: <SRS0=BIvg=DA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE8CC4363D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 07:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1078F221F0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 07:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nUUkF36V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1078F221F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BAF46E441;
	Wed, 23 Sep 2020 07:03:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA6506E446
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 07:03:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJ/zVpRYupuNZGDXPCXNgp+ucX4IkTYC0oZHFH2StgUt30Ag2NQ0R+MRlX6rXodHvv1s/OH/Fcz5ujC+OvgULkXHiMCxpnmrmczV8mihUXGJ2RUW3CndyPlcdhzg+/+r0FQI/cngZFe/8OntcY2HuCnRdoLIzpBFsDNsQMPnh0BvnbbR21JNfW3qO0IFJBl3rkjYZMWLReuuDD1iwp6cp2Rl3AtyLLCNDHXyPX8v1u2T0qgrmGE7bmGsMkIlwIT5NdWG8aL6czqrl53z2TjuI5k1hIP4gyKzop0YYbHE+eLmpxN19i1jRk9gnhBrxRoVIRWPQH/KLlAHqWNxzY73yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2N2KobbqIXvhEe8LqOMcHlMYlNj+k8wBaPzsoCqufY=;
 b=iKb4uBAu3EKQn68nzdHY4LCuEdbq1Ew8t+KTtsuJK/JHpw4F65QT4A0TDRhnAIXctAjn01p9TDWxQIlGp6kEtMtKJWW2RGmoMHU3cS46eZ1zhdFCS59o82CFwDdd4PqveAnsZET8bRI1Xl/8CS8BU5f5olXHxs3gWQIN2hmdoCRyX6npfYvuHphccaAs7qGX1/ag7+riPE5gep6S9lh0AfXkOyH0rspn43Je0NjLEXM7V57S3BSSDuujy+8ieJtP/VnN2TwWCmM4c+F/NZc9jRR2w5WzDb3VWA17ATVKIRCSCBX+lTOKajfPw30xvWZnj38dMakNHSlDNExwGqR/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2N2KobbqIXvhEe8LqOMcHlMYlNj+k8wBaPzsoCqufY=;
 b=nUUkF36Vi0p3+dKp2HGc4JVvfbnfqbRXpSWy90Lt14GSikZICLfv6V9bB9EPgGjW1d5dj0CdwCzCV0S97YykXiJJwyfd0OrTvzVTM2DCLVlhCwo6crWagLJxlCYzi+li/anKPPiYgsniOEqDBdtihV4svC/R1ebNaK6/ezzrEh4=
Received: from CY4PR12MB1623.namprd12.prod.outlook.com (2603:10b6:910:6::16)
 by CY4PR12MB1512.namprd12.prod.outlook.com (2603:10b6:910:3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Wed, 23 Sep
 2020 07:03:15 +0000
Received: from CY4PR12MB1623.namprd12.prod.outlook.com
 ([fe80::9d61:d60c:1042:b493]) by CY4PR12MB1623.namprd12.prod.outlook.com
 ([fe80::9d61:d60c:1042:b493%3]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 07:03:14 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Cui, Flora" <Flora.Cui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: fix return value check for hdcp_work
Thread-Topic: [PATCH] drm/amd/display: fix return value check for hdcp_work
Thread-Index: AQHWkXZgVlRwBzjQRES2ohgTp7M1PKl1zEBw
Date: Wed, 23 Sep 2020 07:03:14 +0000
Message-ID: <CY4PR12MB162302578D0F0D12713DB389FE380@CY4PR12MB1623.namprd12.prod.outlook.com>
References: <20200923065401.38979-1-flora.cui@amd.com>
In-Reply-To: <20200923065401.38979-1-flora.cui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d54222f0-b033-4601-8032-9424e3e98b58;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-23T07:03:07Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 198a852c-1c0b-480c-885c-08d85f8ebdf3
x-ms-traffictypediagnostic: CY4PR12MB1512:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB151286C0C14366407A966551FE380@CY4PR12MB1512.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xq0CNy2s0CbU+NvsYY4HTHbduttsBVnQqkDwDNb/A6g/DqtgVSO4BH9uA10G5VkXv959rdGwrA0jclLWTwNjM4CNPkxxl3tmDWGdhEbYQHxln/Y0gcfTrXvauTg8Q0L/ZCbQZSyxJhrKdKtErOGx72ERtDb5qp08PnIbGA70wJ3eDTWNs+zJXIAGALP1IZnBUBG0gbIsDruEEmpUbcrzdbGzDDa4wbYPwxegaQFqmu9FPuBTLQzFATTGPuT1qaehxJVZ7P6tnCebX3FqVxqexT3pg0ZA4NXZbCksw3sDeulta7zAJtpAz1patohWRNJWdkNxA99+Qe63jewPilZ0mx4nX06TqUYtwRNKfP4tul0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(5660300002)(86362001)(71200400001)(966005)(8936002)(52536014)(8676002)(45080400002)(478600001)(55016002)(9686003)(316002)(83380400001)(66476007)(66446008)(64756008)(66556008)(66946007)(76116006)(26005)(186003)(7696005)(53546011)(2906002)(33656002)(6506007)(110136005)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: qWeheT+9Vr9VFQfr1u5sm4l+4TwoZl1MVWpqbcMqcuDqjRXebbGI+UN+Ta5LNr+MP4THGFtntffFmkKNPnEwstYleXw/kBYh2gGSxosYL5mV8IxKBfTjnlsdCHYovzGWx5Sko+hyrS/aFCBYujI1oRoUKBKYxSzUQ8OWVVvnvJTuYW1xMWBgJGllBTOoxGIWZvpPc9nqPnQ246LRt7K6gaBPCd+M2ag4bJtdhQ3AdFY3yLdXcuVvjJg/KTd8vUoKTiHnBCtC5RfM3IwLCAT6jzjeFqhc8AemCTxK06UiQsdDQ93hv7xjePeHwb1nPcz4aPZ30Ufu5UXb/oJwxXcW6WRJ+sDriRmFpRc1LdxDrkwXyV6QQqy2OvaVUaU92iaDk1lZ3cKrm0fU5RBkC2x0BrsQ4BshBkmhY5/0O6QgS8pBtsatGks7CepD54DlcIJrAj2fkk+VVISjxrlxAtLxUPjfTakYrLyV7R756J0Ybx2mzSm8uGGZFj+EfLqhqdnOGyaoMtfViRpiElcDTuK51VTcnIIxRO+Mdykm/cMeAqkK84TJzz2kJNDmWp+vyybxG+PIFODBEBKBQt3eOzcf9Bo1GoteW6z0wWdisQjfFpFV+nlAISXZU4WodsezOxOy+u25MnuKTI1wJPY7zof4kw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198a852c-1c0b-480c-885c-08d85f8ebdf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 07:03:14.8104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T3RalBYqwAZExPSlA2teaGnMbTSFAVxrqxlJjTFToUN+FFyWi5aa5+f69vzoaA++
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1512
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
Cc: "Cui, Flora" <Flora.Cui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Flora Cui
Sent: Wednesday, September 23, 2020 2:54 PM
To: amd-gfx@lists.freedesktop.org
Cc: Cui, Flora <Flora.Cui@amd.com>
Subject: [PATCH] drm/amd/display: fix return value check for hdcp_work

max_caps might be 0, thus hdcp_work might be ZERO_SIZE_PTR

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 694c5bc93665..c2cd184f0bbd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -604,7 +604,7 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
 int i = 0;

 hdcp_work = kcalloc(max_caps, sizeof(*hdcp_work), GFP_KERNEL);
-if (hdcp_work == NULL)
+if (ZERO_OR_NULL_PTR(hdcp_work))
 return NULL;

 hdcp_work->srm = kcalloc(PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, sizeof(*hdcp_work->srm), GFP_KERNEL);
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CFeifei.Xu%40amd.com%7Ca62e4acb342a497ae9b708d85f8d8188%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637364408659753568&amp;sdata=Nd%2FAYwpHlCtA9OH1jwwIo8FySKOMVUQD7GyuIsER%2F4g%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
