Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7997BC433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F7A64F0A
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F7A64F0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61B2E6EB70;
	Wed, 24 Feb 2021 22:21:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A77926EB68
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIy7yoSoZbDVBHFa9GVuzumODBqBMN3QYftb6LTeT/t8qwIMU4H+jE74dlXH2tpcP5Nu1f3Cmb16uGiNLs+sm5qERp2m+JoS766ARho7cd/Ds+3KnxYKQVGZG8Wvlnq0n87hAvOLDDuC99AvJj8DrmWp7gHbJZ7c7u56NXQ6F84BHP5Ms50hOV3enJEIQ9GhRTJDKQVaD1S3ETpxI9AfeK25PT0N1sfCwU93Y08d6WsIE42rlkmZo2YbLqaIYpDTZPqx0Bt1JcbwFzcUtcMX26A8/ghPyKndjnewqDAQC1BxDNqY1ijAHY9ova1vyXl+C6KLEA6K4+toB5IGYyFjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FheNF7k8FA30xxHAXcoj70IBBoxepr4INl0l/zgJOPg=;
 b=d1RFgeB+OG6geKvdlIpvtqFOZ+7jYuzUnUsjPFEM911B60RYPd149vGx/b2Hu+eDPPurdTFJeGmcT8Qx3ub+kA20do/hTbLOq9NTywvB8SEIAGmAV0xZBO8+R2yUDElrqgxli0zWqbvNyDQoxaeK1qdKzqG+EX1P/FTp/7kUK4UysnjJSdyYBPh14XNmK5TEoJD4WdpeyzvAIHz0ezzyidqawfBXsK3Nk6R0dTmWrV4ISgnt9TVXBlEdTLpjo73aR3D1JWZiVlyZX7in/FAulF1HzqFIBQ3ZOddRpoZadMlxZGoIJ/GeazIrE43J3g8ChwI3qLuxILDD1ApTn4IFAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FheNF7k8FA30xxHAXcoj70IBBoxepr4INl0l/zgJOPg=;
 b=1Un0PpnxicCg/p8OlgScSwCEiUP9zXRg+zfJsaaR1rkSThwgTJZ6Vb/RMKN1sdQKbERMiKednq2OJIRAt/tm8zbFiuGHgJikGejTifVlaYZW45Aq3/072ORyXGB4nAWUgZ05rE4WZCl8E/KF8zIqb5EuAtstpESSfzFM1Gc0tow=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 22:21:11 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:11 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 096/159] drm/amdgpu: retire aldebaran gpu_info firmware
Date: Wed, 24 Feb 2021 17:17:56 -0500
Message-Id: <20210224221859.3068810-89-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bf27b49d-9ec8-418f-9d68-08d8d912640f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB47983BB75B9A02C90C40161EF79F9@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ynIqHLFOI3WMePB8SggC1BOGlw74G9fwetJbvQOTwfIjoKWcy/qDhCGQytAY0X6/s0W1U6fubO9HTtjBFtCMZuZi4a0OwTTycQEMPfDNJgN1rare9+e8+tu10CTFvp30vMnR/jOnUgIR8LFTbONskKJgrRV1kA7uruO6mP36UK7A/3cJpZbfJH0efCyET7xiRvKnklrd2D51MS+V3TQtAwr8L+2mm3lu1VQEc6XOiojJLa83tOBM6A1sR04tFSWr7T36w7L5s0WaF2N8TUNe2Co3yjOG2EtkNU+naKIRymCZsD0a8xTlOI10hX/bnCmePinWqI78Ad1G4vQETEk5BwWFesdLzQ8JD7wkfZhDlE1egcOiMfmOF7X4zV7Cq7Avl8lljGhe0PF+G0q+5VJgjuwf5qrsDLdoCnuFqQNCrjfm/tcyQCs58plYITwpK7SieSEg8B/QM8cOTfCmlY8YHZXMa+xM7o04o2XOYMetcIGCqsQFJ4QK/jWfFyiD6ngeA/DSLV/JralLvlga26gLLm9dCODc8hvjVP+/VrRa+o9zKJzfvtt786rRyHviA5p4UeLeO2776mL7jUM5dKTGDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(1076003)(83380400001)(8676002)(8936002)(186003)(16526019)(6486002)(69590400012)(66476007)(66946007)(6506007)(2906002)(54906003)(86362001)(316002)(6916009)(66556008)(6512007)(26005)(2616005)(6666004)(956004)(4326008)(36756003)(52116002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?u4tMFksxGdSsxSMYWDan5TAUciJRoG34VLUwdt8xQQmcOCk/qGKuhQd+XQUH?=
 =?us-ascii?Q?bX+VUeeR3EDLZuYT3+pNXK30bEm4wLqSsA5O+m5EE63laLrNVweVJfekS0lk?=
 =?us-ascii?Q?5CPVQpXIndPArBoWR7QDK6hfjst/ANpZ+w+KCh+SmDXNo2blsJMt6w++6VN2?=
 =?us-ascii?Q?/4rNmHjV9/k966P73cE/4QslTZt4bayxF2tVvvxXnwcjYFWR7b3rqI2Dhqlz?=
 =?us-ascii?Q?C7Bsei3MWBWjR4pVppyguuy3kd8YAehTs589n8BJSIisZY7c3h0N98evHQkN?=
 =?us-ascii?Q?N+6NbEOMkLVgTR/LpIbwMFFyT1JTMcVsVvTZCkUJRrJyOb8rkLSZKrl7E48X?=
 =?us-ascii?Q?9V6DoYJ0hx8cbfSaMXEnC/oNnAyxnrdZpxBu4b6Vy8flm44YOIYQ5UkLvrdN?=
 =?us-ascii?Q?bPBprP66Hrl4kOxBPBEehfdcilz/7J9ZDaQijU0pqM92g1r0bPkoZe6LZoj9?=
 =?us-ascii?Q?desZ/a64B4I4os8ZosUNgIgApuLdd0Puv0+GPyXyBtQ50UWLbFMSygF7XYKC?=
 =?us-ascii?Q?AKI61ERlfG7L0polg0AJ6DvoU0TZTTqkOXsqL52iqB9RLNO21RltGrLu62Xs?=
 =?us-ascii?Q?x1Oh5H5o+ZXi1LbZmzatO53gqXBkRnA9oi5uebvZZiuT0eYV/WZRsQFX+6zs?=
 =?us-ascii?Q?BryqUrLj88O8lqXLkRn1p6kuWjsVbgY7jDZTdJVBC3L3GRwD8Y7/Wd4QV8IH?=
 =?us-ascii?Q?yCV3gTo8gCeMCLsVJldnTTCBnOwan5Ca7HJ7kYjbVms9TzD5SHJhz2vlKx3f?=
 =?us-ascii?Q?lSvGxd4MY0tQ/3jrTA0OQPMw6qZcKiyBams99LxrxiEsZrnuqKfr79ThDkj7?=
 =?us-ascii?Q?5k9oqyk3AkXphusCh7mlCaDNbUXK8dLvMqmb6bg4tExcnVZO0r7pv7jY1/xZ?=
 =?us-ascii?Q?GLXTth/0r1dvv4vTy5X4YVXPlsd6u9HEetOrh76IWC9eCnm3gk1jAf6Fz4UE?=
 =?us-ascii?Q?k/LHUrcJ/Cp/P6oFBy+LHXUiRireBCpwZtvljj/DmXhNfetzFLWg7XFmV3j2?=
 =?us-ascii?Q?Yj9fbG0u+i75vJOY+Uk2QIGuH/Vh9yi9dWYibhcKbqRgT8XXCKX3VmkrYmN+?=
 =?us-ascii?Q?CsgQK9REtqEZRM/Aris1kI7LR7urdO8QG2Dp2unsYdUuqE58DrCsZma6XCjr?=
 =?us-ascii?Q?01ikH60gDI2gZPfs0TeA6fblPz/DWwXGam3kC/0jPIfr5wfGsw5vjnVShfVD?=
 =?us-ascii?Q?c8E9V27xUee5I1QMCB6FkiBketgk8wMcpDn4J0MVpiUTrs8jj1D/eALH6fD+?=
 =?us-ascii?Q?GGAhGyemqqqQr98G1J9OmQU72eA1MzS+XaQsaOcju1RJEal+fLtYj9AzVOnk?=
 =?us-ascii?Q?EUeNV0qfagqRLD8lDr66z28K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf27b49d-9ec8-418f-9d68-08d8d912640f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:28.8938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l00Nk4MUUfgZ+BNoN/95YmPhkRA6NN1mtuGdhohF2QA+I4G7DDr8HUd5+qEg7fN4Rw41sFYxhjKg086AAtxffQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

driver should use the gfx_info atomfirmware interface

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cdec53bfead0..296b48f4270d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -77,7 +77,6 @@ MODULE_FIRMWARE("amdgpu/picasso_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/raven2_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/renoir_gpu_info.bin");
-MODULE_FIRMWARE("amdgpu/aldebaran_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi14_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
@@ -1810,6 +1809,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	case CHIP_CARRIZO:
 	case CHIP_STONEY:
 	case CHIP_VEGA20:
+	case CHIP_ALDEBARAN:
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
@@ -1838,9 +1838,6 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 		else
 			chip_name = "green_sardine";
 		break;
-	case CHIP_ALDEBARAN:
-		chip_name = "aldebaran";
-		break;
 	case CHIP_NAVI10:
 		chip_name = "navi10";
 		break;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
