Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB99C43465
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 14:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF9B221EC
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 14:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jV4wyQ2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF9B221EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587716E379;
	Mon, 21 Sep 2020 14:40:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 430876E379
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 14:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJUNIaiL1TSq7rDI2450JEx4OOE009reMByq7gV1iMBscg9C/s+sPtIZfvXmK/50aKk7csHjUNMbtiobtr9X59mQOkLLPEfbGVmsEIc3/eA8OpMbL2Ryu8igDMOK0UpNVDeEBj2M4ajVWr+roHFbZwZDA3h4cXzxMASCTMHo92fz4HoiaMXNEQ2+BTSQttwuiN3amYiL9W8BQY1eW9GxfIPxoW1lKieS9YTpH854J9Y/JKO/8Sm6UIhSPJSEi8JzsNe3UjDTH8CggzoyRPMNfmkWSqNZY3Ue339nmmfsxqX8orz16MiHGOXNBCgq0C8KXDMji6Fn2JX+blTbiLEgrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQtUtsZp0+WGid0klDdXNIqG2gsxqOr2oOsUpGNizc8=;
 b=UPtewNq86/8EKDn9QeCZ7T2HrenLRUtcjCyL67uFNDe5odtk+28qZQn5kcHQZSIOUyy48wkzQipkpNhEqFaJduCxYvBJkP3L9rOA89l45UlXhOxbFxo+KsBvbp2TtzxMl9YaHbvJ/U2BvgPlF6bsr1faGGP8O6vaCaGGbUrVS68UpmylRBLT+7ZDv+UqNsstf/8rt3wcWXX3/2jZCA7Thiao79P8WlLQshHPkwvlm5kizMlauUyca6DjpfsGHxP8kIPps3V9SYSW1Y0Bl9trekQPiihZVLAa8FOIKSpfHxsI5IGinoToFYTtNwAU269Spj+e3yVJD/0puchXJviLPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQtUtsZp0+WGid0klDdXNIqG2gsxqOr2oOsUpGNizc8=;
 b=jV4wyQ2uHsTLDGNidMnWPVB9pZDR1sIYpzE9adX0s7Mmpjy0bXFko0OcrHGrQ1t7AQEoTXb2gMW+xVqBKgps7H55rU0AJ4+/r2/22xLOMEbRYe95BfoA2g78jxeGAndvHmy58SctBuge0PKvJfslECGkoWqdCZpYLT6mYHXGu8c=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.17; Mon, 21 Sep 2020 14:40:34 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3391.025; Mon, 21 Sep 2020
 14:40:34 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V4 1/1] drm/amdgpu: update athub interrupt harvesting
 handle
Thread-Topic: [PATCH V4 1/1] drm/amdgpu: update athub interrupt harvesting
 handle
Thread-Index: AQHWkB3m8oS4LG0oMEq+rjUWihP2cKlzKe5w
Date: Mon, 21 Sep 2020 14:40:34 +0000
Message-ID: <DM6PR12MB4075EA206E5D3134A5AC701BFC3A0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200921134824.29636-1-Stanley.Yang@amd.com>
In-Reply-To: <20200921134824.29636-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-21T14:40:27Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fc4925a5-fd29-496c-afc7-00006d839160;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-21T14:40:18Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: ebc69e0b-67b3-4f70-8226-00006c650357
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-21T14:40:28Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 9a1ebbae-0611-48aa-bafb-000090158a42
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 830f278b-fe07-4b63-c1f1-08d85e3c4c9b
x-ms-traffictypediagnostic: DM6PR12MB4484:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB448412812E575F99563ABB41FC3A0@DM6PR12MB4484.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nRNNCYX2opOocaPJpotzHxM3zK23pyoJ2a2JdTBjtZxhKQ6dcTvPftVoHH0UAPGtH7xhTBilCNdiLwuZa/ZhhJE95ggHpiX5rvYNV8GTYtSk6eTRBPShBc3LGJTgji51aMtbFsVDUtD4Jnl1z8nQ2j92cplv5ovZMgBY1j684JE7K38ic+gRF2pkcp//u6aHzYNvil/K8NsUhCi1pk3sfSsffLUvUZc6wahVZ6QCwR/gyVwPoM/4+ozI/7anE2aQw59ZYxfeM0t91Mtncm3oVtjx79Pu94YUAF0G9HMYfhDB00HNzceVJHDGESEQETEvc4Vl4wAvAN4oAUEwfhrEnw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(66946007)(71200400001)(33656002)(110136005)(54906003)(76116006)(66446008)(64756008)(66476007)(55016002)(4326008)(66556008)(478600001)(86362001)(2906002)(53546011)(8936002)(83380400001)(52536014)(186003)(26005)(8676002)(5660300002)(6506007)(15650500001)(316002)(7696005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: +1sBypAZYpWNgvB0f6eVD5M9e2+0RTRyBPS18qJsyi2Nz2bUe9UWQXxxdjnVOGfqPzr1z6Gzdv/IO2FjGcCCG35Z9WAFYjgZje3kKEqxBg4mYfu6EcweWn/bnCXvJ8avfVGzXRvrwbbUtRLyKUngOerXxX4DBbIbfLIJ833lanLfgWa8n0Y1a3uS8OTosuq/7UHimjvjWNCVKITt9R/lM0PZR6DYal5eq6T+epcJB8Nikhy0l2l5tIdDBqlVaOpVwYk1kdLQxjlqUj5U+g2VgVPqBA7IPb3hfPCVAEP0og0AcOabhSjgSdF3X37c7MboIUuYgJA99tw665e1BSgV3ujhkL4Z/fc/IFzF7DyLRxxsuD2uuPBcdbMqAqjhdQzDl952ZKKGhSfFoRbO8ccdt2gLQqXXowSqpvgPsezC2LHjeWRiwfnS+eE323Nn4uagCBALRmtUcR4dmQw6G7Wa/60faOlCAthhhUHQ0cEwFq3axS5ttmL/g+ITiWVfPq5NysmrWQ3M3Tv8NpZjdlT6xBK8iMiAYkOsqGnjzHIP4TaAk+xSp+3ejGvzXYdXpOOSb5OTyyW7FX5q61XlRhYawx4OxVigoDzbr6pCoaIgkTMKZdaypu5cDgHWlm1zg6Qc9btpgMK0VIL8YzGTBbZmrg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830f278b-fe07-4b63-c1f1-08d85e3c4c9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 14:40:34.6930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +G3OKlU2dVM1W/RCWcgFHXgvefapt9XnDVsNZeLTyVR9rEKlCFMpBrRepOref7+dCiZo0ILVuP0rakpSWhl5kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com> 
Sent: Monday, September 21, 2020 21:48
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Clements, John <John.Clements@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH V4 1/1] drm/amdgpu: update athub interrupt harvesting handle

GCEA/MMHUB EA error should not result to DF freeze, this is fixed in next generation, but for some reasons the GCEA/MMHUB EA error will result to DF freeze in previous generation, diver should avoid to indicate GCEA/MMHUB EA error as hw fatal error in kernel message by read GCEA/MMHUB err status registers.

Changed from V1:
    make query_ras_error_status function more general
    make read mmhub er status register more friendly

Changed from V2:
    move ras error status query function into do_recovery workqueue

Changed from V3:
    remove useless code from V2, print GCEA error status
    instance number

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 43 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c         | 29 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h         |  2 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c       | 29 +++++++++++++
 .../amd/include/asic_reg/gc/gc_9_4_1_offset.h |  4 +-
 8 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index a611e78dd4ba..258498cbf1eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -217,6 +217,7 @@ struct amdgpu_gfx_funcs {
 	int (*query_ras_error_count) (struct amdgpu_device *adev, void *ras_error_status);
 	void (*reset_ras_error_count) (struct amdgpu_device *adev);
 	void (*init_spm_golden)(struct amdgpu_device *adev);
+	void (*query_ras_error_status) (struct amdgpu_device *adev);
 };
 
 struct sq_work {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 0c43d7fe893c..1ae9bdae7311 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -40,6 +40,7 @@ struct amdgpu_mmhub_funcs {
 				uint64_t page_table_base);
 	void (*update_power_gating)(struct amdgpu_device *adev,
                                 bool enable);
+	void (*query_ras_error_status)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_mmhub {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e5ea14774c0c..40614ac9a111 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1498,6 +1498,45 @@ static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
 	}
 }
 
+/* Parse RdRspStatus and WrRspStatus */ void 
+amdgpu_ras_error_status_query(struct amdgpu_device *adev,
+		struct ras_query_if *info)
+{
+	/*
+	 * Only two block need to query read/write
+	 * RspStatus at current state
+	 */
+	switch (info->head.block) {
+	case AMDGPU_RAS_BLOCK__GFX:
+		if (adev->gfx.funcs->query_ras_error_status)
+			adev->gfx.funcs->query_ras_error_status(adev);
+		break;
+	case AMDGPU_RAS_BLOCK__MMHUB:
+		if (adev->mmhub.funcs->query_ras_error_status)
+			adev->mmhub.funcs->query_ras_error_status(adev);
+		break;
+	default:
+		break;
+	}
+}
+
+static void amdgpu_ras_query_err_status(struct amdgpu_device *adev) {
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_manager *obj;
+
+	if (!con)
+		return;
+
+	list_for_each_entry(obj, &con->head, node) {
+		struct ras_query_if info = {
+			.head = obj->head,
+		};
+
+		amdgpu_ras_error_status_query(adev, &info);
+	}
+}
+
 /* recovery begin */
 
 /* return 0 on success.
@@ -1568,8 +1607,10 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		}
 
 		list_for_each_entry(remote_adev,
-				device_list_handle, gmc.xgmi.head)
+				device_list_handle, gmc.xgmi.head) {
+			amdgpu_ras_query_err_status(remote_adev);
 			amdgpu_ras_log_on_err_counter(remote_adev);
+		}
 
 		amdgpu_put_xgmi_hive(hive);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d898c9ff3526..adee0177654e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2075,6 +2075,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_gfx_funcs = {
 	.ras_error_inject = &gfx_v9_4_ras_error_inject,
 	.query_ras_error_count = &gfx_v9_4_query_ras_error_count,
 	.reset_ras_error_count = &gfx_v9_4_reset_ras_error_count,
+	.query_ras_error_status = &gfx_v9_4_query_ras_error_status,
 };
 
 static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev) diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index bd85aed3523a..bc699d680ce8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -992,3 +992,32 @@ int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
 
 	return ret;
 }
+
+static const struct soc15_reg_entry gfx_v9_4_rdrsp_status_regs =
+	{ SOC15_REG_ENTRY(GC, 0, mmGCEA_ERR_STATUS), 0, 1, 32 };
+
+void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev) {
+	uint32_t i, j;
+	uint32_t reg_value;
+
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		return;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+
+	for (i = 0; i < gfx_v9_4_rdrsp_status_regs.se_num; i++) {
+		for (j = 0; j < gfx_v9_4_rdrsp_status_regs.instance;
+		     j++) {
+			gfx_v9_4_select_se_sh(adev, i, 0, j);
+			reg_value = RREG32(SOC15_REG_ENTRY_OFFSET(
+				gfx_v9_4_rdrsp_status_regs));
+			if (reg_value)
+				dev_warn(adev->dev, "GCEA err detected at instance: %d, status: 0x%x!\n",
+						j, reg_value);
+		}
+	}
+
+	gfx_v9_4_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	mutex_unlock(&adev->grbm_idx_mutex);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
index 1ffecc5c0f0a..875f18473a98 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
@@ -34,4 +34,6 @@ int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev,
 
 void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev);
 
+void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev);
+
 #endif /* __GFX_V9_4_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 6c6ad529c65c..c2ef8142136e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -1624,6 +1624,34 @@ static void mmhub_v9_4_reset_ras_error_count(struct amdgpu_device *adev)
 	}
 }
 
+static const struct soc15_reg_entry mmhub_v9_4_err_status_regs[] = {
+	{ SOC15_REG_ENTRY(MMHUB, 0, mmMMEA0_ERR_STATUS), 0, 0, 0 },
+	{ SOC15_REG_ENTRY(MMHUB, 0, mmMMEA1_ERR_STATUS), 0, 0, 0 },
+	{ SOC15_REG_ENTRY(MMHUB, 0, mmMMEA2_ERR_STATUS), 0, 0, 0 },
+	{ SOC15_REG_ENTRY(MMHUB, 0, mmMMEA3_ERR_STATUS), 0, 0, 0 },
+	{ SOC15_REG_ENTRY(MMHUB, 0, mmMMEA4_ERR_STATUS), 0, 0, 0 },
+	{ SOC15_REG_ENTRY(MMHUB, 0, mmMMEA5_ERR_STATUS), 0, 0, 0 },
+	{ SOC15_REG_ENTRY(MMHUB, 0, mmMMEA6_ERR_STATUS), 0, 0, 0 },
+	{ SOC15_REG_ENTRY(MMHUB, 0, mmMMEA7_ERR_STATUS), 0, 0, 0 }, };
+
+static void mmhub_v9_4_query_ras_error_status(struct amdgpu_device 
+*adev) {
+	int i;
+	uint32_t reg_value;
+
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(mmhub_v9_4_err_status_regs); i++) {
+		reg_value =
+			RREG32(SOC15_REG_ENTRY_OFFSET(mmhub_v9_4_err_status_regs[i]));
+		if (reg_value)
+			dev_warn(adev->dev, "MMHUB EA err detected at instance: %d, status: 0x%x!\n",
+					i, reg_value);
+	}
+}
+
 const struct amdgpu_mmhub_funcs mmhub_v9_4_funcs = {
 	.ras_late_init = amdgpu_mmhub_ras_late_init,
 	.query_ras_error_count = mmhub_v9_4_query_ras_error_count, @@ -1636,4 +1664,5 @@ const struct amdgpu_mmhub_funcs mmhub_v9_4_funcs = {
 	.set_clockgating = mmhub_v9_4_set_clockgating,
 	.get_clockgating = mmhub_v9_4_get_clockgating,
 	.setup_vm_pt_regs = mmhub_v9_4_setup_vm_pt_regs,
+	.query_ras_error_status = mmhub_v9_4_query_ras_error_status,
 };
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_offset.h
index f41556abfbbc..629a8a3b55e9 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_offset.h
@@ -205,6 +205,8 @@
 #define mmGCEA_EDC_CNT2_BASE_IDX                                                                       0
 #define mmGCEA_EDC_CNT3                                                                                0x071b
 #define mmGCEA_EDC_CNT3_BASE_IDX                                                                       0
+#define mmGCEA_ERR_STATUS                                                                              0x0712
+#define mmGCEA_ERR_STATUS_BASE_IDX                                                                     0
 
 // addressBlock: gc_gfxudec
 // base address: 0x30000
@@ -261,4 +263,4 @@
 #define mmRLC_EDC_CNT2                                                                                 0x4d41
 #define mmRLC_EDC_CNT2_BASE_IDX                                                                        1
 
-#endif
\ No newline at end of file
+#endif
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
