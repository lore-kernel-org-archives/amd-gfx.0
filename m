Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C6FC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 03:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D4164E3F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 03:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D4164E3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 586B589CE2;
	Mon, 15 Mar 2021 03:58:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B63E89CE2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 03:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ervOI6Jdj4aPSPrjk3sr85cBLzPPD/jjO8Q3gBvry+QL2hzST3zkyUVVDYPnfPhQPqxn0RheBR4ONO/c5oRNi8u2bIHCbx0KfXn9oaCmW+yu/OdsaT7MRk9JSf7GqYgYjXXVRJAe5LffEwWQPXGWehSiCtbupqGhZ7f6IkXti858kRPhDKVz2d5oXzb0pmItNcAxzbLiJsiFT7PUsNjZVNKitNgBpN/FKsBc4PgMF0jqHtKJiNQqGkrafHENreT3typ1rX1YcrQk9wLuoub7XyotVACzcXjACO5QI7biGjw7TrBUjClA6OFrghClaAZWe5DePeO9lmRnw4lOIqi96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2H+1G664aNb6NIdEG9cZOrBJT6DiGiVwE6edjon3mH8=;
 b=L0/lPwIVaXgpSwxGQdOAJX0pXZj7UnFjF1SBCji9nRveIOX2QMr+4mPdsEi9AVp71tdJgLpVxr3vkYqjU6tEMEUm8PXyPCN9nIY3yIA6oFqkc2C4lxiBhPb3Z7nx4Uf9VoSz3QpzAM/HaCfMv7iLG/vRO5yBiYALa+wz0Mx1Q603qGp/wrS7YJ59PVXwijJkANkIF9MwcC8OvgnVX/9GZcwFiL+x3xZ4IEJH+QBnBXCNbgozSw3liiE8AOw0aQCk+fYV62zKl0Z0CVrc2gFkktonb0NZORkl4uirgu4bfbM/BYyr5KoBCA5FDfT3nf6KyWXZFou3GSK9Ov57rCl7bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2H+1G664aNb6NIdEG9cZOrBJT6DiGiVwE6edjon3mH8=;
 b=13ymtDerTBpXNMOh6gXPRCQo1HcvmIhqoesaCggoIPRkEtZYjSOObnhmtbyng8uIOEHHCco5FH3V/ESQDsuAQzfP7U82NlDcc9/qI0timILye5V8KsMI6BN3hjr8hd6ZVHSCIDsjNMMAp1IAWi5Ve3Gcp/2bcPEuKk4hEeMqBQE=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 03:58:00 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 03:58:00 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review v3 1/1] drm/amdgpu: fix send ras disable cmd when
 asic not support ras
Thread-Topic: [PATCH Review v3 1/1] drm/amdgpu: fix send ras disable cmd when
 asic not support ras
Thread-Index: AQHXGU4031z7Xcc4s0CBQWci0QHr1KqEbBCA
Date: Mon, 15 Mar 2021 03:57:59 +0000
Message-ID: <DM6PR12MB407556C98F8B849E4839698BFC6C9@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210315034924.25083-1-Stanley.Yang@amd.com>
In-Reply-To: <20210315034924.25083-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-15T03:57:58Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=240385ac-1681-4e41-98c2-ddafaa3dc875;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7290256b-8844-464e-2af9-08d8e766866a
x-ms-traffictypediagnostic: DM6PR12MB3865:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3865102472F43D2051115D2FFC6C9@DM6PR12MB3865.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KApUJ2+XIQ8kyAbAzuWGAtKVV2PJjsRWrQUhJK3ZYvrlnphaSxVrgugSUcbrmCXHJWjS0GX8GSFjJY9FznMwONp3//oWNIET5Qj55hkSJgVEtz3l3OVcLrEoYD+hHqrMXi+ZKaUgUuvevouMjtzgi0QK2AbTxEWc0kkVUMpujiPaosXk+XNUd3SnKupnSLW3L69t9VL75meNVgkfwXOexZCJk3f38RbP6MelftvuVIiCZa498oczbA+Nx9zJuVhdVWhWBmj5Lnkb1a7vKRBugd7MQHwCOOusv7pAeMcA0tj8XYembFsMIyMMqbY+yL+z7B6tKOFRn1XUMgaFT3U6PVT7mQIVQiUM3UlXSxnW2CQO78Zkmm5RIxo+r7sx6e6bHNCymDKvuzOB9kpmolH/aJzsk6StJSqsiz0x/msWEO/IpTH2QNRqgfZYFJIpRE9AoW5WF/z4mAVYCBVRM0HsE/wqQzobWVrd5FH/RYwM1LjqsoXHe1Zg7NltpctRyzg33nLb+SRtszKJzOmoU5+V8ySyJPFdukgaj69X4sayLY1Cz24yRzFnWau+SGmeXlc1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(8936002)(9686003)(33656002)(55016002)(53546011)(6506007)(71200400001)(86362001)(83380400001)(2906002)(110136005)(478600001)(66946007)(66556008)(4326008)(66446008)(66476007)(52536014)(5660300002)(64756008)(8676002)(26005)(316002)(76116006)(7696005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?S1mtpw1h4dRwHo5R9Hss5tFE8N8FPS2L/M/CO7fZ6NDym9s5Xen3ww25rTaa?=
 =?us-ascii?Q?TxtCTJF1fdz3QyuxeRvQ6h0jxW3VZBC+V8qvrTlFC77lfR2k0/dhOtpycGhT?=
 =?us-ascii?Q?QTjfmVSet6ujTk9Cfsxcw6xAJ/m8cf5lDU9HkjxvfqO+vNTBy6m7F1SMBvqW?=
 =?us-ascii?Q?JQQbM/XMd5JMVLGo1lQUMCM8i6j0CmSjWvZom1o6CXrl+zc9xmFk4SZq+IkF?=
 =?us-ascii?Q?/4m03M9vpmR/QdqBFKchIUmy8kph+Gdc8+wRIgQyRhc3Ppzx4qUorroOb1z+?=
 =?us-ascii?Q?GZiW5nVq1oNuTmQ+4tAtY5ysI6QHxehLkwnGzGnxlQGzvjAijntnGtomgyJm?=
 =?us-ascii?Q?expQS1cMyMaXCX7tGD24QEzYqWcS+VL43Wd75+DUHm7MJRB1c+Q9OBvTshTj?=
 =?us-ascii?Q?n0gMqc1DDoDTmH93vetJdnqSZ1K2mj6RMQEw8LyZZ366QCYSF9oVrxc1RX/6?=
 =?us-ascii?Q?vsriSLiBqpACfY0hKxIXaaQSu6QKJGhks2pnV0HVXH7zAB3hCgX/QM1rLDlJ?=
 =?us-ascii?Q?ouUOmifgq7c88Upy+KUXov7Qz9QrBdkkgNa+FlIL8ySULPQpw0ZuETCgLIjQ?=
 =?us-ascii?Q?dexsIUdckgZSPA0DjzVfNvnx93dtpPybz3qCJD0CxYaCsNYT6pFemu+rnY6/?=
 =?us-ascii?Q?g3r+gzx4bVjXJvN8SW7zMBcTd0guNXZ7QRy9HV234Ew+nHCfecEse85fjjjf?=
 =?us-ascii?Q?Oz/Gs9hYB3McfKs1EFGtZDy575IbVnB412XgZL9muzNQKQWaEKOS3ELXW7WU?=
 =?us-ascii?Q?EuwedcHWb7KK+G/xcSa4EO1zq0PmS9MyWZ7+ZEKxz/Z0N2nlNHsgVCF/EXdO?=
 =?us-ascii?Q?6gNeW3SnG8SzZ/759NA6D19DUSGUd/MGYq5/WM7+royJJE20YOOGduTzu40C?=
 =?us-ascii?Q?lHwM7CICpCmq5T8DX/zIFI7tTlrXYcmLO+HZqN41D0k91RIaL4qHzxQW3pMd?=
 =?us-ascii?Q?zHQTcswNIgxec2zsWbN9yqdiZW3WPWrqabFZAUsn/1fEDOinUriEc6sSuUD1?=
 =?us-ascii?Q?UwNIU+M4Htnv2qrZAFnQUsMeZEkH7dOUuA/AugLAXfio/cS5rbj8BGnB9orJ?=
 =?us-ascii?Q?2WhOpy4UcIHDZM5bsvIqB3sMTuq9EfxxGrI/LTFnwk/NlrdUB0Ijo49MuHTt?=
 =?us-ascii?Q?u75vvD40WPSuRlUh3xnR5CDNb4zL5+S1I/2phX5qILgNYTWnnsNdT94PU5LP?=
 =?us-ascii?Q?XLrniYzOqJd3UNZNkmdx6rZXEuzEc2EFFBIgU232FC+8vLNmsKAhPKUr/o2H?=
 =?us-ascii?Q?haxn7TrO1EwAHTy11GaYt/EdoPx+PUKFRaXlE+hJfJ/5FuwneD9ztr8OKBIn?=
 =?us-ascii?Q?4NDEXe/nziRQ+YfGIo6JdSRQ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7290256b-8844-464e-2af9-08d8e766866a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 03:57:59.8948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0+BuYpZSfZBHdm4Nq8LEzNoMajhQPMJ4lZh5a6mhrSeE+Qo44ynNg890xq8T7oans/WWANxhr4DV42Kv4+0Xow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3865
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
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
Sent: Monday, March 15, 2021 11:49
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review v3 1/1] drm/amdgpu: fix send ras disable cmd when asic not support ras

    cause:
	It is necessary to send ras disable command to ras-ta during gfx
	block ras later init, because the ras capability is disable read
	from vbios for vega20 gaming, but the ras context is released
	during ras init process, this will cause send ras disable command
	to ras-to failed.
    how:
	Delay releasing ras context, the ras context
	will be released after gfx block later init done.

Changed from V1:
    move release_ras_context into ras_resume

Changed from V2:
    check BIT(UMC) is more reasonable before access eeprom table

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 57 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  2 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  7 +++
 4 files changed, 61 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7f7238283d26..88e3f8cdd7cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3499,11 +3499,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 			adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
 			adev->virt.ops = NULL;
 			r = -EAGAIN;
-			goto failed;
+			goto release_ras_con;
 		}
 		dev_err(adev->dev, "amdgpu_device_ip_init failed\n");
 		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_INIT_FAIL, 0, 0);
-		goto failed;
+		goto release_ras_con;
 	}
 
 	dev_info(adev->dev,
@@ -3568,7 +3568,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r) {
 		dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
 		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
-		goto failed;
+		goto release_ras_con;
 	}
 
 	/* must succeed. */
@@ -3595,6 +3595,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	return 0;
 
+release_ras_con:
+	amdgpu_release_ras_context(adev);
+
 failed:
 	amdgpu_vf_error_trans_all(adev);
 	if (atpx)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ed83a32f6f30..3a416eccf96c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -463,7 +463,7 @@ static struct ras_manager *amdgpu_ras_create_obj(struct amdgpu_device *adev,
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
 
-	if (!con)
+	if (!adev->ras_features || !con)
 		return NULL;
 
 	if (head->block >= AMDGPU_RAS_BLOCK_COUNT) @@ -490,7 +490,7 @@ struct ras_manager *amdgpu_ras_find_obj(struct amdgpu_device *adev,
 	struct ras_manager *obj;
 	int i;
 
-	if (!con)
+	if (!adev->ras_features || !con)
 		return NULL;
 
 	if (head) {
@@ -590,7 +590,11 @@ static int __amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 		con->features |= BIT(head->block);
 	} else {
 		if (obj && amdgpu_ras_is_feature_enabled(adev, head)) {
-			con->features &= ~BIT(head->block);
+			/* skip clean gfx ras context feature for VEGA20 Gaming.
+			 * will clean later
+			 */
+			if (!(!adev->ras_features && con->features & BIT(AMDGPU_RAS_BLOCK__GFX)))
+				con->features &= ~BIT(head->block);
 			put_obj(obj);
 		}
 	}
@@ -693,6 +697,10 @@ int amdgpu_ras_feature_enable_on_boot(struct amdgpu_device *adev,
 			if (ret)
 				return ret;
 
+			/* gfx block ras dsiable cmd must send to ras-ta */
+			if (head->block == AMDGPU_RAS_BLOCK__GFX)
+				con->features |= BIT(head->block);
+
 			ret = amdgpu_ras_feature_enable(adev, head, 0);
 		}
 	} else
@@ -948,7 +956,7 @@ unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 	struct ras_manager *obj;
 	struct ras_err_data data = {0, 0};
 
-	if (!con)
+	if (!adev->ras_features || !con)
 		return 0;
 
 	list_for_each_entry(obj, &con->head, node) { @@ -1469,7 +1477,7 @@ static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
 
-	if (!con)
+	if (!adev->ras_features || !con)
 		return;
 
 	list_for_each_entry(obj, &con->head, node) { @@ -1517,7 +1525,7 @@ static void amdgpu_ras_query_err_status(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
 
-	if (!con)
+	if (!adev->ras_features || !con)
 		return;
 
 	list_for_each_entry(obj, &con->head, node) { @@ -1830,7 +1838,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	bool exc_err_limit = false;
 	int ret;
 
-	if (con)
+	if (adev->ras_features && con)
 		data = &con->eh_data;
 	else
 		return 0;
@@ -1999,6 +2007,15 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	amdgpu_ras_check_supported(adev, &con->hw_supported,
 			&con->supported);
 	if (!con->hw_supported || (adev->asic_type == CHIP_VEGA10)) {
+		/* set gfx block ras context feature for VEGA20 Gaming
+		 * send ras disable cmd to ras ta during ras late init.
+		 */
+		if (!adev->ras_features && adev->asic_type == CHIP_VEGA20) {
+			con->features |= BIT(AMDGPU_RAS_BLOCK__GFX);
+
+			return 0;
+		}
+
 		r = 0;
 		goto release_con;
 	}
@@ -2112,8 +2129,12 @@ void amdgpu_ras_resume(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj, *tmp;
 
-	if (!con)
+	if (!adev->ras_features || !con) {
+		/* clean ras context for VEGA20 Gaming after send ras disable cmd */
+		amdgpu_release_ras_context(adev);
+
 		return;
+	}
 
 	if (con->flags & AMDGPU_RAS_FLAG_INIT_BY_VBIOS) {
 		/* Set up all other IPs which are not implemented. There is a @@ -2154,7 +2175,7 @@ void amdgpu_ras_suspend(struct amdgpu_device *adev)  {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
-	if (!con)
+	if (!adev->ras_features || !con)
 		return;
 
 	amdgpu_ras_disable_all_features(adev, 0); @@ -2168,7 +2189,7 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)  {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
-	if (!con)
+	if (!adev->ras_features || !con)
 		return 0;
 
 	/* Need disable ras on all IPs here before ip [hw/sw]fini */ @@ -2181,7 +2202,7 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)  {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
-	if (!con)
+	if (!adev->ras_features || !con)
 		return 0;
 
 	amdgpu_ras_fs_fini(adev);
@@ -2224,3 +2245,17 @@ bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev)
 
 	return false;
 }
+
+void amdgpu_release_ras_context(struct amdgpu_device *adev) {
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	if (!con)
+		return;
+
+	if (!adev->ras_features && con->features & BIT(AMDGPU_RAS_BLOCK__GFX)) {
+		con->features &= ~BIT(AMDGPU_RAS_BLOCK__GFX);
+		amdgpu_ras_set_context(adev, NULL);
+		kfree(con);
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index a64bbb6dcfa4..60df268a0c66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -626,4 +626,6 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev);  void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool ready);
 
 bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev);
+
+void amdgpu_release_ras_context(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 7f527f8bbdb1..a05dbbbd9803 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -441,6 +441,13 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
 	if (!__is_ras_eeprom_supported(adev))
 		return false;
 
+	/* skip check eeprom table for VEGA20 Gaming */
+	if (!con)
+		return false;
+	else
+		if (!(con->features & BIT(AMDGPU_RAS_BLOCK__UMC)))
+			return false;
+
 	if (con->eeprom_control.tbl_hdr.header == EEPROM_TABLE_HDR_BAD) {
 		dev_warn(adev->dev, "This GPU is in BAD status.");
 		dev_warn(adev->dev, "Please retire it or setting one bigger "
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
