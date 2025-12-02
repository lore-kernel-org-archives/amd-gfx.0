Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3213D116F6
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 13:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83DC710E641;
	Tue,  2 Dec 2025 13:34:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L///BNly";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9BE810E641
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 13:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQzGm1YXqSL7hRWbI8ITYPmzDv3W47FAPeG0syE6tdV0TenV+su1VpkBT1VgpH4JKZl457DcWefR0dMnHUUQWZNUmxekqWTodnt8zcfyPV7fclNZ365KJksoC6MRbkG2lZMof6Zed91CRNA27IjgeIzgavdWoiIM0JnxBorvemEpTZGr88J7n1vv2YHhphnpnY0tFKqK/IG390FHwORkJVXwI8jPFDxN2QLfi/Tp6BY5dbbJg28hw1LzCaj+2o8PkpfsXDKeML3u2l7/mRO6PcYi1/n2yPrdfQEC2unguNZGMgxLbts0QYhqA2Qdq8R976wyXZ3lrzjjt0vIu0pBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdZpHSRPTwNkdRFnALJroi3cH3kU9sThYPwUE6Gx9m4=;
 b=x6Z1pt9EOmY3k5iJosuipg5Fzl8jNzE+QO5jkZTYhwVLNAnpVgPoiAtUhPjxzIxu0UCQl0y03dCS5DaNI8gIxM6hwI1tn/WrBmw7f1vkHuB/KICVvgYRlNzBEgj3AtqQ25YyR7mS7CGB5duV7cGSX/EY4mphg5PWNubRDfPehbWELx6HLjH5Tvf4KbNMNxHxeuWvP36p7qDfm9Mc/3tUBfUt9mhKEyhA3bRTd1PlLDzC0CSS4aqU42NG56rRYPaA8+ej38PaVA6d6L+q3n21uiJHB2+vED0+tNFhE7t8WZ5K1hbAKGT43bHidFO7Gym8AfZL7TrHkLp/tc+NrbSHzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdZpHSRPTwNkdRFnALJroi3cH3kU9sThYPwUE6Gx9m4=;
 b=L///BNlyD0PzoYy7m1JaWXBKPwqcqrYuKsweU5nc3ioXlhCcgni2/LIV80f/+4O+uWsRJNJyczPtlzrnEPaf2fWt47jGpQ5Bqq6+V/+hj06ZZJb3J8Prs0uWcsnLghYSAWXvX/sLFedIf21Ujrj4WR0hS1A9s5FZk4kGY/QlOQw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY8PR12MB8298.namprd12.prod.outlook.com (2603:10b6:930:7c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 13:34:02 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 13:34:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 00/20] Remove print_clock_levels 
Thread-Topic: [PATCH 00/20] Remove print_clock_levels 
Thread-Index: AQHcXtiYJI0jw44GGUiB89DfjOx9E7UOYtoA
Date: Tue, 2 Dec 2025 13:34:02 +0000
Message-ID: <BN9PR12MB5257F7F3F6B834ACDB5FD11EFCD8A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20251126132822.3266730-1-lijo.lazar@amd.com>
In-Reply-To: <20251126132822.3266730-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-02T13:33:41.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY8PR12MB8298:EE_
x-ms-office365-filtering-correlation-id: e0518163-e3cd-40b1-da66-08de31a774be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?iWvcmm1AYoIb7Xf1zvYyjWTJ3IgIx+SN+CqlGTs+QGFHJ3Zh0ykuFn0NljOA?=
 =?us-ascii?Q?eyhfOuVUFFi2ZzC8InCxLC7Nte9xNSb1sonnbfXiQOZx0m97F/eFmgXXTgqV?=
 =?us-ascii?Q?wcWEVhk0n18DuN8AVE5sT46kkt4ni5KbaiEC/gUydLYMrUmvTzC9AOetOLXa?=
 =?us-ascii?Q?A3IDUIIbTeuOZ1ahvQz4lfRozLPDKqXG2w4O8QtWRP6H0GK9qhH6OcKuPtSt?=
 =?us-ascii?Q?HP6n3NXqdzyGEhFtfz9HHwMnE2+lp6rPECynV8xMoapSgB9TPKTLQoRmVtUz?=
 =?us-ascii?Q?pSM8tqwhPRae6R2g1fikJVeuAI5359fsxOb2Su26rm92eYtL621NczC0owBy?=
 =?us-ascii?Q?vs2iGRM6fowXpb9oL4YMvEQpgTIHq7vcnGYbC3eZ11cCYvo0Dd3AATBXw7Y2?=
 =?us-ascii?Q?1XahjWNqJk/XrdNtOQc+vcUnJMpNJxGJvevYUOID4sSN+hbK5cOPNUBzaGB3?=
 =?us-ascii?Q?BVKT0CkYaR8REXeV/J4ACD1q7o2mv1qzbufdf8vyttHswD8CQdes5g4BfRaL?=
 =?us-ascii?Q?x1z+6E7jN8OxOFj5xIO6TZLKydzJ86q/26r2ZnufTe/weXnTZLkr8r/96X8w?=
 =?us-ascii?Q?R7+vsN3VCX+ZoK9/5fx5Og1ubCKWQh0Yka+MmR8TN7e3IaRGAnIqQqTRB2qN?=
 =?us-ascii?Q?wvl1GOdgKnf0IPls17X2fR/l6OZgT5GaeYgP7T+FAfEF6D/5+kL5OjKRQlvW?=
 =?us-ascii?Q?cukg/+ueDFIU4oAYxZ5HPs2VWia++map5ZNSKoikh6Po/35u6ysMYtCIBF+2?=
 =?us-ascii?Q?xEeu/5YBGg54XnVB0LkzS0Vc7jPQnwRMKk2Ft/6+qef1Sm6NCsmhbzIeFc6w?=
 =?us-ascii?Q?+wVtwWKXU1uTtsu9J2xrMnsWnJps1WXSWVruJkv9GF8VPNa4d7BUKwmrFiC6?=
 =?us-ascii?Q?pvKvz2TSZLWY/nrcnaYRgQetUxFhoTQh00m7wJVJZ42GSZErgI45cNL4v9mo?=
 =?us-ascii?Q?jsYO0BbGbuqbsn5yARRtGX7mrzh8eJluUaD/0ZnLahMZ2XMw9sM3ehS1s3bX?=
 =?us-ascii?Q?yoVd4NBl7zzi71bn59ybvJKVGk57eLgSxiQ9fA35+a0EMAQdqX9aB0o1RJis?=
 =?us-ascii?Q?wZGPG8YhHyId/NYKK2gELBQ4ul7iQs1BxVWKkTeSVSljlouuVfKEptsY/Ioy?=
 =?us-ascii?Q?7RTmLB0VU6fLDl/9Bl822Tx5STvVPr0yMc0R0uzLJHzjKEhDIv3eFyGDuvJd?=
 =?us-ascii?Q?RpJwDu93oVPZ78yeW/72zgBkLaqWHeaHOqf1VWCV+K5I+UHJOa+9swY9yT71?=
 =?us-ascii?Q?VydeOoeGoxqzh7bLp1qwxWT2ax/CLqW4W/3GgniQkaaziSonzViPBzjCi4PR?=
 =?us-ascii?Q?Wg3RnmqzzslFLo1uMjKKxVTVoPIKpLfd5udjPgfZwwuTUyH+On4vCsbuTsAN?=
 =?us-ascii?Q?m5hKT8hoaX57yEsK3ptWK35uYnA/5xECzLl0Qt9SVUF4H66WA1ze2THrfk4n?=
 =?us-ascii?Q?+a/xo6z7Hj5Yihzmbvyo/+jdl6QAMpRpmMMIXArhNt1Ut4R+wF1kSzoh9x8G?=
 =?us-ascii?Q?gXXQrpL2MPWigRyoE30cQH6c56WYlKUGv37Z?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H0JRPt1p8WfUQ4OjdC/o8ohahvGR2ruxeq98ei2S+4F/BV80SM4ZS8eNq4KF?=
 =?us-ascii?Q?oKpl6i/twi9rEzjADAybxBYMJTDvC6d/VWnvw5baJubATG4OmerlwmFQvXfS?=
 =?us-ascii?Q?2NtS4ynSQWlENTTJT+rWQDq5rqE7x3lOlvDyzyLulCWixUfym6pv9PCEfkJ3?=
 =?us-ascii?Q?XCatLdAwQheEwsce611CaAN+NjL34VHbk1DfVSDctMh9FSr1DlyhSKy4o1Qs?=
 =?us-ascii?Q?6+ZHEVOM6ap91PMvVMeb6sCwJZFZSCRkaxM7+OBCNFgOvbk5hj+6iRetEDiR?=
 =?us-ascii?Q?mvfx9Arh/sa1J4GT0KeJBCe9O86kP8hVf9t1MEaNmF5WbYFw3zr46KIaXSuH?=
 =?us-ascii?Q?WE5R4+ajxleOc0eTnJxV91SV5fWzDHCMaJzwQSQpdzvRABkq2fJvqJ7kZFnK?=
 =?us-ascii?Q?4mtdhbroraKtPiAOmrw1fLIuz/6OJGYdJzD2B6Uq+Eaua+07dohUq3yNeB3N?=
 =?us-ascii?Q?t/mhTIzMyMarIjoqoNgcWUF/le/Or2CVrAb2Xjm63F9g0oi0MAvCBiIJNJTY?=
 =?us-ascii?Q?FzW5N6SerRjRGvoXWj4tHTS6k8CsRiq98UoGfnaLtCc4kPWmwS4AEcKq+NDx?=
 =?us-ascii?Q?nZOLJjTlxRfSJt5VIO236XqgMxO9d4qKj0P0cMkhPB/kwJNMbDhabsLRf/RN?=
 =?us-ascii?Q?JRI6MvMn3F2JYItOc1/8ZlD7mhI5tuJihPA+a9KAyFwspSzXQu6J/bHtNfUA?=
 =?us-ascii?Q?ts6gWPRmQNOIWzOCwbR/7N+e05gGB/DAddkA4qXCcbaQqy7VIEDa9+4aFvKs?=
 =?us-ascii?Q?lYqSwOFXB1KAY9BE7puKBI2s2He76GDTWvHOkJN+fMvtkLFI6Z/i5QpYzPxq?=
 =?us-ascii?Q?7uSTxZq3OgwFWKD7OOxq5g9S9hpIYq4TS5r/UShVRBf5OYvZ7hDwFA+KgMug?=
 =?us-ascii?Q?UJJ4jJ4p56fZ1w0mWwQN9WyIn1TB0UANn4u1Clf1u5ZRTNWbARi2n5ZzR8wc?=
 =?us-ascii?Q?8V3OCxMwXenaFzn5ML040aB1n53KabPEAobvgxfSAzqJ/oredMJUENpTnTcW?=
 =?us-ascii?Q?IFx0e0D+wZoAYUY4nQGuQsleRArLFASGL6lIGq7sG9q76I04VM5PVhxdgMyI?=
 =?us-ascii?Q?u2BoLUR7LYaID2nxtjO4F5v6isb3QB7vPbsNB9sKjOA+attbSNSMNJHVikq0?=
 =?us-ascii?Q?FDzan7RdzBXQxnWQTcN4Jr8BBpTDHPvHdqmQGlKAX155PmTKD8Uh17bi74mn?=
 =?us-ascii?Q?NSM0TWkUpXCMLCo3ghYf5kpphlONDHIVWwFS5ALYrntst8B4aHi1nACaHyA4?=
 =?us-ascii?Q?vfEgxWg7sTqPutVuPp4SJqp8SbyKYHixNapiKHmUvhS82t807RVHkWyunVxd?=
 =?us-ascii?Q?FRfGqMmaRL/6VU5F6WYJq6GWF+rB1RaUTpdylxt71sQU2PF0aeFKsr/qYpkT?=
 =?us-ascii?Q?upLkRjMGfAs7RDXiw3TYEH58iLqTmpTdyNFKn6cAMkhI2Ick3Hd9DBC2Y6SA?=
 =?us-ascii?Q?XVZ9XM8CrdiTuMY1lZgusw8KrE6CAkhaogTj+e9wZJljnpSuxryCrII3eRJX?=
 =?us-ascii?Q?Iqqpd/IZ7PJcqfTfmUqLNkp3nqDQVzLn7xtIWpBdRVAbt+HvjwwkuJfyNRMG?=
 =?us-ascii?Q?l/kUl5BLtsZ4ZVE9D68=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0518163-e3cd-40b1-da66-08de31a774be
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 13:34:02.0624 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MuKxZxGt36ZkbBUG5xDauiX6jCRMFlCCYt+62JMc9p1t8nnNM6sdTZf6wTMVMDs5ysWgYEntVcZsFt22muB6Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8298
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, November 26, 2025 21:24
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 00/20] Remove print_clock_levels

To print the clock dpm tables to sysfs, presently there are two interfaces =
which provide identical functionalities - emit_clock_levels and print_clock=
_levels. emit_clock_levels is more flexible since it provides the offset al=
ong with buffer which matches closely with sysfs_emit_at interface. It is n=
ot required to keep both, hence drop print_clock_levels.

Lijo Lazar (20):
  drm/amd/pm: Remove print_clk_levels from navi10
  drm/amd/pm: Use emit_clk_levels in sienna_cichild
  drm/amd/pm: Use emit_clk_levels in cyan skillfish
  drm/amd/pm: Use emit_clk_levels in vangogh
  drm/amd/pm: Use emit_clk_levels in renoir
  drm/amd/pm: Use emit_clk_levels in SMUv13.0.0
  drm/amd/pm: Use emit_clk_levels in SMUv13.0.4
  drm/amd/pm: Use emit_clk_levels in SMUv13.0.5
  drm/amd/pm: Use emit_clk_levels in SMUv13.0.6
  drm/amd/pm: Use emit_clk_levels in SMUv13.0.7
  drm/amd/pm: Use emit_clk_levels in yellow carp
  drm/amd/pm: Use emit_clk_levels in SMUv14.0.0
  drm/amd/pm: Use emit_clk_levels in SMUv14.0.2
  drm/amd/pm: Use emit_clock_levels in SMUv7.0
  drm/amd/pm: Use emit_clock_levels in SMUv8.0
  drm/amd/pm: Use emit_clock_levels in SMUv10.0
  drm/amd/pm: Use emit_clock_levels in vega10
  drm/amd/pm: Use emit_clock_levels in vega12
  drm/amd/pm: Use emit_clock_levels in vega20
  drm/amd/pm: Deprecate print_clock_levels interface

 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  19 --
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  16 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  16 --  .../drm/amd/pm/pow=
erplay/hwmgr/smu10_hwmgr.c  |  65 +++---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   |  87 +++++---
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |  29 ++-
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 141 ------------  .../drm/=
amd/pm/powerplay/hwmgr/vega12_hwmgr.c |  52 +++--  .../drm/amd/pm/powerplay=
/hwmgr/vega20_hwmgr.c | 211 +++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  28 ---
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  17 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 193 ----------------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  27 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  39 ++--
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  52 ++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  21 +-  .../drm/amd/pm/sws=
mu/smu13/smu_v13_0_4_ppt.c  |  24 +-  .../drm/amd/pm/swsmu/smu13/smu_v13_0_=
5_ppt.c  |  25 +--  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  30 +--=
  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  21 +-  .../drm/amd/pm/sw=
smu/smu13/yellow_carp_ppt.c  |  25 +--  .../drm/amd/pm/swsmu/smu14/smu_v14_=
0_0_ppt.c  |  24 +-  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  21 +-
 23 files changed, 443 insertions(+), 740 deletions(-)

--
2.49.0

