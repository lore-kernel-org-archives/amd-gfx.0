Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1DDC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 07:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37FE810E47B;
	Thu, 20 Jan 2022 07:28:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FDB710E45E
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 07:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTkHY6+X/DIzgLQzYpsj8xncb1oZrURntztV17jkQgQOPMg4o1cl/XpOhUkV2NYFM717Y32qFCQz1+Ez0k9dx8s2J39cO36Lkq7hFrGwo1RufTnJlBjOpi1YQ5st2VOUa0txT0f/USAwF15E0TKYW4qIYFwZe1wCG2LLfkNuuslUE2dH2au++y5KD81dSiSAvshWxAlLPmXaJUN7ndihd+IF4fKry/PxoNZ0xo45ZuzBe+/PDPRkKxNJdNiDfEnSXwcWdOlMa1xpNKz1YwL4XPQP3eahhgsleN4bYqVjyzXtO61KtueR2uBNRqy0ueO/mrLdhwOd66kKfREHWqxzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwAu/F9WiexnwjJOLWxVmTrzW6SI7tAeWR4SNntJNPw=;
 b=YbIPCD6oxzE0cks4wLiHxt+Fn5PYWaXIBr6xrjbzpJS4z8uG/YHUXTptMPVNQSpADm6EYNBkAd2Ldd3mTp9r47PGV1fIjGb+/dYSVGUM3+3RGlO5kfQphHae8JnxNaMGiH2ztq+r/YOX9PbttQWrjBD1QwZHv9cXIliOQP48BM8LLV/+e6jYvJHzxNFftqm/sdhZdo4b/uUlT5Vz+j/9+6nw/e2ljQrzsx5VofXxGKfGwomTaCcT734ddf0k7efgo/40HYnptN3Sf4v3BGg7Ai7tSvYU+bPY65C4+TSB/FUK7IaJ8l7E85bG2IB7nnUQGebJTO2klqgroGIVaETLyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwAu/F9WiexnwjJOLWxVmTrzW6SI7tAeWR4SNntJNPw=;
 b=ETQ89+rZl9F0xlxm53UBZSF8zepPAhcHw0c4PH8oN+iyfamCPv5bDCPBW4wXiovx9uR2Pgwwg/+Uw0yjAmqgkEmysn/gEGaI3OEmfrRW9SMqihfpLMr/M6Vyvl9vXaEdMXXDAUxjuNggEk9gsZkhOjLDSTxp5Or5xm6oQ7NPbKA=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB4678.namprd12.prod.outlook.com (2603:10b6:4:a9::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Thu, 20 Jan 2022 07:28:55 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 07:28:55 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: suppress the warning about enum value
 'AMD_IP_BLOCK_TYPE_NUM'
Thread-Topic: [PATCH] drm/amdgpu: suppress the warning about enum value
 'AMD_IP_BLOCK_TYPE_NUM'
Thread-Index: AQHYDc7smtKrebEYdUOpjKnS51XW96xrgwag
Date: Thu, 20 Jan 2022 07:28:55 +0000
Message-ID: <DM5PR12MB24698A507CC418132E84F15BF15A9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220120072510.582847-1-evan.quan@amd.com>
In-Reply-To: <20220120072510.582847-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-20T07:28:49Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7fb4d6e6-4452-4f33-97d1-2101c6029d42;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-20T07:28:52Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 2357d88b-dcd5-435b-85c3-ff5bc1074037
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6090cf30-3035-45c0-a85d-08d9dbe683fe
x-ms-traffictypediagnostic: DM5PR12MB4678:EE_
x-microsoft-antispam-prvs: <DM5PR12MB467888B5626FEC8B0E3B0BBEF15A9@DM5PR12MB4678.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:127;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D95LDwGLcwpBtq6TmxcDe8+42f44GCD7zIWPkD8zWCJyrMF5QFrOVmifHAvgDoDPq9E30KJGnvV0XxktOLlZgsM/ynNnsGIYsSxI5Izix1d0zcPAVQKZLs4ZaWqoy9O9AyHwDwtn6tqeD99VXwZfveaNGcQzzsywDDgP0+NILojZguACk0Fsw/9jeRRN+qUbAkcU0fcpS8favsQKdYMTMzknVP3k7Bg534KFxqoRQb4ZFBOh5cMpW3Ok32PrNk0UKgPY3jrIBQ8v7anWHj61tk/eAY2PjITpFTcw30w3DXwZVH/oEABuCK3L1eHHi3mEUB7dTYFdGPSR/RBa+6GvwDbVzyAP2O0JFLj4m6ZbQWu7yIVABlWdDPJLYafQB+LjC5fn2G+Rft7gUIFAv+llqi2CvPMMHKHTlYEUCafDIaQ7wby3PZmMi7XDGC2rcx+lmm4y52xgQeX7h3coMm57KFlG5UET9YKCPVQ5xRYgKWZ1Owa47FQPaLRId2cq7geQvMnljSTqTLiruY8VSkmp5/ip7d6LX7AZQOQeAu5iglwVOflah8iyaCbVCwlNrPH/MAsg4ya2ksxP2T9SGhzJ6bbYM6rHmdYXGrsa7261W7b7BYtgld52YGKLaQqdpSb9XPI1n2he/sayCP2rzUhXlSjnXG2ZYZb5Oy19DNZB6hxlgyK8k1FGKiPIGCj3zkxhiN/dw5kMvUIW74YQZj81mw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(6506007)(71200400001)(33656002)(55016003)(76116006)(66446008)(66556008)(66946007)(64756008)(66476007)(53546011)(2906002)(508600001)(83380400001)(5660300002)(4326008)(54906003)(86362001)(38070700005)(52536014)(110136005)(7696005)(38100700002)(122000001)(9686003)(316002)(8936002)(26005)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YzonZe96RQlSIf+tEm9RZR3T2H3T7jYTHRhkM2MlXbHI4ATxcpW8ax2PAA3J?=
 =?us-ascii?Q?gOhWWecy5vq+npOsUSKqkRcBumjHwPYBQLBrqPs9NrNnCYmk5X5visxitd0D?=
 =?us-ascii?Q?GWPDOUq6ANN3tPTulSvjPMbaUiC4o0QLHuPaYnyoIlkpJFZvIHT4ywrr0uoL?=
 =?us-ascii?Q?r8tjzDASAzdmwUdE6vRxABk3lGgjNTrFW2CApjj1GFkYtRI4rH4gmWzyeKk4?=
 =?us-ascii?Q?DqxyeTLdlVX1eNa2azFEZdiQsOR6K0Jp6NTduUwIacCD/UqKWx3wIyDpWnw0?=
 =?us-ascii?Q?SymIpUuOQWllizfGxas0CacoyEfk4AqiyYroSakmXrZ+C3il8rE5cl9Zkcoc?=
 =?us-ascii?Q?XaaqLwxzRS2t1OD7WDhHS6cv/yXUTBCGsbVfaa8EBg6DC2aVF+S9V/QozjYv?=
 =?us-ascii?Q?g5yCm/va1btpbN2ldyd2PHQ43KxHHDhQp056JruzOu9cBjnNo/siMkVlcmG6?=
 =?us-ascii?Q?0S9tqPQFDej/xYt93UTgSgR9AnC5a3zlqfnMy9FcyM2r7vbcviyDfvWHcwiE?=
 =?us-ascii?Q?+pCEuAGx2MJsumv2Pl8Qn0J/0/yLDBP6b0GZijv7WcjQbfFIUTNIGtRgvFPM?=
 =?us-ascii?Q?aplC4RhlkvR808vxBe15OFHGeNV6EIOU/pUA2NNd0L+mCszdjdcyZyVF3oIg?=
 =?us-ascii?Q?EIWRR58v9mOabcTLN/ccWtEKr7Op6Y7uqdPpIKV2ohK4mlq72WvK69GL6MRb?=
 =?us-ascii?Q?p7anu7t0bMqwGsVZ8Nuhh9Wt42vC8lmnkxGUzjl+JNFf1pdDmREVA1zd0265?=
 =?us-ascii?Q?pZHlZOLsnb4IuLM7wNxYR6ffYB2qfla53FWErfVzfcnJNaO6yqgo+1IMKzye?=
 =?us-ascii?Q?tvIN2u/Z2H+XKhb8LeNOB7k+pxWYMRzQLPSWlWCcgAOdQFBvPfBvVTa6N5EW?=
 =?us-ascii?Q?TCltRcWvdHG32TPYq2a5LMfEQm1H8zePBeFETJkVmjwJrO3/rx5CZ+VxwyEC?=
 =?us-ascii?Q?qMah/Es7EsADYfRtvS24E0ZU+XwZUU47g/y5Aw6JRiuRUX0UhQsmIjdG5F/L?=
 =?us-ascii?Q?n2FiW4lH5ONsQfxBuxOA56IrvvCzXQu8XN/OT1F52lW91iGnV51y/tneaZ7P?=
 =?us-ascii?Q?DqTfdYxBddr2L/Nf3MkBZNG4xGfW7vhKhQRxDpV4p/G2lv6+9TREdAI416jv?=
 =?us-ascii?Q?WtUD088LKp5HzuzTdC5tHBhBtYBClv/v3x1NmSAHXIiEP/JBv8SxP6Rnukj9?=
 =?us-ascii?Q?OacXQgDGpaqmwSQ+/rAMzDcuEGTBIzjXEwcR2/ALeqyG0l2RN3aq268tyKzI?=
 =?us-ascii?Q?TkG1DbuSidiFEACB4tuByib20iVf3UCjwlQLGjEmwPPnpGrNkDWdpJniBq9u?=
 =?us-ascii?Q?aW8o141CxNt+T1cKAcbWZ0aIqemWRj/dxndTjqsriQE3F11bGZevV6Ym4RJ9?=
 =?us-ascii?Q?9BR6TgH0nSMfPnH2Su8wB1T+xnQ8AqlLWt6FCMfbF7UnOdoLhFs1OzH+xMbm?=
 =?us-ascii?Q?K2zmQaMpoe9GtWqPeSWQNjrXEee+zRi7QI5BOJuJui4r3NxFwf87bqP862L0?=
 =?us-ascii?Q?Fiv1ADYMklzd4LxcN0K9IjbhaL81Cit+ROXDf6OGyTeMAsPdQz9Ebvo8BWuX?=
 =?us-ascii?Q?uFxOLgbM/s72nfHXRbMZn1w3TkpYa3mBQk1vCqSlEVjWKAkye3M+zahpSFp9?=
 =?us-ascii?Q?MvKjK+IkCbCqgmB11F3aaAM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6090cf30-3035-45c0-a85d-08d9dbe683fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 07:28:55.1695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/1VxL45sNsHWCmCpssxek1e8PIjvlt5XAYvh3d2sIchGOa7UVGzo5AEZ8thOCLK6sXrc59QvjvxeyvN3am0lQ==
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Thursday, January 20, 2022 3:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amdgpu: suppress the warning about enum value 'AMD_IP_=
BLOCK_TYPE_NUM'

Suppress the warning below on building htmldocs:
drivers/gpu/drm/amd/include/amd_shared.h:103: warning: Enum value 'AMD_IP_B=
LOCK_TYPE_NUM' not described in enum 'amd_ip_block_type'

Fixes: 6ee27ee27ba8 ("drm/amd/pm: avoid duplicate powergate/ungate setting"=
)

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: If18eaa6e440cfa06ca41854c8c55125dd3e111d1
---
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h
index fb6ad56ad6f1..fe4e585781bb 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -83,6 +83,7 @@ enum amd_apu_flags {
 * @AMD_IP_BLOCK_TYPE_VCN: Video Core/Codec Next
 * @AMD_IP_BLOCK_TYPE_MES: Micro-Engine Scheduler
 * @AMD_IP_BLOCK_TYPE_JPEG: JPEG Engine
+* @AMD_IP_BLOCK_TYPE_NUM: Total number of IP block types
 */
 enum amd_ip_block_type {
 	AMD_IP_BLOCK_TYPE_COMMON,
--
2.29.0
