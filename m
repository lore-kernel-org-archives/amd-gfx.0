Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5ADC3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 07:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA68B10E2B0;
	Thu, 15 Aug 2024 07:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P2sQyxkp";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A905910E2B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 07:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3EPdI4xrDRbYjHGM1PRTmQHFmDVmOrRvUo7FFzAwsPLqN2oHT7a5gyrBrAzpgCJPlpnAHF/8dkpDt8yKQZpoP8NPOan/QClEwu1dIX5h9osRsMY+7A2OBYf5z6Y+SwDBSJaYsRt5krkgwsTBHq53vhKM6qA95/BVvmHcUrWvhxDdsN1uwQa7H53WGMkVT18nK8dzilgN9a3MJfqDFsQlOKmzhltPkFhJkf5onWq9zR1jqLtvhvQmmBuDt8Vekw98bsg6jZZBJ6nnzsn/bPv57vpVSrwU7153ccbfBgqqZjqYEiwI1eSHl08XWE/HSazOTYktsvPJin4/lxAWkR63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJS9OlgOIejcjlqK9RpQhIjBaYWaKYB6Yry9xDVtXfs=;
 b=Mio1+H6xcqF1ANCCoAPnoch7gCGs6+Q90keuQdzTXBT/bDwRXCkZhEiZhw4DOZ0MPirJj+zDqhCNBqTHwiIzOwvWNR4Z47uiSWTGpq/8mSinTYNJ+jckd/dVotiupKPfz57ye9UAMN5T093mt3qDBsob3NZEbrEEKN+dZHL7NZPCTiFSLTrEIfZXennKQxiVLmuAP4/xZISSpB8Qa8iigNUFeLJWiBDYgMvAPiKpdMPRm0Mx8C9qQnAjB3XhlTdKq7KkQ/D5yymQaBkmXeZBd+6B8uNcubEbjsJKbk3Zgmb6bd7C3UYR9pRa1MLKXpG89O+vHDKSW4khm8Y5C4o5Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJS9OlgOIejcjlqK9RpQhIjBaYWaKYB6Yry9xDVtXfs=;
 b=P2sQyxkprIkkKouLBbEE/J9BLiBVo9vmboIDGmgGSFNHp7dv/ojyWlshrSvwURtJJYcaaPnRkW8VKAgyFKhntfWQgow266uvDCbi3mkiBJRFNBj0Ee9X8TxsYpWeEVR21aIX33wpB9f36oTCVkaNc9RSbnTmtoSrAvsrND0cxoA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 07:09:12 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 07:09:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Validate TA binary size
Thread-Topic: [PATCH] drm/amdgpu: Validate TA binary size
Thread-Index: AQHa7uG0YbPgVNYn90ebWdkRKWobCrIn5ixg
Date: Thu, 15 Aug 2024 07:09:11 +0000
Message-ID: <BN9PR12MB5257A86F01044A6ABBB8F241FC802@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240815070615.1204540-1-candice.li@amd.com>
In-Reply-To: <20240815070615.1204540-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a2a5abdb-110e-4c8d-a348-4f920f42a569;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-15T07:08:45Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA0PR12MB9046:EE_
x-ms-office365-filtering-correlation-id: 58cc4493-f3f2-400b-54cb-08dcbcf92a30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1zObsPBkOzOmGz4dti+wlaSUjxr8DQiqzt+NKwL8tR9XiciOQi/z2FNIF34Y?=
 =?us-ascii?Q?+MTQxc0Q0YuyubZEgxkGcu0GFSuw+BfJWIuhq3uf0K+k5hNhJfTO67flkP7S?=
 =?us-ascii?Q?kKhsWqZ/vl04jOopIE1lujWNBH5I0gYYd3N4uTAZ7C8c3Mw8sQbSKNnfrVuo?=
 =?us-ascii?Q?AJixNS+VMIQbehUCWeusiPS8J5T8AZ4D5Od0gYdV0uQhU9IGc89lq8fbYQXu?=
 =?us-ascii?Q?aZnOV0XUhHUmkoOvINO59m2qZSCmmi/yLMMjHio67h0cHkB+zPi9g46wU4nW?=
 =?us-ascii?Q?P2L33dlHf1BljgmDehBcoojY+QIIejriY3HiC97RbxqG3XZKeovEEEpHTwPH?=
 =?us-ascii?Q?LVKWTxUPzvcDb+m8DCOlRUu1oupR2yOB+DoyXTIoGd5t1kP9aahmnUwl8RTg?=
 =?us-ascii?Q?rNYMtLGbmVYsTXwaivGvQjt2AWlgb/u5a6EctPFpGi1npIp5Q1rgI4+8oDdZ?=
 =?us-ascii?Q?knB6op0d1oJIh036WnTz34WKsVcWGMnYMgXa8isTqFfAqB/ELoycuRKr9PZH?=
 =?us-ascii?Q?qAu3Hy/PinhU68svODiwXpWS2ZmZI0yNdKpVdrSAWxJ9WL0bmrav6XUgGO36?=
 =?us-ascii?Q?pcEPf1RZGNeldPnibgh+1uYmaWVDZN+aCDLIwtXyLOLgNBtTr1v4+ZinOgY2?=
 =?us-ascii?Q?hRIxn69ddR6n+WGDfuTQ1/ixzBSljZ4uqYLgNbV8ycfEA2EQexIpMtgmTRCD?=
 =?us-ascii?Q?hI9Vjyg4d0EKiKv6bVgw1jvCYxfelNQQP0712r+ony6U/0Rm6kcvCWA0Xvss?=
 =?us-ascii?Q?Tt6yQ9KK2YY3IE9TSL4gcyOyhGTAEUIpD5WgNKWiXvgbtFiLPWgw7kLlge5z?=
 =?us-ascii?Q?bbdErY59EX+OZ1w5iW1F73NklDgczWQFiq/QBmsjxBMUtbDKtVchgJa7PZXH?=
 =?us-ascii?Q?Y4zParB/PGGvvpb/3K8IScdeCGNfzfFy0qYTSUfSOit40vURj3tdlGnfyuMY?=
 =?us-ascii?Q?LXMY62v7Zwmu9nsPppz1csDQ/OtQRnVleh5fKDbd58AkDcklTkikUZSNvI82?=
 =?us-ascii?Q?Ogl2GWIG1ug5l40fEFUfwDzLIMM2ed4sJXuxK+GsvDVqCmioZD1DyDfsQT4P?=
 =?us-ascii?Q?DZXtWY7aCwwWr/zB6h5oI/ydaarSe1d5Ld/IcUPx27EwT8fV7Kh3k42Eb92q?=
 =?us-ascii?Q?SXssNDuzV8lw4/9VHi5912riSpT7ZY6LziDasaUg77XFZFt5MCZqnmhn/Abf?=
 =?us-ascii?Q?lbFYMvv80LZuKFMhU0eSg/Cn3BJ8kUjd1S8bemZcCVrl41A3xdw7zI6LHEeH?=
 =?us-ascii?Q?xzE8FmAF6agxCwa2kzdbE4ZLR23DgIUsE3rrp/YNa0mMwfpPs6b0y+lUwiK2?=
 =?us-ascii?Q?O4fY5rP+M7tee8h1Sdymt9SW5RMia5y1yHirZSfVSNffo4joIkIatGQEZlCP?=
 =?us-ascii?Q?wK92yeE1u2t+6sOjR/X8BNgOGAAcsb9tWYSIkJ5NnBVjW/xeAA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gmVs/pg0bCbQDxQtqJiIwTgRSSt3qmq5p1+JGTlBXjDgBPmad4/3+vttupL6?=
 =?us-ascii?Q?Ag0VOjgVdOewqqjvlTF/Jck9jUh0dumbW7FAZz7ZyXQOxkJVttCwOuD6YRh8?=
 =?us-ascii?Q?suMJ8kn77+Ow843+Rgz3KyxMcUNjDKNeWDRnqtkvV/u8hbeTAVeJVG5v/k01?=
 =?us-ascii?Q?xq97Fw4f6qc6Sz7E6Z8qIdwL3eRmEF5DQ1EPzQ1YDKlLM55ontxDMnxKtt/u?=
 =?us-ascii?Q?nQ7ziYUxK8/3d+gbaqyuSsmKNRf6Gsg5nfO76ZdP+G8pFKB1dp3L1Z2wYL5F?=
 =?us-ascii?Q?6SVxSookN9hJWJNz3/+taGkZEgDRjFSWXmZTl8cysAu0J+Vwa86jCy/Z49ms?=
 =?us-ascii?Q?SIy2SwOvwzcrcs1adD/zD1zRCWkjmpwxau6qXu1VBUeEUAO5UilzrO7u2wQk?=
 =?us-ascii?Q?nAJMFl1HU0B8OQzOxKFojvVLRpqtppiKABKsPuQKMv+1wqXs9cKeVtnt8GnW?=
 =?us-ascii?Q?rOr6YlpH6HuDbtiNrSHm8ISVhisNZkkl6YHQPBvTVawfEs1R12SOVFO1B1vh?=
 =?us-ascii?Q?cA/cESFjeB8rNsY0GKtRpANrnIw/Ew71RKHHIzxABBxxku4B2mnNzkQZ1JWZ?=
 =?us-ascii?Q?0WYh0U5201W37kxvkk5RdyVIYyKK/DP9SWyLzmLSsvH/bF2w9m94CyUUpWmL?=
 =?us-ascii?Q?Q5DCbtwXTTnMinr8PI7u8Yds5dAT821EyTapTPazlFjkf19hT5higAfTpMOs?=
 =?us-ascii?Q?TNyE1MuwMHoTP7PoWU37jffyjYCMDDIXImyeN/Q0Au1FhcN5cdGlkVrwwcmM?=
 =?us-ascii?Q?4dw6gx1q3eSbfHWHsOoLHTQGerWl+s8IRjtYaIjHNs3oI3N718aCYzgWhFZ6?=
 =?us-ascii?Q?Z24jQH6WYkmZHPRepKf6mG2IgxlhVAl2/8LdgFu8gcOFoYJ5tklAs5nyhG47?=
 =?us-ascii?Q?rhHrq+1TeowQbyQae7q18vh4DdUXIekrRZxZVzjk+jikyJPMX7hh4mIcI6mU?=
 =?us-ascii?Q?ps+Vmw8NrXgCV8fFSpwtRVb2bawqlYxyjeU0z88+i9jFqlOLg7XUrehdViZc?=
 =?us-ascii?Q?NaX3xFLLEyW9Pwdx/LyGLoOpPb9Od2oWmOXGZ2LQqYN7n167yai0LUCrrOiI?=
 =?us-ascii?Q?cJyXYSoxdJaQ48zsRHRsbdoBYyORYXY/8LoK6nyJsfNZj9KN3cGYve2WYH9D?=
 =?us-ascii?Q?r7OnlBPglCIRV7EkCNS25Zh0x1ZvE7/ETOn+44r6nBxQjOssMWJOvjGGZjqb?=
 =?us-ascii?Q?fbIcUOwI1UA2nys0Tnux9JyyCzKLHLpdbGggP6LB2PQGAuSSAzOUH01HtnfR?=
 =?us-ascii?Q?WRHdpvdL07ZQ2b1txGqoo2FJjaDjoAk8kNe28WGHugey1Cb6DGxHnJfSPvmT?=
 =?us-ascii?Q?4RtvniJ24kkRuXiuaUEqRlIPAT0zkUDJY5pzqGKvAzUGT5BUJi2ffHH/3B2H?=
 =?us-ascii?Q?ScA3tW38l5JEJmxx2Zu85Jv8o5OAs+RZtX3lWV/reX7Wqvovne5CA8cCZqU0?=
 =?us-ascii?Q?vwCpWWSZ76+I0ukwk1IlJpr9Noh+mnS64CXQnXKfrZ8lCGLlIWE7kxUt5azR?=
 =?us-ascii?Q?3khz9C1cHlPpwHhU+5I22KwjyNkS/ObJcDHxF14QhtKHYnsPkOsk/zTS0FHr?=
 =?us-ascii?Q?n1GBhGrOIvOH1FV9d17MaM2KnWyFOEQEyZKUtrV5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cc4493-f3f2-400b-54cb-08dcbcf92a30
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 07:09:12.0084 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mGyO7v/VCpyI80HIHKYHwIcAnS/rc8Oldv1YuBiJw/GWS4FFfj3mv8N7eTfgePXPZ0vKeA+fRrdstP7JelreKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Thursday, August 15, 2024 15:06
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Validate TA binary size

Add TA binary size validation to avoid OOB write.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.c
index 0c856005df6b95..38face981c3e38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -166,6 +166,9 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp=
, const char *buf, size_t
        if (ret)
                return -EFAULT;

+       if (ta_bin_len > PSP_1_MEG)
+               return -EINVAL;
+
        copy_pos +=3D sizeof(uint32_t);

        ta_bin =3D kzalloc(ta_bin_len, GFP_KERNEL);
--
2.25.1

