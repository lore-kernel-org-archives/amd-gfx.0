Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3156BC369CB
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 06:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB29A10E504;
	Tue, 22 Apr 2025 06:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jr8kxg6S";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E2710E504
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 06:36:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/owbl1pWXCJULkygkvFzNnM5zGv2Uc3I0S1jDe73IQPT2nwVqXTdHwO0xkmjr4ng5qkunMh1n+2hV6hyMs9JzFReli1m02trg/9u+GYvg7RkosyIjb4y32qcqduNQ8JjfBdFy0ULc57CBPUaZLeR9lR13Onl/3Pi1MeoIH7I6Nvmhb10Vn0YAO4WTiSEg7lhIwnhbcdpcEF0g1d+/kyucnaT1/hejTFa3grCX/H2uZRdhXYP+HkAn8pV2Vbb064httLBjrDSmwNgMM+RAjwBOM1ZGf9Xac2tkojhe1U5LH4ctN3q6ICuwp5o2PpbzUBuJoklB9I+0eyUYB6gSaVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RskWSjouPo+kdCtKs3FMkbpgvlaSHuYv6OPuylNLLmc=;
 b=YFxfyj8xQRw9gZkXFWwHo6Tx7l+JO3O16GzVpjo2XklU9APBJupZc1ibip/RDS9izcyIo3YmkRCp1g4No/OEEaMM86CpTx9VtYmbO3+cXyLIQ1Ud5QBannMjqwgZ7K6PNg4g52nVsIMTZeUiZnnVm07V8WmmyvZyk5ybKM6WEtjNJLC9+5Dpv0VL4+r3tPmUGTAaE1ou3YeIxB6clf7lL4gl64wC2vT5Mq1hG5UtFpfpkWNfcbimdM4ZWDXaIcqjh/g2GUlCzDScZq1ousk2lPjjqz957L0s//Fy1sqC8XIWmoZ8zgm+eIjLLzTJ2yrfAk04T4c8/jTeAoDRhp6tVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RskWSjouPo+kdCtKs3FMkbpgvlaSHuYv6OPuylNLLmc=;
 b=jr8kxg6S42pNorzvRmstR4gbzkhu3Fz9uR3t32bNQoLLpPGxw9EL+EabFnRrPzpuD884cxFctPmGZ7nr0Q++1zrBzTZa8iMKl86thk9FSuMnqbnkzlmmkF3AqBQFFQSyfk9V/e2q3VCKLmLzGSHcL2kOpxB3tjg/WaUb1qxcrvc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 06:36:08 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 06:36:08 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v3 1/7] drm/amd/pm: Add ip version check for smu_v13_0_12
 functions
Thread-Topic: [PATCH v3 1/7] drm/amd/pm: Add ip version check for smu_v13_0_12
 functions
Thread-Index: AQHbsGsjU+NTW5ljVUCS2HJrZWWWubOvQLqQ
Date: Tue, 22 Apr 2025 06:36:08 +0000
Message-ID: <BN9PR12MB525718684205F46252ADC8B4FCBB2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250418140633.420887-1-asad.kamal@amd.com>
In-Reply-To: <20250418140633.420887-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=53e21f0c-36fd-4fa5-b564-62d1e63f2380;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-22T06:35:47Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA0PR12MB7652:EE_
x-ms-office365-filtering-correlation-id: 80228f0f-29eb-4845-671b-08dd8167f721
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?WZ55EPFmkUMbM6026N10VAYvNTlNxvoa3s7SRHHOju2FUoqoGR5yOCCqrE6W?=
 =?us-ascii?Q?KXGGzeDMFeLx4KlOodLGl/imAR2xmmbX/rdWSAJ0acMmdYOCsn6125A7bE1W?=
 =?us-ascii?Q?nno94uPR+lfkKqpYUze9j2pW7OpWpwwX6R9cLr7xP8dQv8b3koD7NMtg2xWe?=
 =?us-ascii?Q?KEv4yWeGa+mhq2MI3BsarxxFOc5tRnqm8gEPIB9PE/nhxP8FK9PuGDEfl8px?=
 =?us-ascii?Q?oXpC2MNx1/bjC4Lugu5+0hZfy7252/R0QqZuDQT6uFaffnjQSNLUcWE2epyd?=
 =?us-ascii?Q?oQPAAQs1RRnFaKrHfAxfmCVnAu/Y3K8Wd9LGL17RnMnYgR75ao84BVtUXDz2?=
 =?us-ascii?Q?GHg4J5w27k6/N8imqybEHQY/2LXtvJHJDRpMWxUzep5+eDpj++5Grm1G6Bdw?=
 =?us-ascii?Q?DYFOcut9z9aA93ylWAgULRbJHPGNdaefDooPjLBujk5OhfCU1GoqNttsW5kc?=
 =?us-ascii?Q?2sFKYxcZxF0zRabQs2Mik1B5t2KdyOvK4ZmZSNlO2/thIJp+Fs/c0lqB0ekY?=
 =?us-ascii?Q?7+rE0OI0Dp/lE+yJP3m38ZiAPyawTpHPmXWFNHUgga/6qPOOjletra7VdD5l?=
 =?us-ascii?Q?H6ezwdNCJ2LPJiFzGxbxKj4agwINZYtzRSOf1W7OTAE+JOWFsLpXftb8um+4?=
 =?us-ascii?Q?byhDOg0OtZYAtydl62/jn2RRsYiiebaTN1c+KsQ9XaajgkH432argu6Dy/lE?=
 =?us-ascii?Q?XjDzMhctoo5LZ2/An0ldWil2EP8dpx5IIEW6rltl1x7NBpPTBs8LFbXHFkbH?=
 =?us-ascii?Q?7EvL+1yyW5g3dieCgJgZoyMv5X/z+qwxQObo6vV7abzmy2m95+5mt599Miv/?=
 =?us-ascii?Q?OU1PKiuLHl1I39zMxcTggk7g3XPzNX4ydDKdGQ1GUY/HYbYmv2Xi6nikh4oV?=
 =?us-ascii?Q?qkJf4peXWDCaaR/RtCqi8tthYOALswkIPVZ6lqTDDpwUAtUtXOaqDuGKFApE?=
 =?us-ascii?Q?g5bl02yWqE0e4ePEFSAvvNnzbAwX5s1pHyOkjlafaGZq4kAWWMXCW3OOlpLs?=
 =?us-ascii?Q?abn/7O0022/jRMTwMXpV3UqL3rvWqmiyNz4tD4zQKkbwvjKDcDktdMMk3Liv?=
 =?us-ascii?Q?jBOu11OqJsPYyX8jn5zX07pseDWti/crCVsBAxN8eINdfL0DAPKzzEqu6Fi4?=
 =?us-ascii?Q?uO3Jn9MLlNCm6rb95EjGjcXbGnsOP4+roXXVfWlsKW3dKT9p8h2uo2UwdGsy?=
 =?us-ascii?Q?t/s3Bm+4fILuiXDsX/LAZqsJ5tsRSZVKS2npE1ZXxloM2h7cM+xIB7sPv6Xv?=
 =?us-ascii?Q?i1TJ2WRvIhdFmxNEDKwaY6UXbRK0jaQ+cfQsOTafXbeNb0tMxLGPMHtuPPlp?=
 =?us-ascii?Q?cMniVkfaE8ZfaLuIuX7wxY/ig8Nw/6TdYznxenkcw255uYhF8uA+1gpO1R9k?=
 =?us-ascii?Q?KVbYS4b/itxrDvuQU9g5tYlpjmn/Soz12IC1xLDfJIy2laoOXpRNeCcBpK4M?=
 =?us-ascii?Q?20NILaK1S6JmsECRg/V3qYermfv6gtdcDmLBB7qpDBIVYMEFlJpn0w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dr3M04Er78R9Kj7+ZqaJFSDdPekKk2Wy31yvan+0thLH1lPenaKjYLQtY91W?=
 =?us-ascii?Q?UDBg9BJ0GopU/JgjpOBztzb2VEi9qyDqh/mQHF/D1wEcXOxd9oFQ77HdIwO+?=
 =?us-ascii?Q?kVNG6ke3ePTrG1fqVWQkq4WfaSIhfaCEhMWiyWXpFXINDTRRUowmVR/c0kBb?=
 =?us-ascii?Q?HjQnhrCzMkrmH+2XTL9hsJcXCOJYVxWhMMUF68Ktd57HMFe+U1+I0Lpd+0Hb?=
 =?us-ascii?Q?gz53/jj4ADQgd7EYYr9we1pdu7n7z6oBYgAtwcumXhRYVpT2yLohWGx+UuXz?=
 =?us-ascii?Q?ytIKoN9+6GBuIRQltBVsodGdXizMZQeF+VA6o7mX+s3q5S1huxZxH4HoxMKJ?=
 =?us-ascii?Q?57HjXzmr0xWvEijdysNZgEafVPtZHha78jnOCqdYPakk1MuUpQF9Es5+HUeg?=
 =?us-ascii?Q?1mulEY3hSznDeBY3Si5XndOZdZ2ZhLlj1CrENExAvOrQxJpfzP86gpN6d3ms?=
 =?us-ascii?Q?9l+BFPE0+He+bp+32CGkaVVweYv3u/h3lMZ0qpI0mXAcb+GsjOZnucxvwXUf?=
 =?us-ascii?Q?nCCvHxctfJpkC4Wq79Y8FOKEElGcbApLGc6ExN6sR7Ct9MJJIqh8U3TdzPQm?=
 =?us-ascii?Q?LOPcLQYN4wOfJ14vtqAm7+0rr26u134+8kQlZKe8665TqBHT7zbm0V1wlHlR?=
 =?us-ascii?Q?ElhwqN0wQuPzW/HxZzMCU95hxmQWAgnrGXEbdJEbkI3hIiSiKYL4x8T0GDUs?=
 =?us-ascii?Q?qOpGvG8bZqKKaI7zfjJEzwTgg059nt/8RzoCbHfqmcGY2ri4/h+526dZL6zm?=
 =?us-ascii?Q?f2UfHpQOUBLyRHrW2eRxn5jN/vjcQC8KJX6TZYbX1gnnbvLUQv3DAsc92bL/?=
 =?us-ascii?Q?7qhVZf51AwCvmkWb98SJsIq1X2ymA9aq99efYZjlkgJDsoHqJNuRE23P5Jyt?=
 =?us-ascii?Q?FScJ2ANmclusoYnNBH6u0YflmZ01a2tUFG8xxD0uG0TVWOxqa2SXTcgjxTbz?=
 =?us-ascii?Q?HttIRTEFERZ/y7bg7STpcItr2XAB0zCtz5hBcchisQ7IceS9DaDjXdP8S3EG?=
 =?us-ascii?Q?i6AlXuP08YutTbEcH4p4CMOcQNTG47x1Y42KhMXAdcA0Bu04icrtISKQux+o?=
 =?us-ascii?Q?cvCTHVR6xN9ClswEs70j7kR6axep4LpuRzPTU9T9sQCTWGJoOgeNQcrpdtz/?=
 =?us-ascii?Q?vNqZvG+SlTegGkPL9w5VdbKdkpEwb0qcZC3bq2YHM8ND+I4hSZzql43a7d51?=
 =?us-ascii?Q?uTs6kB1Xg1VYYv/rqxhuKnKua73r/B31Z1OR3stxIx90Uev3fe/XhQxnp3mf?=
 =?us-ascii?Q?fc7ALOaQbjuCkU020Wa7pgJZrh9aYJWaJsXesgAGOYp5szQKRoGxO26qLt7R?=
 =?us-ascii?Q?K7N/ItS8Hpv1lB72xtoS+xqZx7SbsVEO8GEVFvcUG1DG+6AjyjesmmQzzQPf?=
 =?us-ascii?Q?gXXEb1Xx8Fl3bV8HUi6am4FVcmiHgyj601kP5SuC95bGfDzejAxcDhDYec4Y?=
 =?us-ascii?Q?Wi/5Y7Lulh4YKr+D6biQN5oWB0IeIu2fFPgzc4pVtgHyWVTSpv5fOuYRpFRy?=
 =?us-ascii?Q?x2XS1AKwVGQdcOpnnd18maileAnZqPNVsWeaSBfvszvq3TuSC5rdtKxEby+c?=
 =?us-ascii?Q?20dNebamMHUI53/Nauw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80228f0f-29eb-4845-671b-08dd8167f721
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 06:36:08.4161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3wsa1/XJyioqNYD3otWpfEKDSro889XRqO9J3tpVa1JDJG19JE6SB5kRDFZfcrxoaBRepLPKP2k6UNzBU41Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652
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
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Friday, April 18, 2025 22:06
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: [PATCH v3 1/7] drm/amd/pm: Add ip version check for smu_v13_0_12 f=
unctions

Add ip version check to use smu_v13_0_12 specific functions

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 6d84257b5301..177c55f457f4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -748,7 +748,8 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_=
context *smu)
        int ret, i, retry =3D 100;
        uint32_t table_version;

-       if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 12) &&
+           smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
                return smu_v13_0_12_setup_driver_pptable(smu);

        /* Store one-time values in driver PPTable */ @@ -1131,7 +1132,8 @@=
 static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
        if (ret)
                return ret;

-       if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 12) &&
+           smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
                return smu_v13_0_12_get_smu_metrics_data(smu, member, value=
);

        /* For clocks with multiple instances, only report the first one */=
 @@ -2496,7 +2498,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct sm=
u_context *smu, void **table
                return ret;
        }

-       if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 12) &&
+           smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
                return smu_v13_0_12_get_gpu_metrics(smu, table);

        metrics_v1 =3D (MetricsTableV1_t *)metrics_v0;
--
2.46.0

