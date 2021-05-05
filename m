Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F20C433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 14:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3502C60FDB
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 14:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3502C60FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEAEF6E4AE;
	Wed,  5 May 2021 14:56:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6FDA6E4AE
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 14:56:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvJfGFQfdlFgoqdlUyH4Cu6queV2G0Tpdq4/xYbLJzGqNkOg14vH/OyZBdVZEfQKauVrYCY6BG2ZfSrS3Z19BwZSna7O/Smc9MbsOrO1jAvZ4i8HFNUsN4RCjxBVmTQCkkDGYcAsCQdwmBhe8O3meJ+Hz24F5R3Ag4OexGX/7qAIUG23VMPbTae2CDgUNb/JDs+fHton82HzibFnz85iGe/DaqtB1DF4kClnGHbIHQcX9sNgdUGatEVoITqD7CpzsLdefMV79ufT7fdc9CGf1d3rAn0LwvjNTJKiYwWi205NjV7A7kjFbTqF6BUdTNlKfzKpaFd5i2r6mW8wba+WDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeAXIQ0YRDuVpqy59LhzZKDxC2lDcBSqGdNkKWkG9AM=;
 b=XxWBgi/7YyyjQ58dop59x1aj4kUesrtLRxB3h0E+uGMnUmfYJiePjJ+GhARe3Y6aKQjASX4SmVJSzq9iGCb5I+hx/mWsYUJy0txozxJkBR6rZer42ryA+wlAaGFxxrxnpYXnjdzgejDh48ri3kL4/qzVJcbeygiQryup7aRFVpgr6nsIHvx+bfQ/mpR4V99EVeObmK1LpH4uUIwk6SFEOIsPTcHWKZBK3SGMxlWD8MX1H/xJ0x1yjyjaaB+0eKIlp+AuHO1X/kBVW4Yip5YeHBh8I5QD89w0utOsV7eDVCKn2xKYGkIRBjMI3E3nMMci6sQxtWCUeIj18Ldbzy5cWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeAXIQ0YRDuVpqy59LhzZKDxC2lDcBSqGdNkKWkG9AM=;
 b=vtgiCi/rQsVgiVRMDwP+9lVaJE63P9RislU7w81z6DIYg9P4Xd2nwvlDy2XXc9PIbajBKeHNrsxXIBwAv5w/tA0LFc4efFdTjvv3lkPLatbX0s0DpETKvMrvP4sQlLz/G777463EKbHN6EKRhlU9Wz8/JUwyW3AwnnCQL3DcQt8=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB4811.namprd12.prod.outlook.com (2603:10b6:5:1fb::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.38; Wed, 5 May 2021 14:56:54 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::5194:b381:c345:eb0f]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::5194:b381:c345:eb0f%2]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 14:56:54 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: expose pmfw attached timestamp on
 Aldebaran
Thread-Topic: [PATCH 2/2] drm/amd/pm: expose pmfw attached timestamp on
 Aldebaran
Thread-Index: AQHXO8/kV8wAuGvG90Wda4GS9R+cQKrVBgOQ
Date: Wed, 5 May 2021 14:56:54 +0000
Message-ID: <DM6PR12MB2761ED7161276CB2AA4C14D08C599@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20210428014305.1736511-1-evan.quan@amd.com>
 <20210428014305.1736511-2-evan.quan@amd.com>
In-Reply-To: <20210428014305.1736511-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-05T14:56:49Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=cac6dfdd-79aa-434a-a2ca-a7ba37c82282;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3ae0:384c:8c47:46c:a8af:6616]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 854ed9aa-7ffe-4bbd-6aa7-08d90fd605cf
x-ms-traffictypediagnostic: DM6PR12MB4811:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4811A355FA47A8D1A22055EA8C599@DM6PR12MB4811.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9PqcoeNG175eNbSwCYIV+KsTZ3DgCjsZJEbSzf2lpZ5OO63HmkMH4Jg81GrjduoP0UNRCc5zyeDJWXuof8CCo2ghT60yYFtw2TSNMSqmFN7bDvIPmHsBY3+2UPQMCH/oUcNnEPSr9KoYBJU4FKhjeD5WE9EBIxValsePclo47LF0p5XDhAAHw6beEnOKogQSEhH0kNQqWZb/3+gmFvMN+aVrmR3z/t77nMq9lkwxOTA4tPOs/1WOZMPOTZAqOlY1dRh6uMJP9xam8a44SFS/OKjPhq2fGJdrnNSEFAg9PrHCrPmFAlcL1DYmVv7BR/Jl8Ug2ZJqsn5NA6pKooxPgiHwbwjUH8ZxKIDbeaNRxv1EZkxjsvHGgP+Pmx9M9QNrZ0K/vnKMfdr4phTsr8QbHHjm9sp4IIyOmkvgWZnJSd9EbtiEHzWHbPpg9QU4nbxQNSpOKL3lvG+b9Ib+maSh4GHP6/j7M2gGyhK82MBooFt3GdONk3JN3cqX3J5g/UFPt8PA2m0RPxKOEqeXbtTl3YEqCcfzZXp+VNyiQJYbMdZVN0NRfAR5D5ls59IsGbbpNRdcXS441xCYvaDWKe5MFZrGAP+1On5NmGax1Mc0hveM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(64756008)(8936002)(8676002)(66556008)(186003)(66946007)(110136005)(66446008)(52536014)(6506007)(66476007)(5660300002)(7696005)(86362001)(38100700002)(53546011)(71200400001)(55016002)(9686003)(122000001)(33656002)(478600001)(4326008)(2906002)(316002)(76116006)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LFOR0mwzmnBogQfk0aVOhQww9yNRwwwc8DIpXuIYQ5hoYXPaebTZZC/NF96f?=
 =?us-ascii?Q?Ygc2jV+nmfGqL208nzPF+IqB/7vfGou6eDXCWNxGuS0K/YfiUdd87J6ublFv?=
 =?us-ascii?Q?cZChW6AEhjMNXBqpaXp6WH3C2Cni0YcKBCF2IpwRGr07CCKpvY9OXV1TI50r?=
 =?us-ascii?Q?PfWpoabfomMEXKkIcP4TfqQDsLwFwRQFbayYgv9o7KbBg5WeFgZaBrW8FhGN?=
 =?us-ascii?Q?5yEkTuaG+Cj+tmP0u5jTDBuJgkIFsd4kgj2wY2qUjyPPyI/3e86zLM3CrDib?=
 =?us-ascii?Q?KKbHe83gPu+sGM5Ks68VpYB8nb/upeyvV1qh9KeqNU5LsmwUsS/o2oGI36OE?=
 =?us-ascii?Q?nKSFGJ42xLzgx+uE4jykS05xwzp6wUSrit7mAhYQM+wFfUBtrkmw5fHiNPlV?=
 =?us-ascii?Q?suMb3DwXieGufR8VUO4si8OOXEOnu5/joWkqxu8Wnj4/BpHqGBaAF+DGrSVn?=
 =?us-ascii?Q?4i1itBDLvbcZpy6TFkWdxNSwiPIANvB3GFE0is0jfPkZssVJqAz/erXktqh8?=
 =?us-ascii?Q?qJhHW1uF0mEy4J3HovgmV38xJW7XdoUnr7cd2nvoJnlA6XEyI4otP3zs5mPC?=
 =?us-ascii?Q?dLhrIMyatJzs0L6JKZuZgKCuRUYgVuwmeAnymhvgCD9qF/2ivDnOkovkqwvr?=
 =?us-ascii?Q?ASPlgoAUHhziqazao2uzQg9gZoR8bz74LapA1DyN8Gk6JJTOwjeUc2LIpMBF?=
 =?us-ascii?Q?BiPOoAvP8m8Elc1C+XKleuyff04pI4S0lzp8KuggEzNnNhAlO0UaHwg0/r33?=
 =?us-ascii?Q?v8Q4ZsQ0LmVYsQxNpdUO5JZmShleQepCcrjblTkb9Ql0LzmHo1TZW0mKA9Cp?=
 =?us-ascii?Q?FaYg3pR89ZWeaexwmfRUOl3RV9xnmqoWvam1YIYgvIdEL3vIFdqj9za3kbdi?=
 =?us-ascii?Q?AIPqk4k/vtp4IAYeeXCrtIhOeZZDw8CCyywoPkWAZdv7cLOU2+6TlvGkgRsG?=
 =?us-ascii?Q?vi527TsVWdbGAjEut7laMXLLZfL3w61QCYmPAmnbVQU/25KAUuBx4+mKUzdR?=
 =?us-ascii?Q?glIiqVYXvEQCBdFPej+/uAMeUAsgcRVYgYVedKx4R2+bePNwO6hFynhTTP63?=
 =?us-ascii?Q?wgCohPoSFTb5KLO3OVneS5GhaQWsc4m6xoJxZXX/N1F0cwxI2YC6PuIGSLLa?=
 =?us-ascii?Q?hmnERIaRv6UHuEk+hOhGaiv9YoK68omUO4F+0ffe9YEoqvf7QhpfCDOwIond?=
 =?us-ascii?Q?4aTZSa7NZAB4VMcyhDflkqHBkyqS4upFeJOvVtFXCQwbPnvk/pBrvdOqfzAm?=
 =?us-ascii?Q?5PPAMlJ+IaOcIHrJOxXfPSwfydHwMx97nX3nhANhCk0wL9K60YFL31dV87UN?=
 =?us-ascii?Q?cahxMjcJ7H3YOQKhiWwxvu2PtqlEmJvpR67w9fiulkeGGPuPw4rqrtcHrzrX?=
 =?us-ascii?Q?odGqTgvhQa1xjtw865PvJ6u5UMM2?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854ed9aa-7ffe-4bbd-6aa7-08d90fd605cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2021 14:56:54.3433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4up8Eu7E/Rf7vOQf4PAHs6Shk7jp0Lp+n+AlHmzGHxHGJ2XJ9auHbrsKXhOTnw3twzSTVIXgbWaL9WaCxM5b4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4811
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Tuesday, April 27, 2021 9:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: expose pmfw attached timestamp on Aldebaran

Available with 68.18.0 and later PMFWs.

Change-Id: I0d7e61875101b476ab50f74ade6dc2aaf1e0bc24
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 13 ++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  3 +++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 771e2f0acdd3..5d04a1dfdfd8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -209,7 +209,7 @@ static int aldebaran_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_2);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
 		kfree(smu_table->metrics_table);
@@ -1632,8 +1632,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 					 void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_2 *gpu_metrics =
+		(struct gpu_metrics_v1_2 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int i, ret = 0;
 
@@ -1643,7 +1643,7 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 2);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot; @@ -1690,9 +1690,12 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	for (i = 0; i < NUM_HBM_INSTANCES; i++)
 		gpu_metrics->temperature_hbm[i] = metrics.TemperatureAllHBM[i];
 
+	gpu_metrics->firmware_timestamp = ((uint64_t)metrics.TimeStampHigh << 32) |
+					metrics.TimeStampLow;
+
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_2);
 }
 
 static int aldebaran_mode2_reset(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 9240461ed1ef..fd0bc1a79574 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -763,6 +763,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(1, 1):
 		structure_size = sizeof(struct gpu_metrics_v1_1);
 		break;
+	case METRICS_VERSION(1, 2):
+		structure_size = sizeof(struct gpu_metrics_v1_2);
+		break;
 	case METRICS_VERSION(2, 0):
 		structure_size = sizeof(struct gpu_metrics_v2_0);
 		break;
--
2.29.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
