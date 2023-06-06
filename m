Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F2FC77B7A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 11:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2727410E224;
	Tue,  6 Jun 2023 11:34:27 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0FDA10E224
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 11:34:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9C86MCnsXGt6GCnTCBe/UNCD1hMcQEAt/Vh3kq9jq4JwWZiYKu8rDRXH1W/l6VExOcUbrc18F5hFUvF6W/hA2RQaboidDTR9Oy46WPUr/MRYYAEBnN7rp0fNl558Xtfum+8hasQjq0KI6b4Y3ZNv3zmfImMDpHvZMq6XrPUxv/mha8r2b2SYpYBzzanoMpHJTXeQMMQT+RuC0jnk3x0TsxEIRFTY9hNvAvhbv/183LgpIqWmmiP9EKKUWywzeoc2aQ04j0qjjbskJqfKDmLbJ3YJ5pvVXy+DIMlRvN3KPYAQSj8GBaS94hWqI+8TiSg3kFRybRKjZWHRopIfPe/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/sgZO96ZbRQ6/EPx0aHxlR94qnhKYVclLJM6Af36+A=;
 b=KrkIl3P74ODocDxSseZfC+7A644MqKTcsR/fX52lxw6uNN4fAd0sj2f34SiSGmywm48l03918mij+QQqoZRGcg3nvmlDYII2Bc9EuFXJvCHngfUW5omJ9HKjpxUNf1uJp7D5rFK1WBmgr7HOeLIIS09vf5ToBDrBzr5x+LzGeZ3MY7boD99M1e7wcYSW3wlJY3kjC27hjBkVVn9brNdojRiOJzIMzz2ml13irR3egwPQyUmsOKXHWbGd2Uc0z30l2tp9MLLYviHAOKOCZrdrZkYiCqvswj74DbzP/Miyp0i7OITbBc5gqD2amVELoRRQBjCoy1viRs7QlGcqLH/1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/sgZO96ZbRQ6/EPx0aHxlR94qnhKYVclLJM6Af36+A=;
 b=E4A74m9j8q2qLedMn690b8z45//PL746SWjbRTgTiTJTAkFmMFOavZLCxFJ6UhSgzrFjsJERa0khcO57MbQkcOpsmycI8cjbUB7IuLpxHZOUTC3K82Q3uOGpaTELYxfMrWVvBVi9yJ7kw7+WKn8QNs9HYzc7lLvjZAhlEucfYeg=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 11:34:22 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::117e:4c4:7939:30ec]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::117e:4c4:7939:30ec%3]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 11:34:21 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Haehnle, Nicolai" <Nicolai.Haehnle@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH umr 02/17] Use the correct prefix for Navi3 in halt_waves
Thread-Topic: [PATCH umr 02/17] Use the correct prefix for Navi3 in halt_waves
Thread-Index: AQHZmFfECbnPAsHO7ES74GjUr42E+a99pM7E
Date: Tue, 6 Jun 2023 11:34:21 +0000
Message-ID: <DM6PR12MB3547B7F9185933940A358A92F752A@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20230606091725.20080-1-nicolai.haehnle@amd.com>
 <20230606091725.20080-3-nicolai.haehnle@amd.com>
In-Reply-To: <20230606091725.20080-3-nicolai.haehnle@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-06T11:34:19.303Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3547:EE_|CO6PR12MB5411:EE_
x-ms-office365-filtering-correlation-id: d7118203-aabc-4f69-e26e-08db6681f8e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: beHsUVY+EqUao5AtcStXprzlhiw4KM7WOZjOz3YU5R1wkxGe9FE+1DgEySNaASUa8sn0k7iXcdbeFOjZfuSkPfDsFoyQXddJ/vQR00MvMS3NvCli3AxLBPttgdPnNUtdg9Y7PJrXD/44E6dAw5uaDLk40NQ9isHJWgdgyRhrssalUnC012x2OG/JXOxdMTO02NnNdPBH7b4IyLf8F+Jb1thEcXf/XGlQsxV+R4DLgnjjrUpQoABBHVfeVeeLAHYMpJZompm17KM/hFlKOmfiUx4i+x9DTwdfaWcRNC+KJLDaDkyn+2DD3vysz/kpZpJBl2UVQjDzDZJmABYWdHf2Gx1yV2Te3KYoBieXki2cuvArpCFB738ZNzukZoV2zOxKH0fryuLefQvFYFgkjvTN2IcnNnQyx+B8bPBAxe4pap3iyqHqhpDKwdjiuOdBJn2mj8CM3Ej6PFY1unoBHR0m8jye/uEQuYvK8eVAmgrinu3VE4i0yEuW+Ni4RiqZJSeyZOsJ6PqIUEUmsV5HEyj9OsU9TLmvkheroCH5huhXGzClrfS9qDd+2KWby9BADcgtNRRvKjVmjNmfLGjvDo+ggKGv0cTiVoztkHgzyVZfiuc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199021)(110136005)(2906002)(38070700005)(71200400001)(478600001)(33656002)(52536014)(8936002)(38100700002)(41300700001)(86362001)(8676002)(5660300002)(55016003)(316002)(122000001)(64756008)(76116006)(66556008)(66946007)(66476007)(91956017)(83380400001)(66574015)(66446008)(6506007)(9686003)(53546011)(186003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0YYyOp2N0whJ50ESXwtgdCDcDPQzXo/q9IQbrvlsHhDmY7wg2z9c1EgGkL?=
 =?iso-8859-1?Q?aL2GbTpj4IdmU1FVygBA0lc53cXFg3ndsenjHoVH/gL/bRRRw+FHxK+6Y1?=
 =?iso-8859-1?Q?3JXLObvUif9MuyoikXJtwBNPUkZUlN3uu/ple5SJBk8WAGp7w0M1eiggU3?=
 =?iso-8859-1?Q?aAZKlOSiquz7DD6X8NoROZi1rjUlXHML079FN/8pA2b3l654dx0yGA1gvG?=
 =?iso-8859-1?Q?6VW8cPGK+PSWUY9Z3IM4WyGmeTFBlJd9nGgDsqWsGlzkhy8OS1ilad1P2O?=
 =?iso-8859-1?Q?IHWw4FJ2dX7j3OZgbbvQ45zgwUNPHr6my/dN6e4emW6NhGOhYMCctBwQle?=
 =?iso-8859-1?Q?DNp6ghV8rXJaDlFYiet8RHJWGzCAVgn35Vn7VQ4ye772F0fPiSJzYEdpAy?=
 =?iso-8859-1?Q?8qYLO5sq78uMXu+H41kjPvUAgSohepP7h1UzH3EKYYCqCky2siGsJdQm4a?=
 =?iso-8859-1?Q?GTNMLGlnIpoJq6rbHpfvscJ9kCOdnXWOEuHyklZD6Dpx/9aSj3qC5H9EhR?=
 =?iso-8859-1?Q?BmtSQb5jmJClb+qVKajHH/RLlETl1Gvf4XvxQUH9yRuVdkC/Y3pQEDJRrT?=
 =?iso-8859-1?Q?HoGGCQBZBg910Z9cZGRqd7YVHwMUb5a7zvLzNBnHF6aB8YzjXSyQ/dQWLw?=
 =?iso-8859-1?Q?pt41a/dNm1J7gEs7S/p1R2vXXMbg5Y14xUMU5QmSuo7vcFkxdQi9WDLqz5?=
 =?iso-8859-1?Q?nej18dQxctT+7ZNcQVOx7HZxqBilyEVRjH6xChL40PscIl93/4tIAjkbhe?=
 =?iso-8859-1?Q?d4qfejL6NDmBB1nYEI540QGEYC6NQ65Ni4HFS5WaXR3ZjKOdWRDzixxO+U?=
 =?iso-8859-1?Q?S7UDOpEyRD7k16KX0vUHGiWwoaq6r7/7uIGd2HsFV0Q/Li8wqw6xK4oJPo?=
 =?iso-8859-1?Q?4S5XEakqeGQjqgAewVykcnOtMsZ261TNalAG7LzIbfiBpK/LcDNe+zKOi/?=
 =?iso-8859-1?Q?0mGJEUoB0WZy6EWVbJfqHpmBidwnE+HfgPk+EOQwkF2qa0kfUmyNEYaHp0?=
 =?iso-8859-1?Q?vNNA6Y7ncLE1wLoPJKX3kFGOJhcN99E8PmFOI+CMtk9Mnpu+KHX4MrEAMb?=
 =?iso-8859-1?Q?dVHjfOa6DMlIXaY6uKk+U7BdYGjSAPUjdaqy5HdQOwVce3W4O0o754WwKE?=
 =?iso-8859-1?Q?dQcsKEMycaLKcyov4xJG9UTI1qh+Y+u48T5pQCWcY2z1DIhYDN9cknqhvo?=
 =?iso-8859-1?Q?/X/5t2wPUkNZkHVtNAaTj5rGxtZueoqOUew0Pgy5NRmFlJxY6hPav4wCkI?=
 =?iso-8859-1?Q?+3VCDf2w6Y9ibcPMs7FMdb4YvIkYdnOxx4hUERLCic8GvIag9/iQFh6MF3?=
 =?iso-8859-1?Q?AXA9IULxvjSu1FBFwW0g6J83RQeG6gPobBkD7WRDAVPi8ANQQNwX6cF8zA?=
 =?iso-8859-1?Q?tjWA7e3955GxYcilf81UCX53XQ/gEFjqSkeTJ/mYB0UvqkzBB+Fg8UnMjy?=
 =?iso-8859-1?Q?vHePn92uHsrukavU5BjhfH+T14XABnM6ZNWDES97pDq3brh+0SbMj3G/7R?=
 =?iso-8859-1?Q?elONldeHLiXkzlT+b/TRqDpQJWtax75UVGS4bHJ47c06MWg+gHdVewFEaP?=
 =?iso-8859-1?Q?MRZNmefswr7dGpK7uIgzNG4zZ4suvq+qMUTVTEgQBykfTcWHZuIzC6zN4U?=
 =?iso-8859-1?Q?q6Zgjb8AnJkNO/4jNXH/4P6vA/YMMCoQLurqKwCpKaY0ErMKmB66R1qRuf?=
 =?iso-8859-1?Q?yYBBfvSP1kE4y8LlVtg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7118203-aabc-4f69-e26e-08db6681f8e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 11:34:21.5094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qolnKKNzPmQQHFQr75Sdzyj+G/srtd5U/AMWvmb/zbHgcE2Oj57CWLZF0WFsR/kADPhPmP1ayQEE2tvMJ86+ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5411
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

[Public]

This shouldn't be necessary as it tries both mm and then reg...


________________________________________
From: Haehnle, Nicolai <Nicolai.Haehnle@amd.com>
Sent: Tuesday, June 6, 2023 05:17
To: amd-gfx@lists.freedesktop.org; StDenis, Tom
Cc: Haehnle, Nicolai
Subject: [PATCH umr 02/17] Use the correct prefix for Navi3 in halt_waves

Signed-off-by: Nicolai H=E4hnle <nicolai.haehnle@amd.com>
---
 src/lib/sq_cmd_halt_waves.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/lib/sq_cmd_halt_waves.c b/src/lib/sq_cmd_halt_waves.c
index 368e701..841b1d3 100644
--- a/src/lib/sq_cmd_halt_waves.c
+++ b/src/lib/sq_cmd_halt_waves.c
@@ -36,21 +36,22 @@ int umr_sq_cmd_halt_waves(struct umr_asic *asic, enum u=
mr_sq_cmd_halt_resume mod
        uint32_t value;
        uint64_t addr;
        struct {
                uint32_t se, sh, instance, use_grbm;
        } grbm;

        // SQ_CMD is not present on SI
        if (asic->family =3D=3D FAMILY_SI)
                return 0;

-       reg =3D umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->opti=
ons.vm_partition, "mmSQ_CMD");
+       reg =3D umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->opti=
ons.vm_partition,
+                                                 asic->family >=3D FAMILY_=
GFX11 ? "regSQ_CMD" : "mmSQ_CMD");
        if (!reg) {
                asic->err_msg("[BUG]: Cannot find SQ_CMD register in umr_sq=
_cmd_halt_waves()\n");
                return -1;
        }

        // compose value
        if (asic->family =3D=3D FAMILY_CIK) {
                value =3D umr_bitslice_compose_value(asic, reg, "CMD", mode=
 =3D=3D UMR_SQ_CMD_HALT ? 1 : 2); // SETHALT
        } else {
                value =3D umr_bitslice_compose_value(asic, reg, "CMD", 1); =
// SETHALT
--
2.40.0

