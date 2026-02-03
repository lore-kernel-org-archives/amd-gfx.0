Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30BAE8B361
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 20:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FF5210E07A;
	Tue,  3 Feb 2026 20:59:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y5eYHorM";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013062.outbound.protection.outlook.com
 [40.107.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 790CB10E07A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 20:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4DIV3pB4mVk9kExs20gsTv4DnmCYMcVNi9zbrIjdJ4bHbb8+n6yQeoWNTuBEELnhFymHsK6XJXCAAcVn4rnjE9ahYiDjrJ1BDTWKG8zjIBshumAQUyTJwjtN/NBgDv32X33LT+EHc0HLc1e8DPHN5OlpVURHDP7yj7odB0CZt6Nl2iXCH2VpDx1WP61Kwe0+0ZkTF3Kdp9K8+wALCF/Ed23dD1UGEDtHu8dnrFiZUo04xh4b8yCmOrrJFZ9MrSSmMXB+pqcSxgF27LUGSUEnwFQsr4uHuL7PhtulhKwG0fqOYe9z9fZbCdPvCWrmVxbVkctHAEAAGSo9CAx66hFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HLkS76Qru/3i04Ivfx2kOncnZdZ2ATu+YKNGWy2FZU=;
 b=m63OXgSNAkaEmlhvcUlsurK7eQBybD0rQWUNAbmghwj3iFxQrJ4O+GUtwkzDIOZO/+hUuKvYw2JcYDKo2yPqKmzK9BPm2xNXrxW2ARfkVUxAhsLHkm8AM0LFPDDWfuHNctY7MkOKxUY+nsL5B7k6qF4q3FiPbrquc+c6mh5dAKY83n+8E3dmy0zh7QLwRvygJE3W01udmrifraSRtE02CxgMlRelzF1+QLZ4MYlhXhIS+UDhTemfF11Zw//V1KINym/05ZOUHIdTi80Ww4x80MGzsHUzXC+viyfvhyxYkHuPtb5BYQAte5SuCP/f3ELlBtbcoYJjeVdVS8kkp2kxCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HLkS76Qru/3i04Ivfx2kOncnZdZ2ATu+YKNGWy2FZU=;
 b=y5eYHorMpn3Qf4FqA/XLEXiZK/NQh99ZgN4VK87+4ozsRxUlZ1FWbkXSRhP7UnqLHIfS7JsxkzPmOXwkpDb6u7noZ2GSgxi8IY2v+rEvVBajt4sN55VnmUaUwA/ZJAZa7DCB7Bad/2Wyu8HjOOpnrylyezjEibDUPvfYk+TCZrc=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 20:59:28 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 20:59:28 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Send an in-band CPER if threshold is
 exceeded on init
Thread-Topic: [PATCH 2/2] drm/amdgpu: Send an in-band CPER if threshold is
 exceeded on init
Thread-Index: AQHckizmNilNK2YMjkGwihJckoJT87Vu9MAAgABkJoCAAiKEoA==
Date: Tue, 3 Feb 2026 20:59:28 +0000
Message-ID: <BL1PR12MB589884B642E454690449D5E0859BA@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260130211031.446011-1-kent.russell@amd.com>
 <20260130211031.446011-2-kent.russell@amd.com>
 <PH7PR12MB87966F7BDEC2610399874C2EB09AA@PH7PR12MB8796.namprd12.prod.outlook.com>
 <CY5PR12MB6345916931ED235714DD34C2FA9AA@CY5PR12MB6345.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB6345916931ED235714DD34C2FA9AA@CY5PR12MB6345.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-02-03T20:59:20.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|MN2PR12MB4336:EE_
x-ms-office365-filtering-correlation-id: aff2cb10-061b-4a19-64b3-08de63671ed0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?l08RAunGOdPEJhHfRTR2dDNS79qWImc11m2ylWvvo5t1B3vdzFPAHfJuMwgk?=
 =?us-ascii?Q?oiqj8LsBE4Y5aoHNSN63VMN2lpDXe7XPG1KqDNIxOVWBmuKu2qKdbab2zy8o?=
 =?us-ascii?Q?pen5Gq4jjyYHgRZvKlYIhK7AhLkT6rIJ/XvT3Mpia5zMl/1SrRMKzZfjhtd8?=
 =?us-ascii?Q?R9XiBKNiZr8FshA6V2ZZ0BIiKRTYWqF/1JktGUyjUAzun0sq4p9/oU5uc6eD?=
 =?us-ascii?Q?4bOzbErlwmBDU+ZGfNoVviR9ztZ1tbbZYvkPDjt00ZDtXIj+t3UIzM/KAMV7?=
 =?us-ascii?Q?2UpjvUW65Mwgbne73TkUHkKfT9Y7YYJoIeJdhlkzeMIZ35WpBuuZ0bWXtSTf?=
 =?us-ascii?Q?wB/rGtQpVj0Y4GI9KCWE5tnCROBXxgq8v+LufJCmhk7GJaSAouxRpTzp0eFv?=
 =?us-ascii?Q?O37O91DIABvSXLQQgoolECtXGGdptZGLNMgtmi7W70bBbTGAk5KmXCeX8lBX?=
 =?us-ascii?Q?2TphshVxQD9EWBHlodnWjSaF3KQcUkPE3LlWfE8di3qrl9rfbfNPypEkrZcO?=
 =?us-ascii?Q?d68s3ooOYzfIfbns81V7aqkF3bFnYwYkoEPPaKKSfItp1VmOV3vyR6+mT942?=
 =?us-ascii?Q?AKbt2WlR4g1x9H4FvWyvxe9ZPQhPbkDGwBI2ggy1Id668bKHV9rQcdEVbIeu?=
 =?us-ascii?Q?yUUjIOGtk0KeJqi+xeAGn3O46h22PprM3LNnz/PanfSslsnVmE5pIKYBWfXt?=
 =?us-ascii?Q?lfkVXG5kmIdC+Epe3InJ7nooX+Ans0hDu3TA6Sf2WbEQTj8idEO+ohg/utyO?=
 =?us-ascii?Q?LLxYG9zpN0AL46mufCiPEeXXMiO5qjAFEmXOBwlIXjks5FHvnB8NiA7XHqqo?=
 =?us-ascii?Q?sDECdLpGV2Fsr2hmOaKiD7xcWUIy+sxkjzMZ2YVvnL5LL/5pKSP6945j0GL9?=
 =?us-ascii?Q?TcanM8c2UOH7KadKW1gKudt4hMlbtHJ90YSbwTT8wam+lh+o0evpzcI0XdaE?=
 =?us-ascii?Q?ls4/pNEkiCM2MNAUe84vi08KmLPNHamdp1PeWLo3uuhHGdXtn0APjn7UFLAV?=
 =?us-ascii?Q?5ElKYXLx581prd1OAcVDGHGeXZZVmjDNpFhpNVe5+uCvJ+5eZ1IxKi//ir4W?=
 =?us-ascii?Q?st1ih8tABos9lb24lk8DqsYyWcyOP6TzJ7WP08Svh6QQ35ADJm7KbVc9e7fW?=
 =?us-ascii?Q?iUNXL+5OzN4kPwfkARA0nhtX6QP+SDjDmzTJ2PrMwaYNC8EDHdV1q49fnnkg?=
 =?us-ascii?Q?qJGWhCRZ8TTlJ15Xbapdo4DZVec/b8nMHfmikRgb1XPPi0xiPR31WXXuE7gV?=
 =?us-ascii?Q?LgzXWxOPVxlb3VJOHI/cU5b8QYwKfXbEAze79rTtOVdMFYr0AjIh5Il1plVW?=
 =?us-ascii?Q?7hVmG/EAlaF83lYVKRIvZ0BzP4TtqIGQlWMZXkbwhYuWPr8Djm9fd6IIA7A/?=
 =?us-ascii?Q?cf61WllLhSAUoJMa908HImlGl/7d3jUw2GWFw0D3Ch2anfHctgLOJdG3Ij2c?=
 =?us-ascii?Q?Uq1TJSvjtW3gPh4tTc+gDDwMR3MbLpyl+rrFacQxJx6kdPSdHfI+wdAkXHT7?=
 =?us-ascii?Q?FR4UkiZeVbq0txOL61Ig3QuqPN8zzBSwiJJwXVK7N5dIZS6xDXnCauUvOzh3?=
 =?us-ascii?Q?5sJkJ+LjfGVf7Di36HukiA9mIoGv3cdL9KPxMCfWnqxtHXBWD50lZgLF/2iO?=
 =?us-ascii?Q?9HmSxUNa1ujOkw6+7yK520w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KRoOWATConRW7FU82Ym1AoG1Xn+9cGFcT9Md5jW236tsvL1iYtb9iUvvBX3F?=
 =?us-ascii?Q?t49D3Z4KrNSiFPquSulzFGmy6tWFFZcdyqeMt86txrAMokoO6UXg89lABxIp?=
 =?us-ascii?Q?f1z6c9txU63e/EAL+zX+xppBpAwAY0uZhbD0+MLUZ5jq59b4iM4XmF3Q7toL?=
 =?us-ascii?Q?nS5Qmemod1DyfMbK83ibLbGi19o0T1aNc1zBgW+Lb/+YHolts9PcAmaR0qTh?=
 =?us-ascii?Q?rhcwFxBNetxoEk56ewKizkmHs9AZ0odebmzdhtLoW8hqKhwOnw4jsjQJDBaO?=
 =?us-ascii?Q?GCNkSKVkCtoyH8k6AaJiYMQp9tvLdRCYgAf0GfpffMQfziUS/cPWph9Fbavs?=
 =?us-ascii?Q?DNQK3lffPck/Bbc/+quCLVO1FGa6IzlYBe3w6gZDwqnnW87LtoLIOi8WCR9r?=
 =?us-ascii?Q?v5Hl/n5rtM1NUShs3duIoJFIASrQ37kYcLRxqV0o5D2BXQ2J8HHu5CF9g9A3?=
 =?us-ascii?Q?qmYoPgFiJ9iX7DzLFyPQrs7SjaOAuAFK+TdkZhUZRAfjb4/s0P0Wy6t3BK36?=
 =?us-ascii?Q?/YOSmYTtphFkjdqHvFwGs8g6WSQJMdzKxiB00BRB5vVSYz+dTsw6GyG7F04+?=
 =?us-ascii?Q?oD/LqGrMQOOpSnwghdhlDeDaOkRwq7i0DNPDlUStz4vHyFf9pJIyUWeMrDPy?=
 =?us-ascii?Q?g0L46YqrnMxeuM7AZfV4Neo15GhAEwDKdCSvtImD4bsBoiFf+ZhPNgfX5gOZ?=
 =?us-ascii?Q?9e3abqkAcV8iOneplrPJNusB3qYeNalhlb4tK3C3lRBNKQh56HC4SMGw6Vsn?=
 =?us-ascii?Q?4wYsvlaJDkTo6pmeFISDZxahmBli7ueLAq9RAR3KHGvGPrZ7oTLKyTlLSt4v?=
 =?us-ascii?Q?fNrxMTlQ9vSmU/dT4tinA7TFpftZK7nEC/YlyFGO8EUfBvY3yERpbRQxJsnB?=
 =?us-ascii?Q?7/b684qOGj1JlLcHBdTo48rqpXwxcQi3fvxzftsWUfJ80wIJqBZJMB+WxCK3?=
 =?us-ascii?Q?MzPC79ykBWeaDjt7+zmUw8PO/uhyA0/H64xAoSwErWyGM3k84JAFABSvIkDb?=
 =?us-ascii?Q?FqytDQQ8RF7NfM4xDa4kPLhSOGXU8TGpNFly1s/Su+Nae1BgGLevsv6dpUEy?=
 =?us-ascii?Q?G42pPOqibSw2JZ/laZ/ou4h3TTDenVTDPHJ8LPv8dXCLVLC1jLtT4Y/HekrB?=
 =?us-ascii?Q?qGL/k2qrRYAr4FDLaGCxvNDWVEoeiUqoOB5tTW4OUyJnBKi51EmOdQPm+klQ?=
 =?us-ascii?Q?PZNPVE65gwpf5d31m0W582C40arOHvY3DEtUIhiqlP6u26d9SFs8xjvo+Zsy?=
 =?us-ascii?Q?FCNZiyKRqwM7HgNCoTcqf9nkzTjKDxhvMRcXsH2WiCfN6RQ6t670TYmk+Spl?=
 =?us-ascii?Q?v9x93T8w24C3wFet8tKiPnNz17D8W9n3GsOCXhrU1QHwtguaDSWWCAxWSwid?=
 =?us-ascii?Q?67MxpqJlaquQl7ySEAa2kXQvWmfvwlVzYEyJlORrH5AMa5U4pSQWq+LJW7qJ?=
 =?us-ascii?Q?dKe3eKaOJ/NMq4LX0yxXA0R9bKJWK6k8xQh2Cax48E6BumiXlhU4m0KvCbzh?=
 =?us-ascii?Q?hj25AO66jy3lsXchlQF9MA0/N3DYk9NKY9CA5hsRbek6nVWg/C6J1ttqHlPG?=
 =?us-ascii?Q?P/81VLA2c6zyorh0Vag/qTeXofPqIoUmrMTnfZlyQw2zFytutyJKCy78PZxi?=
 =?us-ascii?Q?WC0uA8T85hE4phmToHPP2z7cV1t458xireggqNVHVNB3qYED7BZc+JqWeTtG?=
 =?us-ascii?Q?q8WDnDmRBSNsD2ApxCan5ZFxuk32F/kxbhpV9myb33h+WtCB?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB589884B642E454690449D5E0859BABL1PR12MB5898namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff2cb10-061b-4a19-64b3-08de63671ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 20:59:28.1883 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CoRrdXdqXFeK1y7m6Q1o48tznyyp25OV6EpxqKgyibLTAlzZa9okpmuKd6hY6y4ztIEGQdsXVri4zAKYIvRMfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
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

--_000_BL1PR12MB589884B642E454690449D5E0859BABL1PR12MB5898namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Holding off on this set. Working on the OOB side due to some complications =
with timing. I'll send a new set once we get that figured out. Thanks for t=
he review!

Kent

From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Monday, February 2, 2026 7:23 AM
To: Zhou1, Tao <Tao.Zhou1@amd.com>; Russell, Kent <Kent.Russell@amd.com>; a=
md-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Send an in-band CPER if threshold is e=
xceeded on init

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Tao,

This patch series looks good to me.

Best Regards,
Liu, Xiang

________________________________
From: Zhou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>
Sent: Monday, February 2, 2026 2:24 PM
To: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>; amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Liu, Xiang(Dean=
) <Xiang.Liu@amd.com<mailto:Xiang.Liu@amd.com>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Subject: RE: [PATCH 2/2] drm/amdgpu: Send an in-band CPER if threshold is e=
xceeded on init

[AMD Official Use Only - AMD Internal Distribution Only]

The series is: Reviewed-by: Tao Zhou <tao.zhou1@amd.com<mailto:tao.zhou1@am=
d.com>>

Hi Dean,

Could you take a look into the patches as well? Thanks.

Tao

> -----Original Message-----
> From: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>
> Sent: Saturday, January 31, 2026 5:11 AM
> To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>;=
 Zhou1, Tao
> <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Russell, Kent <Kent.Russel=
l@amd.com<mailto:Kent.Russell@amd.com>>
> Subject: [PATCH 2/2] drm/amdgpu: Send an in-band CPER if threshold is exc=
eeded
> on init
>
> When we load the bad pages, send an in-band CPER if we have met or exceed=
ed
> the bad page threshold. This aligns with a previous patch where we sent a=
n out-of-
> band CPER for the same case
>
> Signed-off-by: Kent Russell <kent.russell@amd.com<mailto:kent.russell@amd=
.com>>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 469d04a39d7d..dd7d837b52bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1715,6 +1715,9 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>               if (amdgpu_bad_page_threshold !=3D 0 &&
>                       control->ras_num_bad_pages >=3D ras-
> >bad_page_cnt_threshold)
>                       amdgpu_dpm_send_rma_reason(adev);
> +             if (adev->cper.enabled && !amdgpu_uniras_enabled(adev) &&
> +                 amdgpu_cper_generate_bp_threshold_record(adev))
> +                     dev_warn(adev->dev, "Failed to send in-band CPER fo=
r
> exceeding bad
> +page threshold");
>
>       } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
>                  amdgpu_bad_page_threshold !=3D 0) {
> --
> 2.43.0

--_000_BL1PR12MB589884B642E454690449D5E0859BABL1PR12MB5898namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Arial"><span style=3D"font-=
size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Holding off on this s=
et. Working on the OOB side due to some complications with timing. I&#8217;=
ll send a new set once we get that figured out. Thanks for
 the review!<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Arial"><span style=3D"font-=
size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></sp=
an></font></p>
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Arial"><span style=3D"font-=
size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Kent<o:p></o:p></span=
></font></p>
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Arial"><span style=3D"font-=
size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></sp=
an></font></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><font size=3D"2" face=3D"Calibri"><span style=3D"=
font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;font-weight:bol=
d">From:</span></font></b><font size=3D"2" face=3D"Calibri"><span style=3D"=
font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> Liu,
 Xiang(Dean) &lt;Xiang.Liu@amd.com&gt; <br>
<b><span style=3D"font-weight:bold">Sent:</span></b> Monday, February 2, 20=
26 7:23 AM<br>
<b><span style=3D"font-weight:bold">To:</span></b> Zhou1, Tao &lt;Tao.Zhou1=
@amd.com&gt;; Russell, Kent &lt;Kent.Russell@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org<br>
<b><span style=3D"font-weight:bold">Cc:</span></b> Zhang, Hawking &lt;Hawki=
ng.Zhang@amd.com&gt;<br>
<b><span style=3D"font-weight:bold">Subject:</span></b> Re: [PATCH 2/2] drm=
/amdgpu: Send an in-band CPER if threshold is exceeded on init<o:p></o:p></=
span></font></p>
</div>
</div>
<p class=3D"MsoNormal"><font size=3D"3" face=3D"Aptos"><span style=3D"font-=
size:12.0pt"><o:p>&nbsp;</o:p></span></font></p>
<div>
<div style=3D"margin-left:5.0pt">
<p class=3D"MsoNormal"><font size=3D"2" color=3D"#00a7ff" face=3D"Calibri">=
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
color:blue">[AMD Official Use Only - AMD Internal Distribution Only]<o:p></=
o:p></span></font></p>
</div>
<p class=3D"MsoNormal"><font size=3D"3" face=3D"Aptos"><span style=3D"font-=
size:12.0pt"><o:p>&nbsp;</o:p></span></font></p>
</div>
<div>
<p class=3D"MsoNormal"><font size=3D"2" color=3D"#f6f6f6" face=3D"Calibri">=
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
color:black">Hi Tao,<o:p></o:p></span></font></p>
</div>
<div>
<p class=3D"MsoNormal"><font size=3D"2" color=3D"#f6f6f6" face=3D"Calibri">=
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
color:black"><o:p>&nbsp;</o:p></span></font></p>
</div>
<div>
<p class=3D"MsoNormal"><font size=3D"2" color=3D"#f6f6f6" face=3D"Calibri">=
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
color:black">This patch series looks good to me.<o:p></o:p></span></font></=
p>
</div>
<div>
<p class=3D"MsoNormal"><font size=3D"2" color=3D"#f6f6f6" face=3D"Calibri">=
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
color:black"><o:p>&nbsp;</o:p></span></font></p>
</div>
<div>
<p class=3D"MsoNormal"><font size=3D"2" color=3D"#f6f6f6" face=3D"Calibri">=
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
color:black">Best Regards,<o:p></o:p></span></font></p>
</div>
<div>
<p class=3D"MsoNormal"><font size=3D"2" color=3D"#f6f6f6" face=3D"Calibri">=
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
color:black">Liu, Xiang<o:p></o:p></span></font></p>
</div>
<div>
<p class=3D"MsoNormal"><font size=3D"2" color=3D"#f6f6f6" face=3D"Calibri">=
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
color:black"><o:p>&nbsp;</o:p></span></font></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><font=
 size=3D"3" face=3D"Aptos"><span style=3D"font-size:12.0pt">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></font></div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><font size=3D"2" color=3D"#f6f6f6" face=3D"Calibr=
i"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-ser=
if;color:black;font-weight:bold">From:</span></font></b><font size=3D"2" co=
lor=3D"#f6f6f6" face=3D"Calibri"><span style=3D"font-size:11.0pt;font-famil=
y:&quot;Calibri&quot;,sans-serif;color:black">
 Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@amd.com</a>&=
gt;<br>
<b><span style=3D"font-weight:bold">Sent:</span></b> Monday, February 2, 20=
26 2:24 PM<br>
<b><span style=3D"font-weight:bold">To:</span></b> Russell, Kent &lt;<a hre=
f=3D"mailto:Kent.Russell@amd.com">Kent.Russell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;; Liu, Xiang(Dean) &lt;<a href=3D"mailto:Xiang.Liu@a=
md.com">Xiang.Liu@amd.com</a>&gt;<br>
<b><span style=3D"font-weight:bold">Cc:</span></b> Zhang, Hawking &lt;<a hr=
ef=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;<br>
<b><span style=3D"font-weight:bold">Subject:</span></b> RE: [PATCH 2/2] drm=
/amdgpu: Send an in-band CPER if threshold is exceeded on init</span></font=
>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><font size=3D"3" face=3D"Aptos"><span style=3D"font-=
size:12.0pt">&nbsp;<o:p></o:p></span></font></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"BM_BEGIN">=
</a><font size=3D"2" face=3D"Times New Roman"><span style=3D"font-size:11.0=
pt;font-family:&quot;Times New Roman&quot;,serif">[AMD Official Use Only - =
AMD Internal Distribution Only]<br>
<br>
The series is: Reviewed-by: Tao Zhou &lt;<a href=3D"mailto:tao.zhou1@amd.co=
m">tao.zhou1@amd.com</a>&gt;<br>
<br>
Hi Dean,<br>
<br>
Could you take a look into the patches as well? Thanks.<br>
<br>
Tao<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.R=
ussell@amd.com</a>&gt;<br>
&gt; Sent: Saturday, January 31, 2026 5:11 AM<br>
&gt; To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.fre=
edesktop.org</a><br>
&gt; Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawkin=
g.Zhang@amd.com</a>&gt;; Zhou1, Tao<br>
&gt; &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@amd.com</a>&gt;; Ru=
ssell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Russell@amd.co=
m</a>&gt;<br>
&gt; Subject: [PATCH 2/2] drm/amdgpu: Send an in-band CPER if threshold is =
exceeded<br>
&gt; on init<br>
&gt;<br>
&gt; When we load the bad pages, send an in-band CPER if we have met or exc=
eeded<br>
&gt; the bad page threshold. This aligns with a previous patch where we sen=
t an out-of-<br>
&gt; band CPER for the same case<br>
&gt;<br>
&gt; Signed-off-by: Kent Russell &lt;<a href=3D"mailto:kent.russell@amd.com=
">kent.russell@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 3 +++<br>
&gt;&nbsp; 1 file changed, 3 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
&gt; index 469d04a39d7d..dd7d837b52bf 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
&gt; @@ -1715,6 +1715,9 @@ int amdgpu_ras_eeprom_check(struct<br>
&gt; amdgpu_ras_eeprom_control *control)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (amdgpu_bad_page_threshold !=3D 0 &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;r=
as_num_bad_pages &gt;=3D ras-<br>
&gt; &gt;bad_page_cnt_threshold)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_se=
nd_rma_reason(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;cper.enabled &amp;&amp; !amdgpu_uniras_enabled(adev) &amp;=
&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_cper_generate_bp_threshold_record(adev))=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, =
&quot;Failed to send in-band CPER for<br>
&gt; exceeding bad<br>
&gt; +page threshold&quot;);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (hdr-&gt;header =3D=3D R=
AS_TABLE_HDR_BAD &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bad_page_threshold !=3D 0) {<br>
&gt; --<br>
&gt; 2.43.0</span></font><font face=3D"Times New Roman"><span style=3D"font=
-family:&quot;Times New Roman&quot;,serif"><o:p></o:p></span></font></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB589884B642E454690449D5E0859BABL1PR12MB5898namp_--
