Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF67C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 04:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09ED2613DC
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 04:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09ED2613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 638F96E402;
	Mon, 10 May 2021 04:37:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C74046E402
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 04:37:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVqHd/YKcog4k6zSoLWOjkyOOeX6k0klMfOzY8AJ0xoZvUP806p/GA9No4jnT2gCf1lg6TPvF139UBNHI/k06vEpZzzYq7YZfylGk6YqbJfy9lA5ShjxO2hxQ4JAx6cmFV06pVT8wcpz0UvN3Mq5EBeJQ2FVbLgFpUG/Lr4xJDMf1iD8WngAhNXok0UQ1QIgUzuLW7VKOwuc+CrprmsKG+gEGIY+iAn9HGrDgJ+Yr7B/iK6A/5mW/7lP+oslG+a0QyxBBlEcWOvNX+a+vEpKAAcFN77oAo0qLbQCRXUPqEVpBf5f9g5nrtT0sQwIWS6CnhYtrgsyh01SeeyKFVnk4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mI9ln5MDHGQP/ha+o1sOKIUC8JwFcdtX5ORv6ZmOgRY=;
 b=L1cMDvbQ2Php8WICqJ6zEebvIXTE0wcCgHBliZVlEVd6pazIDhuX8pEhWBHWtOVopaNRSDb0tOPDDSZZ0OIef8RKwr4vRJDDj/7zfOMPWlYMz64IoXDRc+h7bcIteGVu4QR10UdtdDZ3qZSMabSEEYTR7cjLIN9j5/XEGJAJ7ZtrqRU7hOP5sDa0lixU08oToEB/wobAK4qGpG82QA4oFzFpN/YkRLbTF2g1tE5Fk2hA0bIw05di3Pk5soVQE+HymVv89bCjpbt8XdSHtpqw08MN5S3JXYJ6f2rJMwPRBNKrwW0AHHNEoNaJKxJeW7Kc3SzQPXTA6b9g2nfsRW+djA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mI9ln5MDHGQP/ha+o1sOKIUC8JwFcdtX5ORv6ZmOgRY=;
 b=1PbSWDkWZu/SCkkulWkvgk0h7L1tD+78rDmDfVevtbpd5RtK7nQdkK+e8jdIInnFF7T4w0LDsS3kpF7R2XJ0OQ++htgG6mWpFBMR3mLmZHGaqQaqUeVON45FGaqLrcnSNpfcD8iWcCbehp3Zi9uOyDR7W9JI8vNBrCi9JgPshEM=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5260.namprd12.prod.outlook.com (2603:10b6:408:101::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Mon, 10 May
 2021 04:36:58 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 04:36:58 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: covert ras status to kernel errno
Thread-Topic: [PATCH] drm/amdgpu: covert ras status to kernel errno
Thread-Index: AQHXRUvxFAm4yzi4bkOon5L0lb60parcIMRw
Date: Mon, 10 May 2021 04:36:57 +0000
Message-ID: <BN9PR12MB5368001CBEAB0B465E95B839FC549@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210510032354.15988-1-Dennis.Li@amd.com>
In-Reply-To: <20210510032354.15988-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-10T04:36:55Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=bd24f057-8108-41ad-8606-cf20c4654a35;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d69f3bc9-f36c-4a0e-41dc-08d9136d3f19
x-ms-traffictypediagnostic: BN9PR12MB5260:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5260CE4C73038875C3DB1866FC549@BN9PR12MB5260.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:339;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PB8rZ/oBzZv+/KO0bc1yG9gu2711KyeljBOLBfUkAIbYo1mai5+wvX6BFm40l20vgLVlQCBfxIFm95+iRBlw3+cyJYy8M3NdQDTos0EPtAZMUxEWZmgrVkYdbkyL5IErV7oeQsv6Gv/GxophaWVzb5c/EwSq4Q241WNoUdxI+U53QoJnIA5DL92amKVPcq6tZTeqj7utUX3/GPb+3dVwjJ6Us8C3aJlwj9H2+s50qx30IMq3E+hb+XFWqTIjBFDun6PmdGWnNMsdmbOKaCCKziQM5+LY2/1vEuk1z/RiXEArTdDzEBhcHo7vERZy6BVaCnJuUG6y8P8G8sZumAPorvdObixQ3RCJ7mR0UMlubLMPqKxEByZIf/C3YyVGomQX1z1RaNknr1faumMVKehV3B3L6zORCf+r9K30OBJn59lfM9y87V8XXXlxQO9YTNbrldNS3ZqTr++obXJBaCwatDwWs6h6AIqhYvvA24m0TsmxnqdlRwoeNZDpnZ7FKoAKvGoxkAT8ZUVcmf5/txwaB8hzRC8+s6biPWor/XZboV0qBel1XeTe6FIVZRBed2zFxrk4cxPM5FipEx4mV3YnCi80m9+F6+axMtFv83sN3S8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(4326008)(8936002)(122000001)(52536014)(6506007)(53546011)(38100700002)(86362001)(8676002)(478600001)(316002)(7696005)(64756008)(66946007)(66476007)(71200400001)(9686003)(66556008)(33656002)(55016002)(6636002)(2906002)(26005)(83380400001)(66446008)(76116006)(110136005)(5660300002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SJucAi/4KoWWli1/xQqWpRUE15gcgQNp2IZCDH2SotkW2KcAJVAFgq7/0kd2?=
 =?us-ascii?Q?fn2M+hFE9BAFW9bZatirwUu9LA7EOb+eW6G5vwVXZio0UjoxEgIkgWvZBhLH?=
 =?us-ascii?Q?4wJQCsWeSSheCazFJH1D0prgVZss4wqcFPTUk0Il/rxeDFhUZFbj6aHp6xe6?=
 =?us-ascii?Q?6QUa4Wm/RabczhvTdDiYDAUdg/FLeOpGdAqWOjrSvarMCnuZ41IltqElhhSE?=
 =?us-ascii?Q?YkZ08887bqNJqE8ZYJPS8nWE2zSf0e7St6Qe3Kef8nZFdO328k/PjALuxz+N?=
 =?us-ascii?Q?jf35CdK6Vk+KRQP7vmaw+rIPIIMZbxKBzx+U0lEX0m/fEfb2ou6tlFXb5q2f?=
 =?us-ascii?Q?fiIwkWvpNUHCyZeLlarfZNBWczOLGlRi8pSF/TiDubUfJxufIhpyN6NL4X6S?=
 =?us-ascii?Q?6psRkwVneh6yVilakca1I+oQhnFeVe0bNxkr7qN9dfg/J5/ROerFDZ8ANEpy?=
 =?us-ascii?Q?s6z4vnPxZafXYTdugZ+P3aeFOM+rFXpOxJ8aTLoxkqFdBkOLCt8LgVobLfag?=
 =?us-ascii?Q?x6QEMMnrDGxlTSMk9ajie8T6S/XZB8Sy6d59HvW/KYHZzqXQWgYFLlmxpOp3?=
 =?us-ascii?Q?pdhvacUGOyczZaUOWlubZ1YntBVo2DnxaRFwJaSOgR6bSm4jq9SDvFJGkxFp?=
 =?us-ascii?Q?dbVLLs4UWk2Ozp3x8PSE0t5YjKqvQrCiuQGPrWKf6Lks+9NgnhNoUvlLjjlG?=
 =?us-ascii?Q?cElnpfknrQdGYikUjfnxZHDlCAZrH+QKrt2P7d7X+31u1ZZS3BVSf4Jdy5Ed?=
 =?us-ascii?Q?jlAVZ2iY+nq1xeJjKEY4U4EnfZBjAQBSwSZOcJuOUArSqKqrjbqgWr4AEg12?=
 =?us-ascii?Q?CS7d39BVpdToeNwjK6seFZvls5yfJNdiCmsFu9nBWBxeHTwG0aE07b+Q6M8N?=
 =?us-ascii?Q?r2d6SCDSLb+4HGwdt+Wgauhkd75ocPDfSLJJG4OfnDXEnH77hLAboUK0WZv6?=
 =?us-ascii?Q?yClt/tyYgIqq518L9W+XZ5XWqxCm5D9zjFoUhNYSBIkFDXClEhpvkS/8Xltn?=
 =?us-ascii?Q?77v5Odw6alOd0gcU5znQOSGBOgukGI/UXC4YLx1RwejrDzmcTq97eUwScmcH?=
 =?us-ascii?Q?5idwKjajJBYbOpjdR7bWGAz0sNPMxR4KDQ5prNo5fLK0EnF9PP7sS1Yo63Ji?=
 =?us-ascii?Q?nDD6qEnAvXeET5Av4rvysp1qRJj4w0aDHtLq8tDo06PGviM09ZRfElS2Mets?=
 =?us-ascii?Q?f5eZQbnSHJ8XXvIKo9pRce14OqGPuG43vf4xbiIzC05V2MxBdX49x+wnqYV7?=
 =?us-ascii?Q?T60TRC0cOm7VWFOFRzDO3eB+y9AF8Gghgd4KzLI08TbZm+bhWnFoBOzoZDbd?=
 =?us-ascii?Q?01dRf8HDH5wsDRrCTvU4aVoB?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69f3bc9-f36c-4a0e-41dc-08d9136d3f19
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 04:36:57.8856 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uiwudZhm3VKxLIf7URkgZ1A0O5aB30HUlz8deYIf/EyqGYkrxcyIzsqR4E9zp9nwcEaMIsg23ZSLtd7BxyNWPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5260
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Please explicitly print out warning message for TA_RAS_STATUS__ERROR_ASD_READ_WRITE ASIC prior to aldebaran, and TA_RAS_STATUS__ERROR_RAS_READ_WRITE for aldebaran and onwards. With that fixed, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Monday, May 10, 2021 11:24
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: covert ras status to kernel errno

The original codes use ras status and kernl errno together in the same function, which is a wrong code style.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 17b728d2c1f2..231479b67b33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1114,6 +1114,28 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 	return ret;
 }
 
+static int psp_ras_status_to_errno(struct amdgpu_device *adev,
+					 enum ta_ras_status ras_status)
+{
+	int ret = -EINVAL;
+
+	switch (ras_status) {
+	case TA_RAS_STATUS__SUCCESS:
+		ret = 0;
+		break;
+	case TA_RAS_STATUS__RESET_NEEDED:
+		ret = -EAGAIN;
+		break;
+	case TA_RAS_STATUS__ERROR_RAS_NOT_AVAILABLE:
+		dev_warn(adev->dev, "RAS WARN: ras function unavailable\n");
+		break;
+	default:
+		dev_err(adev->dev, "RAS ERROR: ras function failed ret 0x%X\n", ret);
+	}
+
+	return ret;
+}
+
 int psp_ras_enable_features(struct psp_context *psp,
 		union ta_ras_cmd_input *info, bool enable)  { @@ -1137,7 +1159,7 @@ int psp_ras_enable_features(struct psp_context *psp,
 	if (ret)
 		return -EINVAL;
 
-	return ras_cmd->ras_status;
+	return psp_ras_status_to_errno(psp->adev, ras_cmd->ras_status);
 }
 
 static int psp_ras_terminate(struct psp_context *psp) @@ -1220,7 +1242,7 @@ int psp_ras_trigger_error(struct psp_context *psp,
 	if (amdgpu_ras_intr_triggered())
 		return 0;
 
-	return ras_cmd->ras_status;
+	return psp_ras_status_to_errno(psp->adev, ras_cmd->ras_status);
 }
 // ras end
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ebbe2c5190c4..9b06cb58cff2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -586,29 +586,6 @@ struct ras_manager *amdgpu_ras_find_obj(struct amdgpu_device *adev,  }
 /* obj end */
 
-static void amdgpu_ras_parse_status_code(struct amdgpu_device *adev,
-					 const char* invoke_type,
-					 const char* block_name,
-					 enum ta_ras_status ret)
-{
-	switch (ret) {
-	case TA_RAS_STATUS__SUCCESS:
-		return;
-	case TA_RAS_STATUS__ERROR_RAS_NOT_AVAILABLE:
-		dev_warn(adev->dev,
-			"RAS WARN: %s %s currently unavailable\n",
-			invoke_type,
-			block_name);
-		break;
-	default:
-		dev_err(adev->dev,
-			"RAS ERROR: %s %s error failed ret 0x%X\n",
-			invoke_type,
-			block_name,
-			ret);
-	}
-}
-
 /* feature ctl begin */
 static int amdgpu_ras_is_feature_allowed(struct amdgpu_device *adev,
 		struct ras_common_if *head)
@@ -705,15 +682,10 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 	if (!amdgpu_ras_intr_triggered()) {
 		ret = psp_ras_enable_features(&adev->psp, info, enable);
 		if (ret) {
-			amdgpu_ras_parse_status_code(adev,
-						     enable ? "enable":"disable",
-						     ras_block_str(head->block),
-						    (enum ta_ras_status)ret);
-			if (ret == TA_RAS_STATUS__RESET_NEEDED)
-				ret = -EAGAIN;
-			else
-				ret = -EINVAL;
-
+			dev_err(adev->dev, "ras %s %s failed %d\n",
+				enable ? "enable":"disable",
+				ras_block_str(head->block),
+				ret);
 			goto out;
 		}
 	}
@@ -1058,10 +1030,9 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 		ret = -EINVAL;
 	}
 
-	amdgpu_ras_parse_status_code(adev,
-				     "inject",
-				     ras_block_str(info->head.block),
-				     (enum ta_ras_status)ret);
+	if (ret)
+		dev_err(adev->dev, "ras inject %s failed %d\n",
+			ras_block_str(info->head.block), ret);
 
 	return ret;
 }
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
