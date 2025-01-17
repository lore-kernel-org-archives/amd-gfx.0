Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779F4C02183
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 09:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2721410E3A5;
	Fri, 17 Jan 2025 09:19:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GGeAsYbv";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB37310E50D
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 09:19:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvw93B6cP5/uW7WwkeAZO5OiA+rDe705rEcnhQHNn8wTtwKQNXhfqJBHrnYkyqdT89VRh7JHya1N9JfLxlH99Ra9zX6aGzCIRM7vn0vJcE/mkfUBhG16xqIWj+rna6IaOBi4Jl4gRTRHTgVv5sUZvI0+kkezHrtYQNIBuWA0YSgGPVek/e5PpVevNQeho1lZbSECQO5IHBRUDYFFuQOMm9ebwEpJtKNSyU03DU2kIOInUM45Wm5m8+f58gbeRRiQ1jYXf366V5g/Mrv3IPPVSIbwQ0Y6cv/d1NyMC/Pp7lbxxk00fDESR4zpp13qsb+32ya1LH5jzHomSwi1FA+lww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fso4nDatTIIJ9jF219Hk4J6KK3n7EbJDX1aZyc9uYnw=;
 b=FdhMG6GR5fzk3i76TFy6S0sH04WvhWXmljbKMTFG0C/yHY9k8q1UU6hlVz+7xjpLjIat3N6r108TmbqmZ+eRESNESKrDYVBJNQW57GnUCTLEXOiY+FubmTRPu8RBMj3KSxBJfbGlkcK119T9kjMdlM+Xl/weyLrLi4QTw3iKEbWeU2mSvCsrYEE2ZTD54yb1QhrhHHFJ0g6ugoZ+az37d4gLI+Q9DvGLPJAZC1YSLY9U6sqYxCvwzyyRcQ3OIfw65ZW01KQq5PV0LVmuC9IcinVlrbx2np+XLxiq9LuJl84NTVOK4vCAbQAJSzP9XLrXobdnDSvhPGLyR5cJXFx/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fso4nDatTIIJ9jF219Hk4J6KK3n7EbJDX1aZyc9uYnw=;
 b=GGeAsYbv2Yb0rL52+aoJe5WnorUk/h0wW6QXpylDYmzvLya4EYlRzqtQpMivaB6cyEBlaXRPgG1B9CZHhL8Mr4fFNKlEKxpYbt+ei3v38JJjU0AQm+rWBCqVUWdxkY9Nd/jWAmZPXOLdDjT3QWCzUZMhRPB6iQ+uW3/i7kW/fX8=
Received: from PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21)
 by PH7PR12MB6563.namprd12.prod.outlook.com (2603:10b6:510:211::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.15; Fri, 17 Jan
 2025 09:18:57 +0000
Received: from PH8PR12MB6841.namprd12.prod.outlook.com
 ([fe80::8cad:63eb:fd59:940a]) by PH8PR12MB6841.namprd12.prod.outlook.com
 ([fe80::8cad:63eb:fd59:940a%4]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 09:18:56 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu/mes12: enable mes pipe wptr polling
Thread-Topic: [PATCH] drm/amdgpu/mes12: enable mes pipe wptr polling
Thread-Index: AQHbaL4lmXFMx/FuZUSEJfoJ+YwebbMar+8A
Date: Fri, 17 Jan 2025 09:18:56 +0000
Message-ID: <PH8PR12MB68419AD5B94A0675DE9B0287EF1B2@PH8PR12MB6841.namprd12.prod.outlook.com>
References: <20250117085918.1748711-1-Jack.Xiao@amd.com>
In-Reply-To: <20250117085918.1748711-1-Jack.Xiao@amd.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c7e34040-c11f-4d2f-9cef-688ca863ec79;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-17T09:18:03Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6841:EE_|PH7PR12MB6563:EE_
x-ms-office365-filtering-correlation-id: 0ff01eb2-9864-4e49-0fa0-08dd36d7f851
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?UD9cYuqOSekPqnm+J7MqsdM901m8nRKS+BFUWSaoNK5dZvAtUTyQ921FTwpa?=
 =?us-ascii?Q?dv9JYD3sTO37EX50HiwZfN1E3LaFcpxlcSt+P5jIQQ4U0Bv5JaVQH54k2dZi?=
 =?us-ascii?Q?GdEvScDH8iTqyVMQhow1K3+iuXEjJD9Jy7ESewjWp6Ddzl9nvUgJupGDplaP?=
 =?us-ascii?Q?D2dpTN65HilrDQK1UxdbyH7lTB4RyUkWWgm+muH9YFWZsSHTFwHxx9Qs3iCI?=
 =?us-ascii?Q?kQAZkMLAM8yjD/ib1Hj6qkVGLWWYfTXfPgaOfJvoiGSj+sVOlw1ZT+1CZ8fS?=
 =?us-ascii?Q?jP3VFo336o7ufJzFLa42TuzAW4zX5LxUAAZa+S2EfOgB277HzDsq0zQz4Nvm?=
 =?us-ascii?Q?WuTzlnEvD6Gw+V1M4+RJHIqi+XyVmpVtr3EWCkV/CB5icuE2lUprZ6MGv6Is?=
 =?us-ascii?Q?n3GECdCnHZzEY84xqiipaVHeeJ2wWX1fZ8gWpDcsN86YDREbFJTJgIZaVMs8?=
 =?us-ascii?Q?4e5HgCuM5PdUa42YiInDe/lec+P8kBpSOb7kISCfzrh3P099xfXIAY2Bc0d0?=
 =?us-ascii?Q?R8aCCfU2UnY83l+Q2S6YNmdy9svV7VjNJTi0VGhZvNeyjqWaiybISIQnHhW8?=
 =?us-ascii?Q?J3oICA+Io+32kG5PnVNBWNcO1DeqV5G8zT6BJ5iQq5vanS9C43YRVSuZftak?=
 =?us-ascii?Q?/76HQbfcR7OZBhNejZ5bKBFT1U6OQptgjyEnvch8SBmgpvj//5Xx3l5qC/fi?=
 =?us-ascii?Q?hPIxV4SG1Y9ZHSg97UPndjIaMQrTUWrKBWKf2FNGW2VWzDRxnmzG/gTfyzwY?=
 =?us-ascii?Q?NL4FpH5LnxG8bk0ZtzkxRVn/Oqa8hJ0va1cGUE91cyPdhTT56xKhPmle9qTF?=
 =?us-ascii?Q?glB8vn+zYw36ZdG7BoU2+2RchANTbsKDaIhS91h8e3NXBOwn0H4Paa4c6a0C?=
 =?us-ascii?Q?kHm/lKnA/OLbnzmrWVh0C2seH1GA+HvJ8c3hAt48BXQbhavx/srz9BrQW916?=
 =?us-ascii?Q?TJceYux+t/tRJ1ASyETS1r7SwyFEcJAf7zyoo2ER0365akssw69B62+Qu8Sr?=
 =?us-ascii?Q?4ovCahef+j75ZnldN9HhipynRciyEmot+JQfyHVVVlLvdhlFdHGMEDKk2Qsx?=
 =?us-ascii?Q?ZKsUX5hDf0BQOk6/2Af+uH+KLuFJ7udf8XAMfGIJBHGl+ok1CJ6xjytuV7S+?=
 =?us-ascii?Q?T8NKLMQVUpTNFruw6OjAllW2+mRY99iQISLVo4lqwsCvt2ceDx0E4IdxC779?=
 =?us-ascii?Q?hf9MQBG9JMvJqLQIa2CzBrGhYEmiMM55I1/nvtOJCXHjSvaRdnK2a6x3JZJN?=
 =?us-ascii?Q?VLW24kEmscqb6i4EnzwbczcKuLtAMCTczfMLwXGvRuNko7tCiZrMlLmOqkgw?=
 =?us-ascii?Q?qXy5Zhz4DGslHDBjavbh+qbnR8IuuuFhy3+Xa1EPyrW1D3PdJNC6V2RItG9A?=
 =?us-ascii?Q?BZzPLtPDj1j8HIrOsxxQxviiYXHTjSq+vV0LVZZL62IX/PTiTtI4BbTEfXeh?=
 =?us-ascii?Q?Rh/YOIear1THLD6DRqtIl2NtkJW4YANa?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6841.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zP+8ZLymwkV1hygQvjsDiO6bNlwovxb9ZjtlJXsivA8XCE8/xXID8bVMtglZ?=
 =?us-ascii?Q?crVg/UrmUbA7RLUyFzMKSlLZkH7T2WQPv1aKtrqhMigbWTN6vhEHzSBCXrgr?=
 =?us-ascii?Q?wDEgIumHlHBpsMzlceljfEBp3abWon1MD5o/D6YSb29UhRF27LHPUuEyeMN8?=
 =?us-ascii?Q?AG+QrSP/++HTTaeylh2/xJwDZa21iXR672ARRyHIWnszR2IVeZcI9LkmIRua?=
 =?us-ascii?Q?QNGiAhrapenWr7xJlQnzZVuXu6Pqp+R8VqssmTsM/ebkxetBucLtIP16mG4i?=
 =?us-ascii?Q?E3rKrWwtvHRB1PBhlX+gxh1drUyOzw/c0h9w0JY8HZm7/7JfcnUL3oYg3MaT?=
 =?us-ascii?Q?FH4gyDZcQRJ7uYuqS0s1PpFV6U9rhXjAYEV7QNA309zK7zQOIF+YzPghkS45?=
 =?us-ascii?Q?DC8QvMSmn+202BRnLJFv88TCMKyDI9tS1Rmy5FseJpCHLEO4Hg522Xcuyw5e?=
 =?us-ascii?Q?Z4l83S0u/8KRbPHolcqixQL0jA727aiWPhGN/SllITSWk1npmKBctxlVP+Nu?=
 =?us-ascii?Q?jNUCCPQo22NJyM4gcsK9Es3GZbkJYReB2R+ledtw3Lif/p5Hs0INsz6G5+o5?=
 =?us-ascii?Q?+t6WwZvreddZi7Hgtg6KCs5L4kPTOMXSWz55dhzk70FK6FFQBJEkCdHiMBeH?=
 =?us-ascii?Q?r5ijeLZ25CcoFaZI7RkKhMxIPSvh3iF5HobUo40nu6X9YbeNnUvo4eXkniKu?=
 =?us-ascii?Q?NVLfWxHQSGPm8kVmhOJWGCABNghqO90CC9rc+cIDj7fIrvAi94ku+AR9ani7?=
 =?us-ascii?Q?jzAUJEJFE6Y8/3M98REhF3s1yCTdn/D1LnS5MFTwxrfU4iEI38PbewJjSSga?=
 =?us-ascii?Q?AMjCHNcv6MnAQupS4O2DsERo0pXUAhj3+y0O7TXcMpnSYCW1/31akk0qFHY3?=
 =?us-ascii?Q?UkCNhNzyg51kwnCEonPDZwk1mWC4wpZ3RrdFRmmIs1nRZB/bQXSKkki/HfYK?=
 =?us-ascii?Q?o/HxxR/5eXsAgb/1Qv5ZQJcNbKR3HvcoCBtgdHf4AX1cvvQGtsfL3UFa6Dj8?=
 =?us-ascii?Q?8CDATorxXq1IQiPYeo/1Fn2kD+gZKQuIzhlRYnEY+yNgQEicSCBotIw8WaYJ?=
 =?us-ascii?Q?dQl7Gn3lH5XpchFmRPrtJ6WP/rzhNQjH4FDmswjckiWeHbpwuKJO/jQ3X6H4?=
 =?us-ascii?Q?rpL/TGkTNPvb5dtkd4ktWsWq3WueIQzGTXcUOEo8yL/BC+hNkbOWXX7lBb0T?=
 =?us-ascii?Q?z8VAKsi+j/9mIDTCqHP/N65FLWbKAzBqo48S7W6AGjy+dRjGVNiu6JEyQz4G?=
 =?us-ascii?Q?pJXxYWwTCC4qQNZRPiXpSzM0j/b4zOhj3lBbMLI1o+k8zpbTTJpOLHS1oThE?=
 =?us-ascii?Q?Aba9VggCSlfVhAVKUx+tCBXY/FrG2hwAYNZjzwDgtUiUgHVlBusGSxS9UMbH?=
 =?us-ascii?Q?yJQ4hQaq8v5cgjP677OUGi6mpbKi2oj5VQ80QVQezagarcBVWizb44bHHEL5?=
 =?us-ascii?Q?BQ9zzXi0UWF00A0/euBUB7ZwNgfqu7ubgOS2uto5p4ZeqAsMz6618P+cybcH?=
 =?us-ascii?Q?y5ftFgunhzrj7EySdki1Rb7Zj9ZAw4XBMpboBDk5RO21Ko0DAKQ5XOWl6Kb6?=
 =?us-ascii?Q?3ok0pcVYXNzPyQj7W/w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6841.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff01eb2-9864-4e49-0fa0-08dd36d7f851
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 09:18:56.8014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nLKPyxdQj84t6mtBrDz8qvaoffG8+keghgUigi3cj6UJ1KMvTFzrLNhNfJiluYso
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6563
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

Dropped, it caused a regression.

Regards,
Jack

-----Original Message-----
From: Xiao, Jack <Jack.Xiao@amd.com>
Sent: Friday, January 17, 2025 4:59 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Feng, Kenneth <Kenneth.Feng@amd.com>
Cc: Xiao, Jack <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu/mes12: enable mes pipe wptr polling

Enable mes pipe wptr polling for gfxoff might result in mes pipe wptr missi=
ng.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index 185f4b55dcca..e516e4598017 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1256,6 +1256,9 @@ static int mes_v12_0_queue_init(struct amdgpu_device =
*adev,
        else if (pipe =3D=3D AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
                adev->mes.kiq_version =3D RREG32_SOC15(GC, 0, regCP_MES_GP3=
_LO);

+       /* enable wptr polling */
+       WREG32_FIELD15_PREREG(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 1);
+
        soc21_grbm_select(adev, 0, 0, 0, 0);
        mutex_unlock(&adev->srbm_mutex);

--
2.41.0

