Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51D0C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D0064EF1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D0064EF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 180826EB78;
	Wed, 24 Feb 2021 22:21:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA4AB6EB6B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaAkJUiNsPtQUDnpHANePnWuSHnpUCV5e2KSXiNV4q8J/AJc3hEnz5Ve/VAfUHVRIgezwthRvDf0oKku8Pe7pLFE4VnWBFiZ/wIY/0tEcc3yiFkNdxosqqnHZixY1lBz5XpwEMKc73KPWhDgdLgVZUSJtr9sJmkZ7vZNuxNHDMjP3Ep3QsY1qIkIXu0hMyv5jxn4O4GeeSW8JS+ihyc9l4acujHHfugAJ8py8gChsdIlobzNuAMumEOUHkkEx1gamiP+QBQ1QFMcsNLZCqhn9fFhJLkI+3MLeaPjCaEk2U4vjqgUr0ia4hC8CK9iiHfDQPTwqk/ix+8RMtsaUtDOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AImTfJA7toPvfhJFiKwXABCa2hPg7mmoS2laA+r+3tc=;
 b=QVsiyqkMgvgzhE/gladBT2vxRSH46ZJpsKEL3Ka12UBEtchUTVDo8VicaHuFxmMhCOrgD8ZOAfmTGwZnBp3xaJrEbfPsQ+GMMBbErilz1788EVtIlRe9DAuqzLGIDbBMarYZU2AhFn4rerv8fHpZ5qoVZXiroxsK/7W7kNAg/kzxWMMqmT0oqyWK1RHHk9OJcvPThtFrAOb5qq8nFarTxV5jmm7thLhK5EsONwG+bGchPgnXy5ASufAevrK9eIfkpQ6TDG0f4NRWDea2G50KaTANDygDsEiAzHs8CbeLVNkFkJphpzRoTOMsBDl9fp7gtXH2F1HVDmMOENKDydalbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AImTfJA7toPvfhJFiKwXABCa2hPg7mmoS2laA+r+3tc=;
 b=jZTJ/jL8+WSV02ATLtEy7QuND3Cf2pQ2w6zBF+tEOiYUA1ibIafGaJl3ftxSSCWBhjXqiCebzT9drzm/fgiRTb0NYOViJww0R/a9/3JCe97nJJDYV+8l5CGbqRw9ZWzuCitylbiryJlAV7YGOs6r6H5Kdfqk1ySVg6Y4fusjcSQ=
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
Subject: [PATCH 097/159] drm/amdpgu: add ATOM_DGPU_VRAM_TYPE_HBM2E vram type
Date: Wed, 24 Feb 2021 17:17:57 -0500
Message-Id: <20210224221859.3068810-90-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9bcb9aef-a76a-46e9-2e87-08d8d91264ab
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4798A3FF4075F22EA435E8AAF79F9@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dyDziyT0czTHtg4pvzBw1GynDDa0/xD79gho1g0pedDJEMJ48LWGnQCHFSyWHNjhTV5QtLqV1AhXF68+h/rN8NWLorsaxl1NjR9/CNj9IvfiBcORIZhjtSyIKXb7fctsaqS0FXTHil6rdTuWNDk8qAkN9kjDd/o6Kvn4Y2a999rLQ1Zu8c/1jaovqVeOzQr9ipVViHlteinRNNxZum68PlqPSm0ImRO8Kf7PAho6pwUILRRMp15WWoCm9kYTJd23JpF12CoqCUQyg3fLNocXw51rZ62up6nJHfMGuJLS5XO7qyegbm97nescxGiWLgyAMXLW6ubBIHvx9Pjk1vhO2zpjtgaGyyhoc3gnvjzsvOApTsaTW5wuXlVfpLXAr2+JO593xX4xXJvhEPNMw08MKq44l4tFKlywRCmD1HEgmciRTsnwr96lrDgiT7Rk+qdmXOcjmk2G0lys9idAOAEyC/Q8yht3Cm+BvW6b8jsos6u8+aASDZbVaxT3nD2n7UEQZPqdaZS102zwnDrV2C/2HGcDUPk9kpYTZgOcflk19hMhd7J4MVMKOmjZFvl0I8MIVCVK4bOpSS3ydDIVtAEjdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(1076003)(8676002)(8936002)(186003)(16526019)(6486002)(69590400012)(66476007)(66946007)(6506007)(2906002)(54906003)(86362001)(316002)(6916009)(66556008)(6512007)(26005)(2616005)(6666004)(956004)(4326008)(36756003)(52116002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sXyE3qjeEkzwoKe4p11wDG4kV7cq2jIi1j7iPn6VnaL3HMF4ykvFu61XPqko?=
 =?us-ascii?Q?84MNfvFZViv9dIFHWGZ810550ZmFt63LpYIG6TkxNgltZlwPugR+lqLuVJU5?=
 =?us-ascii?Q?fa/oh/buPpRIorZMA+LvYU728E2UuzBp6J5h85HtZaw0g6VakqGRhj1x6/ZH?=
 =?us-ascii?Q?51BRgMXN8pzC0vE5dMgBBS1F9FFSwkAgbuFKOOhQszZVuB0KffswmNj7AL6q?=
 =?us-ascii?Q?KJwVZTJu/hBuBR6B+DD1ckd0oexWtrMG1zQAPhJ1HAUE37pkPtWf+Kosfh74?=
 =?us-ascii?Q?38Ngx9PIubn0X3JnCTMq21yshHj6Vx9kKsxR6MRfqV/f0FAcl/EkNdQJGPn8?=
 =?us-ascii?Q?GJ1C7T+Saijzci3A5WECrtdyCDCQ0x6sbbDhRcDMihp/5hHEBFfXgR1S7ONF?=
 =?us-ascii?Q?dUlCf/X9YTcUab8InofI0JgMY8u+ciMZ4ePIW9/RhzQuUMpod7R6G7CLhZqs?=
 =?us-ascii?Q?EBlQsB64G0mLqzVvloCcd5YhWSCLAIXCHOsXqp9ECaaIGB+e7W4wta5JcuBX?=
 =?us-ascii?Q?pXYMQKS5iQiJBCewRHNdit3C60u2AvkiD8fJ8PlLunmniJuPmOfR0QzOV8Q2?=
 =?us-ascii?Q?f0R6kYE429FXbCkevKcUPJUMQhF85Wu5Isk2scamfXZpnogiz8xp/c4YaqWv?=
 =?us-ascii?Q?MYZBvfZzluyJ5ZA4UEJ52m/IapYliXP+R2Cozs2szpHpdGxD96SRhIkAqpM4?=
 =?us-ascii?Q?pF7jQSJspFrx02hoJwX4xb+3ZllhioVUWGF/jDcat8gFfOmwPi+rAyhiJJhg?=
 =?us-ascii?Q?oXyY/zyDuTSTPhZTAwg2CsYqd+a1Ba8gS2NlCuAzaLGEVH+N+TwIN67MXzPq?=
 =?us-ascii?Q?34sYo2xdcDnCQRav6mLxlehGGYunnk//iPJHmG7p4vOaNyXIHqHKuJoI9YjJ?=
 =?us-ascii?Q?jaW81cgLd8ti0oJIScqronhhVx8fFTNjuPXK8W15LvgOW/5t+Naooz94rwGa?=
 =?us-ascii?Q?OOTp1PQ37A63HWSqW9aLEfoipuqHm9ofNpFoEOoK8CykRL02qVvGY4OFSoLm?=
 =?us-ascii?Q?1FFq3cKnsO2TWx/a+Xl9ztG8UNRxK/Lt6QG8Df4TMmPA4Xytp77ZVyGfWt1e?=
 =?us-ascii?Q?Cz5pX8g3pe6eqX7lcYy1irPUpXJgKjpoJs7zcHxPud3jXbMQ64QvqgshQ+7n?=
 =?us-ascii?Q?ew3ZCxAvkg7Afg8dGtYM6yJ2ViaLozRPYDuuGv46COXAk39oWk0Kp4KgPapk?=
 =?us-ascii?Q?H1hLLLaQXIAdpbNHl32thcHkz5KBHpU6VFVi9SKlsDndpWMbSCDrkbISfk3Z?=
 =?us-ascii?Q?6CvzDVDxGUdLRF5t8tBqHvxwQP/k+4eIE8HemN3Bpr7to8C4LWB9T0MHkJIW?=
 =?us-ascii?Q?yneDzlJTziN4CpNzlABRLIdi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcb9aef-a76a-46e9-2e87-08d8d91264ab
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:29.8755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uweklICyqAq5kqFZTwTMXrYmVhQD+b2ir1ACRmh8aYkR1Szv5AzOsJ7mE9KVwv2GbYhmlEQYD8+qbdM0kc65bw==
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

From: Feifei Xu <Feifei.Xu@amd.com>

0x61 is assigned to HBM2E in atom_dgpu_vram_type.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 1 +
 drivers/gpu/drm/amd/include/atomfirmware.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 74a871cf46b0..d07c19508770 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -165,6 +165,7 @@ static int convert_atom_mem_type_to_vram_type(struct amdgpu_device *adev,
 			vram_type = AMDGPU_VRAM_TYPE_GDDR5;
 			break;
 		case ATOM_DGPU_VRAM_TYPE_HBM2:
+		case ATOM_DGPU_VRAM_TYPE_HBM2E:
 			vram_type = AMDGPU_VRAM_TYPE_HBM;
 			break;
 		case ATOM_DGPU_VRAM_TYPE_GDDR6:
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index dc3ccd76be4a..76d1524b4f6f 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -180,6 +180,7 @@ enum atom_voltage_type
 enum atom_dgpu_vram_type {
   ATOM_DGPU_VRAM_TYPE_GDDR5 = 0x50,
   ATOM_DGPU_VRAM_TYPE_HBM2  = 0x60,
+  ATOM_DGPU_VRAM_TYPE_HBM2E = 0x61,
   ATOM_DGPU_VRAM_TYPE_GDDR6 = 0x70,
 };
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
