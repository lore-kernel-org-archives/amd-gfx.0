Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85D1C07E9B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B674461029
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B674461029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 685DB6E435;
	Tue, 20 Jul 2021 15:44:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33ABF89ADC
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=So84djiFFKtrCh3k2Jmrq4zTgBfktWv86tFRr8NdIoW2vNV1sLsqWiuINKu6GR7k2DZIhoR4TaRpKPD2N8Nuj1vpE4daUtYxX/WCiTYio/suTZ8LUOk1olNEDT25ClDnH2TRF8FD+mjnY4hnhWz3cIFNDwhAYjaevYAo5DbZJ5xuHKIAi9GbfyWgsw23Um/YqV+UIiIOQp/K1vHb8x191EoFUkQhJ5ZDXScYRNPk4Xx5fuNtgf3ENu+PNvy3qNeuheV4cClxHkGEudfv3wo2Fpit25R/VlBaSZhfKV5mP74YSTAdcByg26uMsyiCD7vjBlup7C5zn7Fxyy3t9HwoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyEjoSKSnkfzSC+EUzNcrYw4v4scQ+W1+VTgL53XFYk=;
 b=IF9Qu0VWD5/+uuvbFjBSoqMfZnmfgnGyql5Td8ZBAcAXbAI+QNR1lmi2C2Yu93EdoOjU/mK6t3t1jg1JfZAvfDUOjRS+4o9m7eQPu3KroMvOc1BGelaZw6lT8BcTaCKbmHiCMq414hwNglDgB1iEpmc5Ed35QgPgx+l6rgUHKV/VD7NMzd1tytzSals61R0M9BB+KfgOwkpJWxzuFAeMHbJ8rnabkLZAKaED8XdeZOxf7VXNHGz3mcMCLgVfcpnhB9JyQ6pHIKN7fIkZx+bfB3HijVkC3dJ1gaRdbVpCo030EMXKQrv0RibDRSXtArIwhCP1w/tR1O2Sx+a5p4gv5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyEjoSKSnkfzSC+EUzNcrYw4v4scQ+W1+VTgL53XFYk=;
 b=YnxEoTa+/IcRzts3laAkxJstkWMRNeJiu/4h3+FM0bxxEYBu9WZRMg1zlxRKdHbt4BAXPQky+Aq37Xv4nrFNqkICxnDizwv14jBKHrgFTOAhyKxhAJtSQzdFMgsg4YWiFW+plvhtngU27VTuSDDkvHE2nIUAPAqoMsnUxXqI5f8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 15:44:12 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:12 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/29] drm/amdgpu: load fw direclty for cyan_skillfish
Date: Tue, 20 Jul 2021 11:43:29 -0400
Message-Id: <20210720154349.1599827-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f098ede6-3f7c-430d-4af0-08d94b95385f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB528886F287576705AFF698A9F7E29@BL1PR12MB5288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xlfroAbVktOT09kljXIGl2oV0EshBW/vm8ealySvTTWnVG/LMXMSDixdUhsuWs5JDiaC8e5x1QFpRX8NkLJ4MffaBfqv/372MbynkZcaj+i77Uy4FrfaAepn+HS6dlBGPxTuUfL7U8s48zvBeUSnVwBlniqH4LdVkMFe8wc0JF/iiHofa5Bxf3zs4N4/vtLLvwGlyTJEUD7WL8K4LACPY3BBHUT4yjzdTXFXQlUN9tyYIjUkidBzh/3zzpVy89VkDEClF5onf4QkwyInu/mgQ2YGZA1H5V0Sj2jHrlZ2RO3smPCtS942cuDFkSHgnelJXYgYMfJGirm+aLYc5EpgpAcJmRKU763TQG5NEHQ4tu/0F4dhodP3hhRPTzsgj9CE9v1oK9DSutCeAXjLGebgwRZURIu6ReQ9OZzsKJZ9aHbXaE1MK7kxI/+69qF5hKxmBFAj0yUE0tSovUHNQZK4XEviuXdqNe3R3dvDxU9NKZqpwJUTCPMsZkolEHTUMk4qZEg201e+H69JHlpGTEXzcLNct+lfyaUY48h464oStLJsxzrsaCBo5aN0M0OmM8P7OwwODduda7X8KMwrSMdGDWNdsOSAQlHA0mFtzBYJ0aGofFWz7eIFDslgGDpAVYvECHdFFM12DrNwrWy3fw+vJAz62q59PDBTv9aCBLlR/h8HAhwR4J27UNUK2GyPle4pjC3VrtcY8t4Lp6VE5hsR+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(6666004)(66946007)(66476007)(54906003)(1076003)(86362001)(4744005)(2906002)(6486002)(38350700002)(38100700002)(8936002)(316002)(478600001)(36756003)(66556008)(6916009)(26005)(186003)(5660300002)(8676002)(4326008)(956004)(52116002)(7696005)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7jQu6Gb4tji/iGvT9NOGzTL8X5b0DfW4j9+TsfMef6jOiQDG680gc9FemXV1?=
 =?us-ascii?Q?moq7I9UxMGySUzfWbZSKa11DFcOQGhYhrD0KbuXKTpE/peCvPClGXOw2KBpx?=
 =?us-ascii?Q?Hd7nLDRiKZhV5qkd0fFovzPhecIshcfFFS5ddm6ZgvCON38+zoZec4Amj0x8?=
 =?us-ascii?Q?VCJPWEs3vOSdCOlmSgx/RK0aKpGwdMpoyY9ia094iD5WNxauvRXlyVGhq/7Y?=
 =?us-ascii?Q?66R/epy/Iov+FnvS+ImCrfmEilvT92N28BjTBEVWqT8KDSXKjpWXXgGsi8QS?=
 =?us-ascii?Q?/pEGDsqqiHFxdoGAoLWC78/hdRVoIyaoyAl4OXOm8RDY7WEpPGB4vIVB1ImA?=
 =?us-ascii?Q?FLGBvTKmJQs+eDpxu+6F0p2cNbxSyHXsgzWvY5BTDnkiONroIJZ6WkA1c3+5?=
 =?us-ascii?Q?S7Yv+OsBlbI+2hIfhZQB0UkNqyespgh3KfBp287n48pWDwfBAo5rHLJMRz0S?=
 =?us-ascii?Q?PQrdc1CsCSmHFpzFeBxYNUoks3LnXPeuFHIhBF/CGokiBh7ghZ8/mtZYch7Y?=
 =?us-ascii?Q?VTCvFvY2TgCty6hbe/M+NgHzuGZK/W2Dq2DW4xn7wCLN68TWa1OXheRew345?=
 =?us-ascii?Q?sfujINaWIVaNCcGnFODM4e2+S+0mK1LCG+NXp3ZPShypRJGgRBZzZ10CN4H7?=
 =?us-ascii?Q?SGgg71Yc9a00LnHjB1shJ0BLWBAJCw54AamC8e0z364ekm9g77Wo6hhgwia4?=
 =?us-ascii?Q?xDRcts04DYfCoB4Vkj2vbwnynHjZExSHhU4UE6/t3t8hYLv/vURy5HDbbqHR?=
 =?us-ascii?Q?FnQZd9gqTYaXtraSUzNuOYKH6Lq1VyokTIIf1mHikGllPY1cvGnGh59vVzII?=
 =?us-ascii?Q?R3PLp4VYKPhL4xLoKzFwz6anhZKZrh5xQKcKESU7IqInIHhpjs/n8fdGvbL7?=
 =?us-ascii?Q?EMwQW7m/Ptca92gpXFiXSaJvU76x0OHSlL0c5mwd9W1hiCxkEs7i5tU1T0Ir?=
 =?us-ascii?Q?q0l189Yg2Y4mxIHYWVdeCs9M2zyZTuhd1cRP5SqGPZtXcWt2twxoiTwcFjHe?=
 =?us-ascii?Q?TzMdGhtfQqSDfsxSR07XHLwRpiS577FhcyGJLbWOCyr1eNV1x+WCLRalKihF?=
 =?us-ascii?Q?swF2V+Fuu2q8A1zt/8VJQz2FYwrg5DfysmThwkY+ukdWBiSbA0pswzs3guNm?=
 =?us-ascii?Q?PYjYWOthJg54qQl6mZ6R2hIGFYE9NF52t8ILvtXVCpScwnm3saeGaIBuAcCO?=
 =?us-ascii?Q?kzeBdcbFhrOrN2eYBllAOW+z46Npd5pJg3+X9Df6KWdmqzTBTQobxkN68DNe?=
 =?us-ascii?Q?Et77NANNH0ynQXRQPP2aVomn7Rlx//7d6kIdJ0TFxiUJ+gQ5ON5Bd48RXeN8?=
 =?us-ascii?Q?cYwK+CDhA296yMsudgP37+Cn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f098ede6-3f7c-430d-4af0-08d94b95385f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:11.9815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6WW9yUEjbgs0yqtAdRlMjr6kQkcqQO8uaI5jJc/IeghfSgj9kivMrMzZLrg3x/aD3yioD5ol2ITV34vbmXz1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Use backdoor loading.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index fe601f67d3a7..e683229b609b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -409,6 +409,8 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
 			return AMDGPU_FW_LOAD_DIRECT;
 		else
 			return AMDGPU_FW_LOAD_PSP;
+	case CHIP_CYAN_SKILLFISH:
+		return AMDGPU_FW_LOAD_DIRECT;
 	default:
 		DRM_ERROR("Unknown firmware load type\n");
 	}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
