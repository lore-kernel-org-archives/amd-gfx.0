Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E7BC5518A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 03:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C25E20774
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 03:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nq+GrgQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C25E20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8A856E428;
	Fri, 24 Apr 2020 03:29:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08A696E428
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 03:29:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gz3QXN1uhub2FzZ2ueHMdTt8f87iJ46mxtnuwGUl8C4wBL6Qu2dylz/81zXjlU1L+T7Igy/13O45JXuIoXKbDu6uRbFmdSW1lkmuMdFTomOMJkj9X+4JVILEJRFP9SowBtp58QzM9ttqyYjsV/BQNPxGlB2/B6LhGvMl5mEIezsuKKTGS63zODwP2LFzjgqglXh1pLbRT7QlXpam/pijd3MO8Pb189CjHZc6BSJ8EuKKDHwIZ3z9L+1Sd97sAxlKzl1ez9zTozypk66Moulx2k7gnfSrUjl/D0tdkoATciBtTh2RmZBuneTyjuRYIZIgC5lphLYn5G+d0x6cf8QogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PC4JhWMB3uDk3AijO/lSrDmuYr/PshDNPXfOp+Fd2g=;
 b=aRLV+LnettDH2KRABbvZZTXyZOG3fnDJTU9c/eFjt6ztRbUJn87hqnaU9UHjIXLZmysXJP0H4g0MwYclexeq4JMBk+x95XMVIvvVmDOYPeMG7AT/TxJ2Wtq6zVizPdVu8se2bHG+d45cA+rIjAlnRBC7BV5VSSmncWjmu2aWKSnYY+5n2uvbQ/OMKP5yq+k3de3EkqKhKCbZEwYeZTZG8tPtj2wgebIxnR/fZifFQiKhX08oSmYxDcGi8ZzhkcvQyCUePNlSmy0l04BICcXnrbaJGH5fFDXwErM2G/N2KryPMgclh968G5OX0cLLlshQzJk9AwNFerKr7nzP+fLPnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PC4JhWMB3uDk3AijO/lSrDmuYr/PshDNPXfOp+Fd2g=;
 b=nq+GrgQKAiKeH1DToKvuZIIa7YNwX1vixVOXlsiAfHV+E51QNKQRuXaGUEDKB9sSnhd5k2eUDDYrOwO6LbES0pmnHltjomVCmuDHYvAcq2MYsuLQfVUqpbrQ2hQtc9eNAx8n8hYOZ2m6bkyr6/dRSrlUv4tWYDl5Ng79ljNb4YA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13; Fri, 24 Apr 2020 03:29:00 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2921.030; Fri, 24 Apr 2020
 03:29:00 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/8] drm/amdgpu: clear the messed up checking logic
Thread-Topic: [PATCH 5/8] drm/amdgpu: clear the messed up checking logic
Thread-Index: AQHWGT1MacTBI/6FkEyFWOkmNhw9e6iHnidg
Date: Fri, 24 Apr 2020 03:29:00 +0000
Message-ID: <DM6PR12MB2619332E61AC348CF64FE932E4D00@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
 <1587625306-20704-5-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1587625306-20704-5-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d53c69ef-00f8-411f-b443-000089def26c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-24T03:27:44Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4a8ee39-52bc-44f2-1d99-08d7e7ffa16a
x-ms-traffictypediagnostic: DM6PR12MB4170:|DM6PR12MB4170:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB41703FB48DEA486085C4161CE4D00@DM6PR12MB4170.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(26005)(9686003)(45080400002)(53546011)(6506007)(316002)(110136005)(55016002)(186003)(2906002)(7696005)(71200400001)(5660300002)(4326008)(478600001)(66556008)(64756008)(66446008)(8936002)(86362001)(52536014)(8676002)(966005)(81156014)(76116006)(33656002)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YrMmb4Z87wr5WWBLvqf9i0p6T6o5pcs9pgvwPKWIevqbSHZI3gs1G1N4yj2dnIsaHuozClDxiFsVk4OtOZDF4CcMSRSAeEm7GyNS+ejpuIJ5Z+PcAYyXdOlOLfYviwE04vLLehZTrFvg/BIvtJK3O+1ReoPHEt64K+M8tCRXfcGzBHGDF3H4kob01Z0TIoIk8NROyX+3rzbRjLwUBmy+VJ+yQA+AyjhbglFLaVDFuF2eJtpcpkc6c4P7MYuUwEYqNMuK69qNL3VZjDicOlqgf4vQfBMXtrFVQXYf0E3J5lt0d5CqCWd+92yU4gz0qPE857z+Wau17zBsGqtiSZ8W6vGA5OUdXLniDVSeJeM3V40w8zs45uZux1kINqPPmg9XrqLAljQXRhDameoIh9JZ5iuD/qQ89umJTselfEAdyr54ZHEuFn/So5nCAFMaiYK7KVwM4qWAxJTijAzd9sm/ck2omwPUInbrekvMbwrwIsU=
x-ms-exchange-antispam-messagedata: aQScu093JeBpZrS/X3PSDupQj12yQdGaN6G3YHPsmN1Dzl1AoQxkmZcwyweLsN6j9Q8OtTBAK6poHRdf+/DhWZwXOkCYlhIiDmme58mca4PnpoTB3FMotNmhvMcJ623AdkObytCWNoacXnyEeFIbYw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a8ee39-52bc-44f2-1d99-08d7e7ffa16a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 03:29:00.6007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMYpRHKY/pe705dqQnrZaZXnqQe7vJs3j0pa4OthbEUVMhqkhBiOL3/eXPOv6KDr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please make this the last one of the series.
Other than that, this is acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Monk Liu
Sent: Thursday, April 23, 2020 3:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>
Subject: [PATCH 5/8] drm/amdgpu: clear the messed up checking logic

for MI100 + ASICS, we always support SW_SMU for bare-metal and for SRIOV one_vf_mode

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 2bb1e0c..361a5b6 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -571,15 +571,10 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
 	if (adev->asic_type == CHIP_VEGA20)
 		return (amdgpu_dpm == 2) ? true : false;
 	else if (adev->asic_type >= CHIP_ARCTURUS) {
-		if (amdgpu_sriov_vf(adev) &&
-		    !(adev->asic_type == CHIP_ARCTURUS &&
-		      amdgpu_sriov_is_pp_one_vf(adev)))
-
-			return false;
-		else
+	      if (amdgpu_sriov_is_pp_one_vf(adev) || !amdgpu_sriov_vf(adev))
 			return true;
-	} else
-		return false;
+	}
+	return false;
 }
 
 bool is_support_sw_smu_xgmi(struct amdgpu_device *adev)
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C88cd44199dc3451d709608d7e75438b0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637232222119291353&amp;sdata=rDamzIdmtaTo%2FCiEzyIo015JHJcZIV5ZyVLnkrJHcec%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
