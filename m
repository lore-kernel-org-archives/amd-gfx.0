Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7BAC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9035C2076E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3QenXQHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9035C2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FEB26E441;
	Wed, 29 Jul 2020 02:57:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 752A26E43F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 02:57:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbc3t6tkowZyKYzIVskjs9Qx74xmdtPJwbu2zcz55+zEYWsOdRsWrYlRCtOJHczAp51WkZrA3EXRVUmitkrxllJFvb+MrFSvgVgcqpRGypBcYgR9EDcHou3cZbBsRc3SN3jn99hx0LVDurJd2znIphYB8xziZipjPUqFH/GcGWaRpXnoa2gzneStD/cLnVIhdzA9DLa3Zc9p964QrR4gqLT4bevesbCRErwbvzK8QnYpGMIooW3ZrN5Q1S31csqKkiMlYKJo7NKCR3o/oum1kO1qs5i3U1NLxaZoZ0ARWPY6R5iEqRI84aorAlKhiNGGUgXZii0zMO//r6w1nOWs+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjOYvp1xf5uqxLAUd3Tu583fktLKTw4tujfYXe6DET0=;
 b=dIKvJqI+8s2gJOjSkAaC3o++vwptUXupXNxIQkp9KS1hhr412z49QkszcGVAd+182hbBIwVplWR7TVdiZ9Wpu6yvLTBSFEHFpKaDDFvyp/RH6AJL9+OvZCK+/hZei2cZZnNN/9r/odlpJlbJFHvqdERQB+jRTDOHF32CxO4jmE+FFrpODPTxjLAmeXhqcVWUw7tE5BWzTBzzCflt9JmjWX658JnxnVoOYj5EH6shHiCd6SamHlMzwE3qZpSvloU6BKV7yZLVxOuuqzIbWobqjAUhG3sde+hOWnJ14Be5GmvJ+ctnbmU2s/KgZ6ESVuP8T70mBQPnK8Us+naZZDEccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjOYvp1xf5uqxLAUd3Tu583fktLKTw4tujfYXe6DET0=;
 b=3QenXQHCOv1S3ujvk/hw737pbxKnyZLZXKapgFJ3hRdAsXw7f7TjcJ+LGR/HhdQdzIKE1QvrGuqOM2R3RDXAu4jtxemT52XgFIoquyTmiIypXKzyrvB+tsIdkR/PGMQqpvBqIk2nsid60rC2hwbgoD/ztYc3JcdOSQpDCYaIx0Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1285.namprd12.prod.outlook.com (2603:10b6:903:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Wed, 29 Jul
 2020 02:57:29 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Wed, 29 Jul
 2020 02:57:29 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com
Subject: [PATCH 12/12] drm/amdgpu: update eeprom once specifying one bigger
 threshold
Date: Wed, 29 Jul 2020 10:56:29 +0800
Message-Id: <20200729025629.19355-13-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729025629.19355-1-guchun.chen@amd.com>
References: <20200729025629.19355-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR01CA0066.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Wed, 29 Jul 2020 02:57:26 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b799ae32-c2b8-4036-00c3-08d8336b219f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1285B80F765C24E98A9769F2F1700@CY4PR12MB1285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gEPbdm5GzzizqmUM/hTE7NmrmX1jMJJQhB9tzYzUIj0rn+YM4EUT95p8OnrDeHWInrKBzM3hNkUR2kR2yHnX0pq6iF7IoDiPNKIOIXENkDXc57DJURa5RO1XpA245UHv7+pxG4NdEA9CI6adfttmojNYhCCKSKR/v1KUJJRMGJxWJjE2LJN6vCVGn9APahoAot5jO6+vDBY4+vQEw7XfApk8I9Bh4pJ946k3qpaoUeLAJvo3TUjaK1JBTm+krdT18AeYrqVdHQ9ARs6znwOTq175rOblouyKa6TVDi2MsaiWhKn11Carcw+L096rORGzN5DCCaUPPreAQtdZ7j5Q9OMY74PKFA5W+E/5j2A8eqvttrhxmIOHkWPKqIL24Wis
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(26005)(2906002)(66946007)(6636002)(52116002)(66556008)(8676002)(86362001)(66476007)(15650500001)(186003)(7696005)(16526019)(44832011)(36756003)(5660300002)(4326008)(1076003)(316002)(8936002)(956004)(83380400001)(6486002)(478600001)(2616005)(135533001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MA0OsUUVqngFIkQGWly8/X8LSSZVf9DSAYyGr7HtHUEcEi6AkcukxO6YQlwaqNIhTgYcpTsFv0ESQUXlKTVX/2SfHbVB3RWY233GMXJqnTo7kESD5SCDUup0AJ6d5xq0HDXBzhaR72AHmjaTt2fHyEyEXwKfp0lUrnLk2RdXqzYQ6+e+4PucTDcSnQBcTNu1mbLuc8x7f/tgk9F/icNH+5TtNg//wbYY/YVRiHix0lkcF2NI6zAzDSE9IzGetNbEfunyVKaTbaOBWlLuzNgjbVhZ4FoIAkOzIdhbdA6hpbTMBWyAPOTDILdPX7lvLWWC52n55K+Am3rpXRqSVtRlISla8W/aRfJoDGorPDhS7IwEhUrcrAsiXxKU0cCGkHo/XKU/U7uMRcehpUTLDN6S/vLWm1q1mPq9jWj2CXSg8JWPqcDV/o0mG+5/Th+fZQaG+3kR+JRmqfFteHFSDOPLIq8RBCFNSyIJanV/2OjPj41Wo8aphr5t1WaAcXZDBR/Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b799ae32-c2b8-4036-00c3-08d8336b219f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 02:57:29.3899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/l9/cnBRm01J0J+kZeZQbr5vBR+qIRJ1FR7PIoAr4y7MpQsa1VEwaQ81C75TfBZv2Mn8rQdM+uYF8H+x1Hkmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1285
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During driver's probe, when it hits bad gpu tag in eeprom i2c
init calling(the tag was set when reported bad page reaches
bad page threshold in last driver's working loop), there are
some strategys to deal with the cases:

1. when the module parameter amdgpu_bad_page_threshold = 0,
that means page retirement feature is disabled, so just resetting
the eeprom is fine.
2. When amdgpu_bad_page_threshold is not 0, and moreover, user
sets one bigger valid data in order to make current boot up
succeeds, correct eeprom header tag and do not break booting.
3. For other cases, driver's probe will be broken.

v2: Just update eeprom header tag instead of resetting the whole
    table header when user sets one bigger threshold data.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index be895dc2d739..c6c47c665f6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -216,6 +216,24 @@ static bool __validate_tbl_checksum(struct amdgpu_ras_eeprom_control *control,
 	return true;
 }
 
+static int amdgpu_ras_eeprom_correct_header_tag(
+				struct amdgpu_ras_eeprom_control *control,
+				uint32_t header)
+{
+	unsigned char buff[EEPROM_ADDRESS_SIZE + EEPROM_TABLE_HEADER_SIZE];
+	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
+	int ret = 0;
+
+	memset(buff, 0, EEPROM_ADDRESS_SIZE + EEPROM_TABLE_HEADER_SIZE);
+
+	mutex_lock(&control->tbl_mutex);
+	hdr->header = header;
+	ret = __update_table_header(control, buff);
+	mutex_unlock(&control->tbl_mutex);
+
+	return ret;
+}
+
 int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 {
 	unsigned char buff[EEPROM_ADDRESS_SIZE + EEPROM_TABLE_HEADER_SIZE] = { 0 };
@@ -248,6 +266,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	unsigned char buff[EEPROM_ADDRESS_SIZE + EEPROM_TABLE_HEADER_SIZE] = { 0 };
 	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	struct i2c_msg msg = {
 			.addr	= 0,
 			.flags	= I2C_M_RD,
@@ -287,9 +306,16 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 
 	} else if ((hdr->header == EEPROM_TABLE_HDR_BAD) &&
 			(amdgpu_bad_page_threshold != 0)) {
-		*exceed_err_limit = true;
-		DRM_ERROR("Exceeding the bad_page_threshold parameter, "
+		if (ras->bad_page_cnt_threshold > control->num_recs) {
+			DRM_INFO("Using one valid bigger bad page threshold "
+					"and correcting eeprom header tag.\n");
+			ret = amdgpu_ras_eeprom_correct_header_tag(control,
+							EEPROM_TABLE_HDR_VAL);
+		} else {
+			*exceed_err_limit = true;
+			DRM_ERROR("Exceeding the bad_page_threshold parameter, "
 				"disabling the GPU.\n");
+		}
 	} else {
 		DRM_INFO("Creating new EEPROM table");
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
