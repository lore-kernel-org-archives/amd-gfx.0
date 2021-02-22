Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A40C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 16:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD35764E61
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 16:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD35764E61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56DFB6E53C;
	Mon, 22 Feb 2021 16:15:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C40786E53C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 16:15:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ao+4W8Sb80Gr7gZx82j3iCj/Gzz9SzxHYdBoM3Moeed0OKbnwDAu3xyv4GI5dkzxdAlbUaT/d9Uw+20mqSulaRogLJMlJYEbLC7v6VTJM+saWcv1VOZ+gdK58/tpdmoKXgLz+W/yU1RcObgK8jwYymmh7JodI+gJauVRv4G2czxyjIzICudzdrQeEmCC4SGYVn7BL1aLCCHbLSRwzfiOEMHotB9/D/gltW+Z/8MLi6GBhjtN/btTT7h9mm2M292XunXzVfCly/6Mvk6Zww9GyzwXqzsYQ0JMSJ2IoPFO6B7YuL9hGJLCbexlIu1FegEAMIeIxc5A6C4gLG/G2rfFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpWjpNfl2xcM+LIOyW8Gxsk8S11e8pAEU4cX0yTqNjM=;
 b=TG38D9/oNBclYwBwq3bPam+H5jDSqPE53GMCL7qWy1Yaltd0vVw2wywUXK7JXJRGXqTAKNnIjPsjXKK52A5Peaj1NcE9RYvNGkfqKYDugMvMtNgz2E6cnkjs6/MQDaB8VHIi3SC6hkHdnc8mLhL7xTjtRikPmPuvpWbnUFnDL/yID7TzYnkrKA79Ctxntouzq1b8IUbcDOqM4LwKx8BNad+Rh/GqyFF0h58saBLyrD4KgMj108Eg+IwS7ljQKUFUHDPc1TjTH9Ey7/iOiRK/9aRR6zDmKTazTJu7ijS0W7bw88qvIOvSREDdFXWS2OKZL0UWZY5fP1vL+xLZRXwkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpWjpNfl2xcM+LIOyW8Gxsk8S11e8pAEU4cX0yTqNjM=;
 b=WGQXS7J7xMawK8i327dK7wgdU3a+czotzpTLM3Ymf6OGnhSN4LrqOsQ/19CSlrc6/2XmphKX5HhtibLzop42V+iK0+ctah6tb080KasJruSL8//Dh38+DoJnKs1FW+DnggsKwXl7JFtY7Q6wGwQNmIYevoXJrTnSTr7iQ4CE/4o=
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Mon, 22 Feb
 2021 16:15:12 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3846.046; Mon, 22 Feb 2021
 16:15:12 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: Init the cp MQD if it's not be
 initialized before
Thread-Topic: [PATCH 4/4] drm/amdgpu: Init the cp MQD if it's not be
 initialized before
Thread-Index: AQHXBl1blMI1E4ZRTUSGKPBamN9d4qpkXv9Q
Date: Mon, 22 Feb 2021 16:15:12 +0000
Message-ID: <DM6PR12MB3835F0A07207B0356F0D27EFF4819@DM6PR12MB3835.namprd12.prod.outlook.com>
References: <20210219011954.28566-1-shaoyun.liu@amd.com>
In-Reply-To: <20210219011954.28566-1-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-22T16:15:06Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=558bb6bf-9161-443e-bf88-f3cca32c6bcd;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3bc0:316:c0d5:387b:19b:615f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b7831eb-977e-451d-ad84-08d8d74d0867
x-ms-traffictypediagnostic: DM6PR12MB3308:
x-microsoft-antispam-prvs: <DM6PR12MB3308EBE6E81D74D309E5CF36F4819@DM6PR12MB3308.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: muDPVHLXUNPO87PdW+N2Za2wbF2hvIwCEkntAeOfr7FPFKbCEKvlLAGYUElzVRAgDQWbeMW+dkiJSnmAtWjQbh+oGXFhRQjqJYhEwl5McrSs6uyubnjrwZ00vcNmUhgUWxxe4CRd4lGT8AVkqyt1SAQgZZbAFxEAO2JzTeHkpfYU36VzxTSsOHF5TiSI+Wi1DLG2MJ+yWxlfWavT2hIdoKYe7lvKZxttSgHfu0Ixt7+zK4vWv4SX/CuDAKwNVAkxLm5prng6amrdn2AlkKGxPEfhPu6fTIIKvOi7wBLwFEy9fAs9DEbZD6+dTKpdkoBVa/XZEFvAuqwuok+9KAdXMuTZDccB0JX8Cj+qn3WsGZV3QvJ5kVP6/G3wl2T+JDNJ+XJ3s+yhq52T2ryV2S9aXG0x+r0ORKAgRxeLFNcnmiojrhwOIhqmqabJ0sVoZD34dxwzab0ZOm2HlifmgMokDuiEqqr3difaOKCls1+094hjumWfzR+U6wyhuVXr2I9bdemCkmSylT7BE0/rvlFNRQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(478600001)(66556008)(316002)(33656002)(6916009)(2906002)(53546011)(64756008)(76116006)(66476007)(52536014)(55016002)(186003)(5660300002)(66946007)(7696005)(66446008)(9686003)(8676002)(86362001)(71200400001)(6506007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xSV6jjLeELSS45/UVaKhBJpQYXRxcRZ0+F1TEcPaAEdjZcwKMDJvY5SNRSLP?=
 =?us-ascii?Q?ibzbSBx7vbQpkuhmXLk8FeSp+BcDkJssayvfL1N+vqJyZLO03YaMnmedj5kN?=
 =?us-ascii?Q?1aIPtpNxh94hqk/RI6FW1PP0bxXsNMjXM9IhM2hEwIQ/ikpxq8w+3Ot5Ytc4?=
 =?us-ascii?Q?yx4w1eG/PSd7cI6PMsb0nBA2vSb8f3Razl1MKhF+N337WeqHYxRxsgWSBXFB?=
 =?us-ascii?Q?Ob6C5Y9pRgZs1pQOm/ME/HEfUw300PhllkHvIxaHUPOHcki5XVzkFz0R0Q16?=
 =?us-ascii?Q?yAvjhUJ+qUJ9I+3SkRMtbx/0IGEW/rtl8th6OZN9j6Nr2MSxzJ3yjWCceMXh?=
 =?us-ascii?Q?EnAxTyNU/PAoujLnE3SZAf7Jqi5098d5wqFE9OaxSi+Rc8VDYkotC6qocJvF?=
 =?us-ascii?Q?13UiMX8weJEEJ3mpkaY3lIw5DM111svl5GbhC1ERg3xacOO4VsbLh6EGUF4c?=
 =?us-ascii?Q?IXzRZvBnWNsJvFUl7yvlDumR8FcD1JrXqNkPhtTYnOhG3vMMicDK4otbSQkf?=
 =?us-ascii?Q?8SbjE7qpNFnySlh9lsoRX4SV742u6NU51xDSGAKDcgf/Fa9mQQY/VWxZwz1w?=
 =?us-ascii?Q?t2rH0DdqdiCdgsttt2cCDHz+dKsOeHIsVdEuHsKWI81jIRuISLmLh2vmD2NH?=
 =?us-ascii?Q?ES4xp/gd28VW5uA6cmJt7Hk4Rw3hQEd6ycrSXQ59PZJR22xgjBmufrljos7y?=
 =?us-ascii?Q?jdsRbSPsv+58KWxtotp1+fC4Y9o4YEyjKm9dxzunICkUS9ow7TRK0HMxCAk8?=
 =?us-ascii?Q?sAUKcdJ/txapcpI7ZlUe8wbIjDrxL4xoR3IJYfM8Adis1O2oCCoQkyKFyXXA?=
 =?us-ascii?Q?Ao2cAUBysi7XVE1tJJvkfBnnXsKWMLIXap/ZTcYUWw0x05bEhfYTNT1ptfqC?=
 =?us-ascii?Q?SyZjrMkXhQaoCdijmhPRELzRldNBQfMk19NUzQAEg5qVtz343qb5IMRFfTUd?=
 =?us-ascii?Q?cs8nla1QfCgbDB2WEFixjoyT1Doy4vl9gTzgVXGbPXXmTaQ3mdCeZ0y2WF2t?=
 =?us-ascii?Q?se4hZY7buQz61i3QP1E085a6wyIj8d9EyolqjO2PsmQIRoiPd4j3gljNqi1m?=
 =?us-ascii?Q?GrZtNwIp7GzCmoAAMaNRzgyq+giX4YCEg8gCz6KRM3KCUoJ6NYYMOuwLzyk7?=
 =?us-ascii?Q?Z8ZTHRst2RViimrxUN+SEXD7AzAEEb0ifAVOe7Qucwqcqi3SaNALhQUU2Ijg?=
 =?us-ascii?Q?M37dM9J9APEuf6rIzJc8Ro8YUl2KVNVR/HCVH1+7jaBgFfXGypfBxnEEpqNP?=
 =?us-ascii?Q?Mh+7hrgZPftwBjHPmf7fjdn3Ivh0HSiHGbFziYEbE3pMtNhpUUarJJ1X769H?=
 =?us-ascii?Q?vSA3Z58SklfB1NlI28aLCCvPyoiEzQrHvK5eHdt0Hr4M90dumWaqLo80Omza?=
 =?us-ascii?Q?hXtg5KcWt9flhkmqeIW5t/Xlv/nt?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7831eb-977e-451d-ad84-08d8d74d0867
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 16:15:12.5631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PY955Jgyunyk9ZQmxaYfbk0vi9mrK7uVfhV7uWUTlXY+QO0pts+Pg/BgKWLxGmUpgE1/5idaRgbnu5TBxx3E2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3308
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



-----Original Message-----
From: Liu, Shaoyun <shaoyun.liu@amd.com> 
Sent: Thursday, February 18, 2021 8:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Init the cp MQD if it's not be initialized before

The MQD might not be initialized duirng first init period if the device need to be reset druing probe. Driver need to proper init them in gpu recovery period

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: Iad58a050939af2afa46d1c74a90866c47ba9efd2
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 65db88bb6cbc..8fc2fd518a1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3696,11 +3696,18 @@ static int gfx_v9_0_kiq_init_queue(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	struct v9_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = AMDGPU_MAX_COMPUTE_RINGS;
+	struct v9_mqd *tmp_mqd;
 
 	gfx_v9_0_kiq_setting(ring);
 
-	if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
-		/* reset MQD to a clean status */
+	/* GPU could be in bad state during probe, driver trigger the reset
+	 * after load the SMU, in this case , the mqd is not be initialized.
+	 * driver need to re-init the mqd in this case.
+	 * check mqd->cp_hqd_pq_control since this value should not be 0
+	 */
+	tmp_mqd = (struct v9_mqd *)adev->gfx.mec.mqd_backup[mqd_idx];
+	if (amdgpu_in_reset(adev) && tmp_mqd->cp_hqd_pq_control){
+		/* for GPU_RESET case , reset MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct v9_mqd_allocation));
 
@@ -3736,8 +3743,15 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	struct v9_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.compute_ring[0];
+	struct v9_mqd *tmp_mqd;
 
-	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
+	/* Samw as above kiq init, driver need to re-init the mqd if mqd->cp_hqd_pq_control
+	 * is not be initialized before
+	 */
+	tmp_mqd = (struct v9_mqd *)adev->gfx.mec.mqd_backup[mqd_idx];
+
+	if (!tmp_mqd->cp_hqd_pq_control ||
+	    (!amdgpu_in_reset(adev) && !adev->in_suspend)) {
 		memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
 		((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
 		((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
