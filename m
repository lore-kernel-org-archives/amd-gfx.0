Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6996AC47092
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB9661C7F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB9661C7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADE726EDAA;
	Wed,  2 Jun 2021 16:50:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D2546EDBA
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZCLNiVZ8KJqnT28jc0u3Ge1oGfJ8nJBZjnEeJssPGTpLb1PXZ1gTjq56QE5cVr/JfdoVfQOj0teUBrzqo8OCQZWLINvgrhHjrfLNSTp0Upjzy2oneUSsQDF5Begh9gsANkHAuGarVDkpc6dCelwrHv3TTDa6VQ6HYt0wrFX03CekKQNJIaWCfaB3+bvKXJJWHUTH1rVAn/o56++BpMrY/++pT5vv5yqDb9WbRP1XI1PmWcqpuUBcOzs4uaZKhVlH5USCjsvSNYkd2Ci8naJT6Vtv/NjddUV8ulUZ0ViVasVbe4jeMBQ34WNaoqhhenYZlndUEzfaaSPtE8Pr8tE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZU389cokK+SgrlnQacf8NNU7RDRqq2XKBABiUvoP0y4=;
 b=c9icSg1fS/KZJWWnhCjDi1g87fWuvboU0t0IZPoy+S/0l0rTpCA5NgJEYdqMeXbm4JqgBgH3ONJHrvHJhtl83gvYFut21EukY1tD2r0grAlgP6jFG/3shaLijghia1GnyO1bAPIQjuelm9kT9FpQE5EgE7HkuLT5iO/dIMmt/pL/OhanOu30mCnFmMO30CVoLEdIBELkbQRKqlY5ee0eIOF/Hma4PAqu3PnOlGU152z2SHIMMhG05VJopO4Sfqj/UMVBh1oHRtkLN+ESBPipKFgnt8PvPVM7aspQozAARIGhyJdXi+7TDZgZVZlYG9j+glIa+CTryOYwGE02YUk2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZU389cokK+SgrlnQacf8NNU7RDRqq2XKBABiUvoP0y4=;
 b=3TE1XPeq4Bf1N8T9FdRjAa9Z5eJSGwcxTCLA6XOESYi+Q37WyjtVPr8YZXK5ueoOxeYze2trNgZa1Sfy5fBvNhDSLGNqzXpmL0g6WW6laD1shGclYKocXFvOYRYXaAM+BGnoy6+eLURkjvKtggMO8EO1PZtVuGeAoTNp5/2trWA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Wed, 2 Jun
 2021 16:50:35 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:35 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 51/89] drm/amd/pm: add the fine grain tuning function for
 yellow carp
Date: Wed,  2 Jun 2021 12:48:30 -0400
Message-Id: <20210602164908.2848791-51-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6aeebe30-846e-4aae-56a0-08d925e677ed
X-MS-TrafficTypeDiagnostic: MN2PR12MB4487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44875F14B9DCB1C44BF3AC59F73D9@MN2PR12MB4487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIJ8i7SAav+dwlPYISorYTsQFCRQcUbvrwdjF5obTFB7nFqlpEEtEXu2vFjZuSl9SQ71JlZeHXSxrZhD1QaHPLEylow6mxTXAGIGNGqVnTxt5zJAwkGq2h/omYIKwclpxZaG4Ibqh725gPP7Y3H30RP4E+i3KQz35F9tBQVxEvRZv7WWDWeicx+87SM5PwE6Sh5uJikk5K3524D2YfDu1iGzfYuAL2z3o5nQIHgD1wywLZQTvOA9I5rEjzqx6z1/950Molw06qOsXlDXdMG/7cQrccidePxeulerrItehcQ0qJLqn8kwlK++0HAfK1DVtcDY7uHIyH+nB3r5jefiYXQ576J53LUptj5kUSLcd3tOGgLFYwf1bdPlQPnQb+PvUPxZs8PmttvL84AqemWE+vbfP3MK1+NV5Tst/FUJp36EMAzk9d9ok6Jxs+zE1q5pu8674PIU3Ku0venNdcjcD6RZ5Q7CKwc9l8W/H+kuDJjapNr1ECWhuGLeRyol03HISHMM/rO2tkyOnF87awgvdiCKQsh5x1Ni2KWY7wk+tf9fjGtLQGZqeVNZTvsxkhPJ9rkoE2aibh6IoE9stz2x7VQxU7Ht6NnvePIYWHxkiDGxVRRnNheoo5xzZb4jg3sUOyWsPo5I+/fW3g2uDvbmPP33RTIB9B5J70D/CAWrOPZExhRvBz//sCzeavD15srV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(86362001)(54906003)(1076003)(8676002)(478600001)(6916009)(6506007)(2906002)(38350700002)(8936002)(316002)(6666004)(36756003)(66476007)(52116002)(16526019)(186003)(26005)(83380400001)(5660300002)(6512007)(6486002)(4326008)(956004)(2616005)(66556008)(38100700002)(66946007)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?v5ADrNYg1Djtzng4rSi5bV2SrwmwkZnO2/d9ZupScagrBt2DFDLGyeHGY8UF?=
 =?us-ascii?Q?DgIZ4qfx/XRj6MRgMjuQEre6lEGczt4oaO9PtVZ5q3l6XYTTJKTZaQkqTYiN?=
 =?us-ascii?Q?Uqdsi+zYRiNKBYZ6t9WIj86QzYQlO+H2bi4EnLSKcnes1BpVJYOjsK6Yxvuw?=
 =?us-ascii?Q?Q7VQgBzldeCl7w8FjyS24i8B19iCNqhQqdsu671tGRQO1/t8w+sZEDf1VVWJ?=
 =?us-ascii?Q?vdpkWZkuZRFe3XNS/FMNDqR4c1308JAsg0Yv/83nuxIN1Ouo4nihIKeUN1zx?=
 =?us-ascii?Q?FPvXcIQGkw/0NvjKb0++sNzdYCSxsBUfWCAmL6t2ocrOWwmaTM/ikO3vzVnn?=
 =?us-ascii?Q?Qq/mZjYv9Hy2Ui6/7synSxdH9+0FxWr+GB0Jj2WiRxtHEwNXC9zyrsd+i7ps?=
 =?us-ascii?Q?HzqyjFN7hOxjVHWirWJ7alENXwbKdgHL+VJvVrSmwfPy/N3CWZEcemXcpDDg?=
 =?us-ascii?Q?8zBUNrQJVMwghu6Yw+dxofSZGCrVlJgxOC2MSkE4+m2xCUn6e0B3aL/bvdRr?=
 =?us-ascii?Q?oIlfpgDHm3PpRZrYF2EqgNDL9CCSpxqA2DXhA3Ctiedg3o2RO0wUnBgOuoqA?=
 =?us-ascii?Q?Tu22seWyivrLG9rLvSp/9ukDhjhUZ98PJXOnuFtMT7UxXXw38ONL5v1jyhvo?=
 =?us-ascii?Q?7muGlXR2Em+TwFwyS2jiUxi6WEfbO+7loWSXz2LWnABNmhEJwTY+4oAqyCQb?=
 =?us-ascii?Q?LAGc/X0MLSYTBT1rgpefJq2s7FL3bcy8EBVNcPEYOlOq800n54/6Wsqc8RjI?=
 =?us-ascii?Q?HW8NXNzcPFHy4I6mh0gqBc+yKKWsJASiLgpoxFRcxzdsbZQYT5M41GT2GZyL?=
 =?us-ascii?Q?/ACGQLENEnNqYMDreQWh/f2tzXpn1YbtRoIjv8A/jJrWVqIA3dxZHdod/wQT?=
 =?us-ascii?Q?xcyXI4FqcZ7NcB2wn9IxdTWLCI4cFRgH0RkTQLvutYPllt4Fsdd7pCb/+lI3?=
 =?us-ascii?Q?S6DZ0zeCIYnY9HrPsBIKLJ5+pzVnPmtWDZ4+4LIEk/5gliXX+apwLA7VKm8I?=
 =?us-ascii?Q?TltkgzyQ1XbF77/lqLNwtQXpGLrWbo6CwxAK+A0t+r+4CeiNrV3KakZhg50N?=
 =?us-ascii?Q?NwbC8iZhw8r4e9PoVNuMX17vOOj0vxIiL0M6I97cpfSBD5GnfFIh3o6waM8U?=
 =?us-ascii?Q?wR2YAsNTyKgPaIawzFw6zE6lFrNLGixVaiJcuyV3TS7psPhc0sy29arXV0Zz?=
 =?us-ascii?Q?jQ4OMda3OyDKGZ9WX2XxHbN8QZRNxteB4Hwz7pV9nqlABkBlPluO5N2JaKsS?=
 =?us-ascii?Q?pbu0Bo+2ZfWsM+X6g193BHBrKtBJTuvJJmb7mCaQb6qoZEnZbpgnaVaypgB9?=
 =?us-ascii?Q?1+WN0Mq4QVez1SLPrJ1oE1nR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aeebe30-846e-4aae-56a0-08d925e677ed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:03.6007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pY27rOycz6nvlBu7N//UGJy/sDDaN8XUDy+Rdv6dJOAUrFre51/uPY5e/kGNqjFNJIDvBzYNjKjlz9oduN49ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>

Use the pp_od_clk_voltage sysfs file to configure the min and max value
of gfx clock frequency or to restore the default values.

Command guide:
echo "s level value" > pp_od_clk_voltage
        "s" - set the sclk frequency
        "level" - 0 or 1, "0" represents the min value, "1" represents
        the max value
        "value" - the target value of sclk frequency, it should be
        limited in the safe range
echo "r" > pp_od_clk_voltage
        "r" - reset the sclk frequency, restore the default value
echo "c" > pp_od_clk_voltage
        "c" - commit the min and max value of sclk frequency to the
        system only after the commit command, the setting target values
        by "s" command will take effect

Example:
1) check the default sclk frequency
        $ cat pp_od_clk_voltage
        OD_SCLK:
        0:        200Mhz
        1:        600Mhz
        OD_RANGE:
        SCLK:     200MHz       600MHz
2) use "s" -- set command to configure the min or max sclk frequency
        $ echo "s 0 300" > pp_od_clk_voltage
        $ echo "s 1 500" > pp_od_clk_voltage
        $ echo "c" > pp_od_clk_voltage
        $ cat pp_od_clk_voltage
        OD_SCLK:
        0:        300Mhz
        1:        500Mhz
        OD_RANGE:
        SCLK:     200MHz       600MHz
3) use "r" -- reset command to restore the min and max sclk frequency
        $ echo "r" > pp_od_clk_voltage
        $ echo "c" > pp_od_clk_voltage
        $ cat pp_od_clk_voltage
        OD_SCLK:
        0:        200Mhz
        1:        600Mhz
        OD_RANGE:
        SCLK:     200MHz       600MHz

v2: modify the description of reset command usage - need to do "commit"
    after set the restore command

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 71ebdaba029f..fa871df86d86 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -382,6 +382,119 @@ static int yellow_carp_set_watermarks_table(struct smu_context *smu,
 	return 0;
 }
 
+static int yellow_carp_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABLE_COMMAND type,
+					long input[], uint32_t size)
+{
+	int ret = 0;
+
+	switch (type) {
+	case PP_OD_EDIT_SCLK_VDDC_TABLE:
+		if (size != 2) {
+			dev_err(smu->adev->dev, "Input parameter number not correct\n");
+			return -EINVAL;
+		}
+
+		if (input[0] == 0) {
+			if (input[1] < smu->gfx_default_hard_min_freq) {
+				dev_warn(smu->adev->dev,
+					"Fine grain setting minimum sclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
+					input[1], smu->gfx_default_hard_min_freq);
+				return -EINVAL;
+			}
+			smu->gfx_actual_hard_min_freq = input[1];
+		} else if (input[0] == 1) {
+			if (input[1] > smu->gfx_default_soft_max_freq) {
+				dev_warn(smu->adev->dev,
+					"Fine grain setting maximum sclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
+					input[1], smu->gfx_default_soft_max_freq);
+				return -EINVAL;
+			}
+			smu->gfx_actual_soft_max_freq = input[1];
+		} else {
+			return -EINVAL;
+		}
+		break;
+	case PP_OD_RESTORE_DEFAULT_TABLE:
+		if (size != 0) {
+			dev_err(smu->adev->dev, "Input parameter number not correct\n");
+			return -EINVAL;
+		} else {
+			smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
+			smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
+		}
+		break;
+	case PP_OD_COMMIT_DPM_TABLE:
+		if (size != 0) {
+			dev_err(smu->adev->dev, "Input parameter number not correct\n");
+			return -EINVAL;
+		} else {
+			if (smu->gfx_actual_hard_min_freq > smu->gfx_actual_soft_max_freq) {
+				dev_err(smu->adev->dev,
+					"The setting minimun sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
+					smu->gfx_actual_hard_min_freq,
+					smu->gfx_actual_soft_max_freq);
+				return -EINVAL;
+			}
+
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
+									smu->gfx_actual_hard_min_freq, NULL);
+			if (ret) {
+				dev_err(smu->adev->dev, "Set hard min sclk failed!");
+				return ret;
+			}
+
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
+									smu->gfx_actual_soft_max_freq, NULL);
+			if (ret) {
+				dev_err(smu->adev->dev, "Set soft max sclk failed!");
+				return ret;
+			}
+		}
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	return ret;
+}
+
+static int yellow_carp_print_clk_levels(struct smu_context *smu,
+				enum smu_clk_type clk_type, char *buf)
+{
+	int size = 0;
+
+	switch (clk_type) {
+	case SMU_OD_SCLK:
+		size = sprintf(buf, "%s:\n", "OD_SCLK");
+		size += sprintf(buf + size, "0: %10uMhz\n",
+		(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
+		size += sprintf(buf + size, "1: %10uMhz\n",
+		(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
+		break;
+	case SMU_OD_RANGE:
+		size = sprintf(buf, "%s:\n", "OD_RANGE");
+		size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
+						smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
+		break;
+	default:
+		break;
+	}
+
+	return size;
+}
+
+static int yellow_carp_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
+{
+	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
+
+	smu->gfx_default_hard_min_freq = clk_table->MinGfxClk;
+	smu->gfx_default_soft_max_freq = clk_table->MaxGfxClk;
+	smu->gfx_actual_hard_min_freq = 0;
+	smu->gfx_actual_soft_max_freq = 0;
+
+	return 0;
+}
+
 static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.check_fw_status = smu_v13_0_1_check_fw_status,
 	.check_fw_version = smu_v13_0_1_check_fw_version,
@@ -400,6 +513,9 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.set_driver_table_location = smu_v13_0_1_set_driver_table_location,
 	.gfx_off_control = smu_v13_0_1_gfx_off_control,
 	.post_init = yellow_carp_post_smu_init,
+	.od_edit_dpm_table = yellow_carp_od_edit_dpm_table,
+	.print_clk_levels = yellow_carp_print_clk_levels,
+	.set_fine_grain_gfx_freq_parameters = yellow_carp_set_fine_grain_gfx_freq_parameters,
 };
 
 void yellow_carp_set_ppt_funcs(struct smu_context *smu)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
