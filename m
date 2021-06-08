Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45085C4743F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14CC6610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CC6610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A35C6EC59;
	Tue,  8 Jun 2021 21:41:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A36416EC56
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3utHJYzhYt9SFKGEfb38j2reF9/nFGInTwQxHzJCM62F60mBdcEoUJk3wNOlOLggM5Xz+1WFuxFgmLOjxPE4y3RT3FU1FQQoDHTPonSD3UkB3g9ey2f8iaxmSRNY7ysdNXzx+RLE6HNEJT5OvTmePvMfX0WJDAU/f/WMIpL+JveEMLg/k3gPMJx8HyP+2PWv+/wLm07sI44zdmsjBRousCE6OLmPk5dr33QKrJZqHxla9oXpN1xSWF0O9v3oNCj8iBhC9XOwHEodBM+TBDoDU5mrnXmlRJQVhfB2pbrYDMqqUXoIxf/GpqF24E/ShAxDp/WWukK8NF//c61ZXt8sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKdWGFAwZ6fbOuvEIitszlF9OPPFB9xriAK1G02RwPE=;
 b=Nxlo3To+EtjV1YHzytpjsic308p+Woy8QGxkabvBBRV+HsBTznmMMMpvEwuLnww9V9EZFPYfCKHH5VroSCf5n7iT+euI7aDqWtnvx9hpw7CLrRLD2QZe8QtyXfoPsGHRDKx1pwTmY/TrWa7GbBv6qj4jjRryntvProOwn8ZPS5cirGngK+I8L0YFkn5MQmAsTq88V1WQZuu4533aPty2auAfe8C4PQBSvKWvFk4H118bP0S+IpTiICvTAAyEr2w4UHPmFMfRIQf+6AhzSFNABCXEp7sSTJTgKAghDZ3NSJMiTW0SSnFdRszNFcWvO3+JyzplktDfA6BExn223fHI0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKdWGFAwZ6fbOuvEIitszlF9OPPFB9xriAK1G02RwPE=;
 b=l2l8TeRr/KyIQdaP5p0OcJ1Izogt6ohTW8F21G9Z0fp6z6ELvdvJMnxGpWx5A/J9izOCFVw392/Ss9ED+OC9/KAeZHAB227jiDw9hsr/hIa4zwDjxGZfcVGtJIt0gKqXlL6KSwnVRBfePMMKY9zfjsx+5T29QPYAVUroQ+O9Nng=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB4678.namprd12.prod.outlook.com (2603:10b6:4:a9::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.26; Tue, 8 Jun
 2021 21:41:11 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:41:11 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 34/40] drm/amdgpu: Fix amdgpu_ras_eeprom_init()
Date: Tue,  8 Jun 2021 17:39:48 -0400
Message-Id: <20210608213954.5517-35-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608213954.5517-1-luben.tuikov@amd.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b9a0015-0265-477b-f715-08d92ac610b0
X-MS-TrafficTypeDiagnostic: DM5PR12MB4678:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB4678A51C6D0429EFA8C46E8699379@DM5PR12MB4678.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWD7w7+imHDIZf5T5ukxYfoviFMVeT5pcpjhJFsrStBklSOaS420GrWWVDjzJ6hpJVdUKLdhCM/dzry3CHDlLgOtd82dfXHChTao6BV2n0lxwXbgAf4xJSwiVx+t0q4NWIxVQvE0D1DnKiqFlQihmZf5g7aLBZSAQzbqCMC2j2f6+6yoX4Ek6ERQDeB22TAxjxNCrGnjqlJryJGFRO61janZ5h51t9OuYen9dlKq7VTXrWHOtGDVygptiusIz9Wqj09FSpAyXqOKjISY9Naeho8atLGCjkQCgwV/Q4IAeHea0BLxvPHI5vdpPI080QDkgC3FXtNDo1k8rr6gDLJlth0Ot6md7YibLy/hq4yxM9xwFuhl1Wziq6aRsfn1lfW4YicIsAisd+oQFH+2ftUQAyRGGq57yi0BoDzd8kzBv+WMaRZ0GuXYEClzl61WexxNnFdoO/1sshpF40Ga0k1TBEATOQkgs6njkFOYX4S5IHFcIBl2RY2UoO0lJOubPBphEm9PF7KimC9N7m1RIRUxrjSGXMj8Byu5oGGtSjDzvcf6tOos83NtJVgJJZpMduLYd3CgYuRikAdrEk6Ny6HgjTwshPWPWxbsMNH58VaGyZNwdV2rCSsKDPlC0Gi8QwWnBFdU33XdQqZh8SZ+NkJX78/gbpVeqXeIYMP/SpbgVe9t+wE9le8BPMoSu2fM84zc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(2906002)(26005)(6916009)(55236004)(16526019)(8676002)(316002)(66556008)(6486002)(52116002)(66946007)(66476007)(86362001)(83380400001)(1076003)(38100700002)(8936002)(2616005)(4744005)(478600001)(956004)(36756003)(54906003)(4326008)(186003)(5660300002)(44832011)(6506007)(6512007)(38350700002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HMsfX76Y1aOIMpSS7iFyg88UaxutgWcGa28Trsb/819orppzMfH8w4grQ2Kx?=
 =?us-ascii?Q?73r+8+v3Z1QZiRe818Le1IsPb50eOyi7DYAq8y+OoEFoLUdt+MZPBFVfSMjK?=
 =?us-ascii?Q?9XPFR3RWCouIvJ5uUNklLKq/KG2+cg4PtDt79CZhXDLmVeUS/QHtCIAS1ARs?=
 =?us-ascii?Q?G9KBHqa/dHk/kcW6w91vUnIPrAYJV3m4b4RP6q19spm3G1eMlKeTLXRarw16?=
 =?us-ascii?Q?6/jucfLnFsuXH/E4NlOtSttsJnza/Oe33e4QNgIhMDAk/Q4gHz67wh75ajl4?=
 =?us-ascii?Q?YVUjUzmzLlY/pm8yl6OtxuTgjSYKgE6E0Dx9LHljFgCj6gPQoAXP4xnqLrUt?=
 =?us-ascii?Q?ETqYXLvJ4LOMl1kJft8SW4eiMXy6++/yni8lMrZQfopsLfae2AsGvtAsTeVK?=
 =?us-ascii?Q?fqLSLTkYyhfm+t0qcbqgiuPHU4PIrtLY0kufBLCsYfJBUIhZSdqx3DJ4s7Hc?=
 =?us-ascii?Q?HDsPXEpv8Xsbf2LW5Lubhwh7drLUkvMFgZ2OXqfscbAncOo5C5Cy5DLVl5lS?=
 =?us-ascii?Q?zEjSwD5Fb1DzXoRGprH4MLZYWiPhq4Snuy8N4rWOlDDVJxMGOqTHWTebsCoP?=
 =?us-ascii?Q?sMPoiIVwdkeQnJhRqsaXO9Fbu+2L+YFivSRGpWI2A9XxrjHgkQ7hWGhaK50x?=
 =?us-ascii?Q?if2EwhcKgI7R1wnPVXLsxo5nWTiS7aFgFwNYBoeDhLSARL926/bOawM1YmbI?=
 =?us-ascii?Q?t8G8JrV23ydstjLOcaQ8gFEMaZbeSoV8i8JCmLhXxxVxmGwbXX2uOs7NUGHZ?=
 =?us-ascii?Q?ZdSmkLoLWIrugqf2/Y7wqbyaYHARfclWDMo2B7jRo2vz4W+6Fcu0CrKpgH7U?=
 =?us-ascii?Q?hsSHRgiaC+/cdYxMEl1kft3G1zsWJDZjVkqcUU+f2SRyH2xXOgXFcYtjqruo?=
 =?us-ascii?Q?ieD56+QJCCA+Pmri6hTgKoE8saZg1UXKmIB1W9/sq6sHiCygzPoqckPV77BB?=
 =?us-ascii?Q?yDSUGNxeFRBExcDjNsXlDBzO1cF9MBrUtMTFxrVuYaDdVE8rdErxcrek3pua?=
 =?us-ascii?Q?E1gsGe39x9rN4VbRw4LCXLtYKmHDBmRHOiXrOpgWrSa7JQ1Wi0IDSN4anVzu?=
 =?us-ascii?Q?DqOiRotSdnWCaWMekwUXFH1xcOR3ieVdWQpu7ipVuW06EpuoKvfQWh4nDPbm?=
 =?us-ascii?Q?3Gx1dxjihFXMaU5mvLi/bVcBBMwf0l26KC+1p/Fz3ktp1lrplP9Z16GrckYP?=
 =?us-ascii?Q?R65cZ4jQynhww4DfuhqoX/A8r6cLN68xG/y1q287Q0jYnV3FE9qgNWigoCkp?=
 =?us-ascii?Q?j4gPNUFW+u622Hy2ZhVyTFjkwt0vz1brpH3mpPjiyqWIi/N4vm3nPKXfaw/M?=
 =?us-ascii?Q?DQO0bZ/BP64RGwqVQt7LVyca?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9a0015-0265-477b-f715-08d92ac610b0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:42.3209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRFKt8NcZrf8UlduKcl1miA+GkpqfrxLFrnYg88/7VWoG6+XY+WWPi76ENVFRZ5o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4678
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to account for the 2 bytes of EEPROM
address--this is now well abstracted away by
the fixes the the lower layers.

Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index dc48c556398039..7d0f9e1e62dc4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -306,7 +306,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 		return ret;
 	}
 
-	__decode_table_header_from_buff(hdr, &buff[2]);
+	__decode_table_header_from_buff(hdr, buff);
 
 	if (hdr->header == RAS_TABLE_HDR_VAL) {
 		control->num_recs = (hdr->tbl_size - RAS_TABLE_HEADER_SIZE) /
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
