Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82760C3B19F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 14:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575FF2467B
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 14:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Asb3qUNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575FF2467B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 109AC6F95B;
	Fri, 14 Feb 2020 14:59:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21EBC6F95B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2020 14:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYsuwZfjvJgolIxB3do+ViwC7uTtTIsNzlLLwIRdCOHm2DomTFDIbkLy8+uzN2X74L3MPj3knqbagFtWROde/TgPMRjKA7Bgk3j8CI+F+wJ6wAosjZoD/wiP8RsnJ9MUTA07rKOoD91JlgGs4Sy+aAz6KkI/K2/Z6zV3C29EXu9+dfsWCurK/vduhkVLtOe2jcNJao2lF3bkfmDtZDpW1qXZy7592ES3ls7wjGN9Gd8C40wN6fXeY/PBc+eYt//qQEmozI8cw8WeXnrGUTLjAyK4olykGPU0G0vmACBhxPGonG1Hfbd4Y2yXjPF3weah2ab8Hn2wcbpHDxd7w4xMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+jrBQhQfizs9jdORVASY4JjEpgsX4ensix/cuoXCNo=;
 b=L5fusTSf0gEYcaryJfwhua7eTgrVEAODdVRIiLXAKlxBWV1yzITXe/gZi6DsaDhR6KOSfHcPbRqXFbTgLsf5WongaWCjrW3UGpeFtF+oG2V+H5mgkBHoinZOLb/gcD3a8YZXyjsv80MLCkO/4Q74Z7IXGWIQHcnggqE5+pYydspdE5FHbgFLnoALPmWqk46GFxqMBYgCL9AQ0GJzCAQlgaNxn6F356c3rof4PL3iENO/bKO+vn3oGagcjPENBxGxZUsVZrShkBXsCKMl6XFzjlbBLSGj16l5Jz8TiFvcE0ZbvLG4P0wDRdrVTK8NjwwwsZ3wZ/ZmAksqa/t2++XKag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+jrBQhQfizs9jdORVASY4JjEpgsX4ensix/cuoXCNo=;
 b=Asb3qUNNJAYZhyEMPIrNfe+ve/eFGnyipxwugKSZwZ/626LqyXwn481UOPfmBMAaRQ81LQmNRsf2smSHHqK1rzSb1mkkNnbGqEQuPuoeC1S1Flsy4xLbotirCUDSxslHs01orFxCxY83gtVWkHhzyZwjCaGoHvnYhsci5GDBo30=
Received: from MWHPR12MB1424.namprd12.prod.outlook.com (10.169.206.135) by
 MWHPR12MB1517.namprd12.prod.outlook.com (10.172.56.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Fri, 14 Feb 2020 14:59:27 +0000
Received: from MWHPR12MB1424.namprd12.prod.outlook.com
 ([fe80::c95f:57e0:d490:6abd]) by MWHPR12MB1424.namprd12.prod.outlook.com
 ([fe80::c95f:57e0:d490:6abd%2]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 14:59:27 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: record non-zero error counter info in
 NBIO before resetting GPU
Thread-Topic: [PATCH 2/2] drm/amdgpu: record non-zero error counter info in
 NBIO before resetting GPU
Thread-Index: AQHV40APgj7XokYSQUe9EmPjsGXnq6gax/6A
Date: Fri, 14 Feb 2020 14:59:26 +0000
Message-ID: <MWHPR12MB14246036D67146A286A0128EFC150@MWHPR12MB1424.namprd12.prod.outlook.com>
References: <20200214140650.2133-1-guchun.chen@amd.com>
 <20200214140650.2133-2-guchun.chen@amd.com>
In-Reply-To: <20200214140650.2133-2-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-14T14:59:24Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e415770b-a5f2-4ef3-8ac9-0000880e266e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-14T14:59:24Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 1be9d354-340e-4ce0-bd9c-0000e7726f4e
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37ea0886-4b1f-48cf-831c-08d7b15e7caa
x-ms-traffictypediagnostic: MWHPR12MB1517:|MWHPR12MB1517:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB151735D7F7DC81235B1057D0FC150@MWHPR12MB1517.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(199004)(189003)(8936002)(9686003)(53546011)(6506007)(7696005)(5660300002)(66556008)(66476007)(86362001)(52536014)(6636002)(55016002)(2906002)(64756008)(66946007)(66446008)(76116006)(316002)(26005)(478600001)(33656002)(186003)(71200400001)(81166006)(8676002)(110136005)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1517;
 H:MWHPR12MB1424.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nmol/wnFWf9or6+fEKyuelfdvjm9cXTyRORq9TFa5Ihd33OU64JnC6Yq9B6DK/A5kvUpGgOzAlidIH5JwLRXqSfJDkNl9d704XfK93mNyoaLXXa4IvvfpFFtvLo3zsoqusCZjRUawWRohSbC0Fq0OWesQqVlAoBcLX8PfEKOHxZ9c4974JnywiIbSsJXa8o1XUEhCa4MFEp6daH8OBnfWofFwvs7MWN6NU5fyUXkEtSQ0oDVTk8Na+TqPhJUpmRDDc9WhJCYtcDJItUVNpB2EAnYEk6ezEAPuUUaT7JJFkPB8UfTi/I5l45t7d8DuEswzczsC0iqFXVIVFWIAvH7URDQPjXJSflmh0896UkYxM44Y1Apu00w6hJe53LvrDz1tlzYlmJHqYHcDl+7LaTdbCcwB0foxiJbwPv2gkuWKpxe0uVxow4oxy9tMtoNEQ0i
x-ms-exchange-antispam-messagedata: 5nILtZWS+ePJHGw7xmycwMpm5raQhPVFz4vS8cplqkP915dydUcXMw463LDLSZtdt3y50z9cvro4jTHsC5NR/K5mkIYqOgghligD1lzbMKqq22dO204+42ubNC3e7bBe22jRxaWGQxH0fxQ8pGwM6g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ea0886-4b1f-48cf-831c-08d7b15e7caa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 14:59:26.9667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +KSDNOocjCe7mvHnM1txwKnumCC00jCSrzaxW6W5PbDnZ9g7KHsmQDLX0PQeLfNa21BFNsB4HHzELdCYHLjPmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1517
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Friday, February 14, 2020 22:07
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: record non-zero error counter info in NBIO before resetting GPU

When NBIO's RAS error happens, before trigging GPU reset, it's needed to record error counter information, which can correct the error counter value missed issue when reading from debugfs.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 65eb378fa035..149d386590df 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -318,6 +318,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device  {
 	uint32_t bif_doorbell_intr_cntl;
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, adev->nbio.ras_if);
+	struct ras_err_data err_data = {0, 0, 0, NULL};
 
 	bif_doorbell_intr_cntl = RREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL);
 	if (REG_GET_FIELD(bif_doorbell_intr_cntl,
@@ -332,7 +333,19 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 		 * clear error status after ras_controller_intr according to
 		 * hw team and count ue number for query
 		 */
-		nbio_v7_4_query_ras_error_count(adev, &obj->err_data);
+		nbio_v7_4_query_ras_error_count(adev, &err_data);
+
+		/* logging on error counter and printing for awareness */
+		obj->err_data.ue_count += err_data.ue_count;
+		obj->err_data.ce_count += err_data.ce_count;
+
+		if (err_data.ce_count)
+			DRM_INFO("%ld correctable errors detected in %s block\n",
+				obj->err_data.ce_count, adev->nbio.ras_if->name);
+
+		if (err_data.ue_count)
+			DRM_INFO("%ld uncorrectable errors detected in %s block\n",
+				obj->err_data.ue_count, adev->nbio.ras_if->name);
 
 		DRM_WARN("RAS controller interrupt triggered by NBIF error\n");
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
