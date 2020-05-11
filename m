Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB31C47255
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 06:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A10320708
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 06:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="g2JGw4ks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A10320708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7246A6E1BA;
	Mon, 11 May 2020 06:26:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 426B16E1BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 06:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m01wx976uI0uWLhWyvnc6ZCb4Z66V0/DkQh9HomMuZK4mXqraaHMEHI8FskkOM1KwXxOvcpxGwTPheNc4cKltP9/9x9dol8UWf/+uobT7MGMl6q2v9/hSgDyVYyj89QzBmrn+QqOP/xq+qjWcb1idtMWmYSVt8sDEkVI1g6/Q6a01+rdRPW7NgHpU/ldzZWWRD+P9oQMHefTaCgQhsF0iYY1GSPeAxHKuJ7oZgsr0iFc0URYSyAlC9rp4lJVm1Qqs4rRWZGPzIamajp5j5xFP6gOp8jw95dszLPdS2UQ+LP0o0W0zFhTsgS73k92Tuw3diwkiMsmnj/qZAtwGk7uhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeNs6t+OdFYlf0UUiKm+aIp1pIujsjS9INDIedlzVWY=;
 b=a3E4m19ARMA8YSvyUxc8SRJA6jl1oVab64gM0MMhJePJO9OEQXQTuIfOi/ua7I/uclPJLqH192MLzwibGtwV28/X9nQSaqcbv54Dg7xzQ6E4QhMTLaq0cLNYGgpF3txWRmijhZXYGEtiSa/TmsXoEaH2LdpCfbO2w2/FFre6ZSMDEYaG8K0jMrbjoeNLvFdHKxoG9y/XRrpMdS1r89qkUDhsXGssrDFI30yazeVW/JeuBU0ZtD70w4xILqj/z34zEXyVrVT/VGgN7RlSFz7bZcZq142J+VkrN/BX6HnXP0jQ6n5/NiOhipKRAjCABTFEBo+OW1hcxpKfi5Gz1+AWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeNs6t+OdFYlf0UUiKm+aIp1pIujsjS9INDIedlzVWY=;
 b=g2JGw4ks82QRGg4C0c4OWO3clqkgpaHvPii2dgia8ZUde1fIQPtltm8QBz5U/V5QcgrkUnrqZxF1Qs2Pqbwll4Tu+U/nadMkdTAiYVS75oauFWCByq/Ctq7GJ9vhHxU91j+gpjDEjvPJ4GsM4ovV4ihILhAb6I4+dPCm5VPolA4=
Received: from BY5PR12MB3652.namprd12.prod.outlook.com (2603:10b6:a03:1a7::28)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Mon, 11 May
 2020 06:26:03 +0000
Received: from BY5PR12MB3652.namprd12.prod.outlook.com
 ([fe80::1419:8cff:b28:1d02]) by BY5PR12MB3652.namprd12.prod.outlook.com
 ([fe80::1419:8cff:b28:1d02%4]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 06:26:02 +0000
From: "Jian, Jane" <Jane.Jian@amd.com>
To: "Jian, Jane" <Jane.Jian@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: skip judging if baco support for
 Arcturus sriov
Thread-Topic: [PATCH] drm/amd/powerplay: skip judging if baco support for
 Arcturus sriov
Thread-Index: AQHWJdjGcEduqyVZo0CRx8rw83D0w6iibiEw
Date: Mon, 11 May 2020 06:26:02 +0000
Message-ID: <BY5PR12MB3652092EA8ED7FCBD34DA165FFA10@BY5PR12MB3652.namprd12.prod.outlook.com>
References: <20200509080633.4506-1-Jane.Jian@amd.com>
In-Reply-To: <20200509080633.4506-1-Jane.Jian@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Evan.Quan@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-11T06:25:59Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c4e03e14-386d-4bab-b862-0000d91534ec;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-11T06:25:59Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b675dbbc-27e6-4ece-af7a-000036b3757a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d9d92b9-6cb7-4a8f-2ea1-08d7f5742dd0
x-ms-traffictypediagnostic: BY5PR12MB4260:|BY5PR12MB4260:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4260EEF82B05CD0EA75FB5ACFFA10@BY5PR12MB4260.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4DcARDvQqKOrkRFbauF7XCwfoa1CxAP5YfmpLymCuP+Bnp1rZYgJLBP4HgBJcgGtGCCAmVPWP/n7zZ37kL69chvs/eTkfKFyzZj6hAw9inEWu5r8mlosKSNGAS2tDEPTwoKB70Va8Ptc3MJUcAjdN0guydEltmxSzfAXCwK6HsBpX9MOPIQCOKiqQkTbdZ2OkdpyFZmjxox92O/XuXED3G/ZYe9ylHZZ/+aDptkoMfYRG+4xW7i8FvzddAYr3dTC6Zgid32d+yaKYDmS3wzSwe8FKztOp3bMr1sw3CI3MNKpX/hau1U/hD77eGvrgQTE5zCJHrYZ4dEfifMmcmxx1a2rzZHlIqpE4UkS3b85nEDKkdECMIILhDPveArC3QjzIcFBky8ehoqRd2dnQctajUYwzG3NPKGMeEEvDvVoU/MJESNVNcN+iKC/emIXYH+45AAiY5mG3oEgVhD8vMmD54W6Jm31rfpMQNTPfTLx4/d1Ur5y6+TdrUy5yYcbX5eqDRgh8bhPIp5ayF6//H2ddA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3652.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(33430700001)(8936002)(186003)(26005)(55016002)(71200400001)(5660300002)(64756008)(66476007)(66446008)(4326008)(66556008)(66946007)(9686003)(7696005)(6636002)(53546011)(6506007)(86362001)(478600001)(33656002)(76116006)(8676002)(33440700001)(2906002)(316002)(110136005)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 7hrUWJ1BRtg1lCUPzyYXC8rf7BIWw4CO++/3kY3H48RiwY/mnm7fhC9jZG/tetAvJvrkciz7FOQSfCSQ4n0iGcI7YMJ8uYzgrbuxvHOaxGIkITWDOQJnP1TBLcYkJgw4NA1X6vE8ILpXLb5Qap2Sh5wqwvxGKHytfeimLfbb0thuMAL/cIHmi4SXziBqid741qTRVw37xH9hfyVb7jsSGAzLX20UsxYIM9JveQ7NxF3nJefpQ4jzeGdYrtrBM3KjGL0G9azQJ3g7sNbcK7q3jakwbp0LloXtZZJbkOaOmd6RaQOsGzvhYrPSo59GnzFMIb351zZWdrZZHQITaQBlf8S4IdnHRZgxUuLIpPm/p1qwrIg1SjwQNx4U46IzcsyxgP4kp94Y/FF6pGbxS0U/U6YN45sS1rxmhrU7rC0jf9NOv4OiPs/nyfc3mJoiXLkP40rSVGThVdrzAYcju8vmU+5AIZ/RQumliCj5euZJiqgTNxJnyDu+/vqdlOYA1s5z
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9d92b9-6cb7-4a8f-2ea1-08d7f5742dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 06:26:02.8604 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /gczTluFQxV9IPnIJaAscZDVwuIhqsO1KrnJaq/W8gE5kB4ImNckN3yRhURwSeqri+QvdcWBEhFMV9ySmvn3mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
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
Cc: "Min, Frank" <Frank.Min@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi @Quan, Evan,
Could you please help to review this patch?
Since this is previously your patch here.
Thanks,
Jane 

-----Original Message-----
From: Jane Jian <Jane.Jian@amd.com> 
Sent: Saturday, May 9, 2020 4:07 PM
To: amd-gfx@lists.freedesktop.org; Quan, Evan <Evan.Quan@amd.com>
Cc: Jian, Jane <Jane.Jian@amd.com>; Min, Frank <Frank.Min@amd.com>
Subject: [PATCH] drm/amd/powerplay: skip judging if baco support for Arcturus sriov

since for sriov, baco happens on host side, no need and meaning to judge is baco.
also, since kiq reads strap0 in here, if kiq is not ready or gpu reset(kiq resume) happens after this read, would fail to read and wrongly set baco as true(1).

Change-Id: Ib67f837edfbf09263133d5614f6dbb890cf27b12
Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 1c66b7d7139c..cfae4bcaf32e 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2251,7 +2251,7 @@ static bool arcturus_is_baco_supported(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t val;
 
-	if (!smu_v11_0_baco_is_support(smu))
+	if (!smu_v11_0_baco_is_support(smu) || amdgpu_sriov_vf(adev))
 		return false;
 
 	val = RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
