Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C007C47082
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 09:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4F36101C
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 09:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4F36101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB59C6E8BC;
	Mon, 31 May 2021 09:33:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A65256E8BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 09:33:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdALgyc+u1RR1W5YR10zvXBwcN4ssN5K/GZwtPpB+vrZ9BbDzWzRmhZm0hZn6SX+SAX+71TzWSdLQ89LARr1YrejO7raA0ASEsipJgjpdz2sgLhdGnTMWescYH72U4XgR7MGCEpILvhyJtrIjAiL1eRvsZkVoTKHo2pM7We46Q8VWuU33qB8PXSK1RFqw1KxstElUd5cr8cbJjpjvopOdwevpJkTETqPt7R2iQD7FTf5ojVcd2dbyWdY4zLoBiCWJR/O+yarKJSyfGA1+wrQyE1AZ5C1n/0PLCT2QIzahdiKfFdBP1U1wOYGGoZPDZwEqL244oaKs2VDygYJtumCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJFxyxyXT20q9zpXMj75hZKvsgoqwmDr6OVei+jdB2U=;
 b=CNPgfFXoNf5ThPO71BqXsLG/Gbj6rofxFGy06lPlcty815jdH6frq3D+vyDTcxv9/eGTusDM/wz42tb2+lbT8e3Pq6RanW5/GbVOUaVQP+djsSbF8/Io2iaEGk2WkQczT7HMYh0VrcIH3i0Monm4CxOItIVJ0Zs6TvHcH0wbAnIWFb3bXMiPhpv0tpP/eZg6iokZEmmJxRXf+adFL8FKhq9glkQfeD4+hjkM6IMwTqGupFDPVCAqfmutWtpJqX9lLoDhfTu9qO+yHIcox/23argNMWlpCzQlJ901V8ESmW1xcwA5sjXf7H7rjTofQXbScoQwt6ewfrbrUWGcVuGBAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJFxyxyXT20q9zpXMj75hZKvsgoqwmDr6OVei+jdB2U=;
 b=QPq2vCkQ3yQt895F/zJya5lyc1PsxAcQ0l9IuchlyoS4kGJ1w1y6V7FrJzWYsMngCzAFFu/f7iKghJHYZU4tq39luj44n6VO84wpdgO+bXN/RG3gH8Po3lVltWjg39ycMlpbpZUMjo0tXb+EGEp5CPlApsjqqR4D7NPdJzNjN+8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5442.namprd12.prod.outlook.com (2603:10b6:5:35b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Mon, 31 May
 2021 09:33:35 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c8f7:5e9d:ca99:1dbb]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c8f7:5e9d:ca99:1dbb%7]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 09:33:35 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix sdma firmware version error in sriov
Date: Mon, 31 May 2021 17:33:17 +0800
Message-Id: <20210531093317.21790-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0161.apcprd02.prod.outlook.com
 (2603:1096:201:1f::21) To CO6PR12MB5473.namprd12.prod.outlook.com
 (2603:10b6:303:13e::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-ws.amd.com (165.204.134.251) by
 HK2PR02CA0161.apcprd02.prod.outlook.com (2603:1096:201:1f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 09:33:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ceb89d2a-d84b-4797-19d4-08d92417297e
X-MS-TrafficTypeDiagnostic: CO6PR12MB5442:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5442EB02D867DF93E33082B8A23F9@CO6PR12MB5442.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +HlgOolfkkvYsgR3nypqliWFaD3w/fRsUysYGmhKrEKq5TVjGblGsY8K/D+v4hyqaAnGugXtI9nvXdY6y7C18Lr1+MaFjkTDnsKI92L1XGwb141o9bq7lpEXQmwFMN86WmvUVDtwIXus7Wotn6YPE/Z1tAvHyYPyz9U1U1ceVOtrFMq93y5qX8pajroTxD36zmC7IRKUJs7PF/zrr0IO/gctG4B0fyFHf/xIDTgt0/tR1Y3QNYKP3hSop8EtBD6F3Jb0YpbS0LhCKfaS8ZiaYThp8iWjxV0Ru5QAh3enbF2bqNJThjdea5SOcJRZXAsuUK/tPfEwfirl8H2kjDspkqFoIpBHlt+gxrsTh1IHtWPl2ZhuAlNMp0HiAqXq9juBln91O1EhTEil+l20Vi82W83z4G7IvLO651YBhsCofM38Id2BWGYetlMGjrVQWvXzzzittNASxZo8AjKJeCS5Jf8WQTzvVtZjz689/1jMxuQldkHz4SmOGgbre5ZclHqfepPxqd3u49ll2TD7iBtSxz+8NcwQd6vzWohBpmLWJnZHTuH+ZSq6CFywzh5D4YEM2jEV7cVYTMG9+hnd52rU7St64UVkVId8yA6/EPNvBxYPJMsC6j6phd/lsTRndGsE8rhwGf6zepMaeIn//22arQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(366004)(346002)(376002)(136003)(83380400001)(86362001)(7696005)(52116002)(66556008)(316002)(956004)(66476007)(8936002)(6666004)(66946007)(2616005)(6486002)(26005)(16526019)(478600001)(2906002)(6916009)(36756003)(5660300002)(186003)(1076003)(4326008)(38100700002)(38350700002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dk+ALkTjhFAbKci5KDlikBG0QXD0+EAS6j2InH7ISNfLGilVGUnuktg7jjMS?=
 =?us-ascii?Q?9pSTDwjnorQRt1Q90eCOuPRJrfJmHbwP5oC7zWjkfgTrDpN5OZbQ+rgwd/T9?=
 =?us-ascii?Q?d7wpTgeDOa4VDvoVi/wORofwI8Gf1igpKBxYo3PLgQPy7cWkND8k+zYbfOQl?=
 =?us-ascii?Q?hBXT1PFjsmfLIhhd3BT+iDG0Bap4ZLQqLSCarqwbMP5pRFD0HnuvuHb6tRel?=
 =?us-ascii?Q?Q4tlVBUmyVVRUGO/pkbE7ZmTwF3rXN0sWBPubxunzng4GAP2JSIXMbJfnU++?=
 =?us-ascii?Q?bsxLXzInv8sWZ56lJSuztNzVDZy2ASrY8kV3bwWLmWKLCyHMtimBR8H40kUg?=
 =?us-ascii?Q?zUNrXcTH/uts+7VjSWn9sb/Du82+NhVNRpvgAsABWyqNnza0hNKmZcHRotJB?=
 =?us-ascii?Q?9VY7e33IshQDU0QihcCcBj7D+o1trcK26JqKmpeIPXnE5wIQGJFUb2FLIdbj?=
 =?us-ascii?Q?xbr6iY9G8r41U5bvRLlItiZCgM60DStKPSnrl3dhIY4/kQaLJzhkifuk5udF?=
 =?us-ascii?Q?KtLd7XRXdc/syrZig7qa1Ds6EBmk9ps+A74XWFBKtfFRzTatcx7J9scQCto0?=
 =?us-ascii?Q?ahceFc5GEVQJX5+WiUXJ4m7zHUC20Sx7U6nN1ZYMAREWyakj0tm37u7dalIp?=
 =?us-ascii?Q?jIcd/52v/tHMvS14xJ5gwL9qFAC8T5X8TUiS7uZjbCM71IZ5HjcWCJCP4yE7?=
 =?us-ascii?Q?XOw0NXXV84R9IoxQWdKWTnE3Op4M/K3kG1skagUAkyF1+6u3v5LPDyRaNgXF?=
 =?us-ascii?Q?dMu68cJ52HBzUHb3qDYLGnEgl379ea2EV0ImIkOzO+1Ke3W4nhnqxdxOWDC/?=
 =?us-ascii?Q?y2lyAkIXJ5FY8GWjM+x0duvpZ1/mBWCe6sn0/n6unzIW/RKOBDNmcTTKqXLT?=
 =?us-ascii?Q?1XoH9l6jV0sBzNkvj3OL1G1CjGMPVKbj+G81iWRTW1yOUEzFjy4URCSX/Lj9?=
 =?us-ascii?Q?aMbzqjRWmLv24MfaKoA9xIV+Ox9PRb6+ROy0EAwnd1DXK2wVpidv0TJO1lGK?=
 =?us-ascii?Q?GNotorx8VueVbEMC2WpIdDpPaak+KqY39yZ90tvMngyPFxbU6OYS6PkCh/Vs?=
 =?us-ascii?Q?XBYY31hxJXCbgTaS4WmM0fn9l5r4UqpweTD80tFko+ysFpEfD1s/eITYd14x?=
 =?us-ascii?Q?Ot2rTxAiscO7SYwbcpyoL6tv4d50oTQ+Ls4z7ROkg3ATkoAyaVATkJjlz/7V?=
 =?us-ascii?Q?Vm6KsWkMyhOYcL51iq0ULFq6Y9kzJp/+VVgUu5Z4UUkVDTucQ+TJHm3xa9LN?=
 =?us-ascii?Q?zMvcNXk7fbCx5LkirrPni9SmGnjL3QWaMJ8WAam55ymPV2XMLZKigH3PiBFp?=
 =?us-ascii?Q?ZMkU0DiY7ZK6d40z+WGGifFF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb89d2a-d84b-4797-19d4-08d92417297e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 09:33:34.9868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Y7nTHg/Vmwfa6n3Q9FL8Bescox2R9rwI6WnmKdBZA+etReqNlCqvtQUbmRQZ/Wt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5442
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
Cc: Kevin Wang <kevin1.wang@amd.com>, stanley.yang@amd.com, frank.min@amd.ccom
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Re-adjust the function return order to avoid empty sdma version in the
sriov environment. (read amdgpu_firmware_info)

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index deb907f96090..98059bce692f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -147,9 +147,6 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
 
-	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_SIENNA_CICHLID))
-		return 0;
-
 	DRM_DEBUG("\n");
 
 	switch (adev->asic_type) {
@@ -187,6 +184,9 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 		       (void *)&adev->sdma.instance[0],
 		       sizeof(struct amdgpu_sdma_instance));
 
+	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_SIENNA_CICHLID))
+		return 0;
+
 	DRM_DEBUG("psp_load == '%s'\n",
 		  adev->firmware.load_type == AMDGPU_FW_LOAD_PSP ? "true" : "false");
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
