Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DCFEB64DB
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 15:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0698510E514;
	Thu, 15 Jun 2023 15:31:27 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8518310E514
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 15:31:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PF/4LuD51i9XF9qABbX3YqGU06r0DKRXxLxSIoQe647RsWdCu9pj436HxKSX7U4VNhHYclLXGSTDbWznwY4slxBVl/ps9MzyZWn0kJiURVY+r/vWxaTw5WF3ySbCvTbEljboDzRUHG+zqRD18gTDwar9WH/1KLUei/ko/sntbAPxbw+Kbwedm7OqZLCBr0Q9tJFIF5zkJahK4SSTWairiR7tXstFE+Is2y9TmfW6l5ZJ5FhmI+OhjI6T0ov1UoBczRCWBxULM9IcxUTzb0OcOJjgjIW57+pzIeaf+LRsKN0+2xSheyAaOnBjjSYIzVBMWIuNc4Wz34mBZP8ijsfaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqgcoLPUWAMvsQocE1xVFBbsgqZ/c9YPEgn6mf1ZEps=;
 b=Qbe628Cj+Acz3NddvLxfDR8lpOytHPiBc55RwAu8BZ5FpbQWwyMAFrYyh+qFJuplfwgzAJtlesipEjd/gnpxGld+5wEd4hh4Wlhu8xmAJfJYEpCLy4wTvZG4LVuNQB1Uw8gLPCV1D9uV4HHI+aZ82Ps6sdTZYWVDBUcUcbRs69qtprMukD7nVrF/Plqt4Uu+YfSRTGpbGdAecyf+LigPL4UlPsZ70id+vYYgog6Ua8Fm1wjo23ByiOr+qo0SgrAP9PHqBKPgUKx+M1y1G8OYKt2cZonCiudG7sn4UZtba0iO3uVuATKz6Tl5KwpRlRH52qDRJcJ9g2OMY4Y8OjB2fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqgcoLPUWAMvsQocE1xVFBbsgqZ/c9YPEgn6mf1ZEps=;
 b=34+e5sargpmvw9T8Ray+rjFt6XbPnFgZ6d9sXv9xWuU9mf8ZoNU0MqcpEKlf2LAtDDCpHBQXoscJtg3t0h3+uRTY9AXQclrFr9t8hlON8bQJVscls41ULeCcvbE7y/rORiXFtMFJ0aqBSeEr5eLGjgcPPU1SE6oI88bWJ4LSHvo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 15:31:21 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27%5]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 15:31:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: mark GC 9.4.3 experimental for now
Thread-Topic: [PATCH] drm/amdgpu: mark GC 9.4.3 experimental for now
Thread-Index: AQHZn5IpBKoCK/OqVkaNczkAa4Osv6+L/aNw
Date: Thu, 15 Jun 2023 15:31:21 +0000
Message-ID: <BN9PR12MB5257E968BF1E2648AC1BC38EFC5BA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230615140257.607185-1-alexander.deucher@amd.com>
In-Reply-To: <20230615140257.607185-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=79df90ca-68cf-47c9-8419-f99f97ca7154;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-15T15:31:01Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW5PR12MB5621:EE_
x-ms-office365-filtering-correlation-id: 3956d864-8d92-4913-ba61-08db6db59220
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kATHAZlZgXl5gb2FkRtBh4lB34e6PRjMw3Q6cjo3lka+4cRfkqDKdyO5uXxQkFXtWOdvDuLlGvMEGxF+gXJqnWDhpEHKYjrEy1YtAJ4VreT1PxPncCEb1lS/qcj9nwHQ7EqZhR3xkMv4vj5IH1guO8AaE9BVPPJEQ4lXBPSJBLbnBGgsPIHm5EGCO4hmAlAUZPSBlHw4fS/CG4+BJiKIh8Q5PA96w9PWjI4pcmenYFRatjO9WNQQbXKl9cm+Lyn0Rg1rTWTMU04tPGvVonKkYZOqlBTWqcsD0DBM/0ThkjpJ904ePv+MOqyeDVYQL3Ju65DlXXrF6FbPBWDlyq2e4ndHbvYLuPf8DIRHMlzxefemLZNxDXPKaxXTGZ2W3stHNJe6qxct9bT8/BRXa2+2vL4gGia1IYi8vuuRIP67jmJakAbaHtGbLWHgN/Kj9/n8W0aJ3/6Wml9YknV4LrhSUqvup5Q/YE/Aek3c/BYDhvbmv8f2R3RhcZbUevUvLTI4CkfFGx5PHpmJXEFLL3/I+BxkKQkV5fxHJhR2eYWHWN2UKpP5JclKk4ccuwQcGbcl+7awCxq0VeH7d4JMLkQng+Oj0g4yPERwOlpxjH+eGdo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199021)(7696005)(9686003)(83380400001)(86362001)(38100700002)(38070700005)(122000001)(33656002)(26005)(6506007)(53546011)(55016003)(66556008)(66446008)(2906002)(110136005)(66946007)(5660300002)(186003)(316002)(52536014)(41300700001)(8936002)(8676002)(4326008)(76116006)(66476007)(71200400001)(478600001)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cDHTNHh8xvZUt2O//8+3nRyQdH362+PbIc5s15EvhXgeXzV0x5myUP06tNnf?=
 =?us-ascii?Q?uLRUUWYvmMigRcvtfmySDbkk53iXaP7h3IYxuAz5JXJem3Q3cVpL2dv83ryj?=
 =?us-ascii?Q?bFnNduislAP8J8TIXGB4EhJdruycR6lLPLVLkIobamWs45kB9lUBfom+swfO?=
 =?us-ascii?Q?5pGtTaS1d6+xadYsBPYJM2aTvcsVyavH/WTMX83z3XilAumh4ULyQOI/pusb?=
 =?us-ascii?Q?Lx2QFbsx4Bd6u9t3zibXM/foXf9aB4PaLCxUWJlCXuCw/bRivDBkCPvzivWW?=
 =?us-ascii?Q?paGXn69I0Fjsa51cSdFLOI7QNsjEHafr41XR7TnU98DDekFdi1pJErLt/EtE?=
 =?us-ascii?Q?KdqOz2Ky5acPZDUbW7g01StLt2iYNZgvhaONWmdMyRW9lFeHL8mBk2hALCno?=
 =?us-ascii?Q?7/XYfa/TJMOE0c5iCFZ/lzcAVAfg7jsI6XDv5A59g7a8OJ3FFaqeAf8DANoG?=
 =?us-ascii?Q?VlaqDE5KhfSXL18lBdP5MZfVbqFj8xRjotyyxVEPOTNDH+t1SY0Lx9Hzv9J6?=
 =?us-ascii?Q?kWdHECUyP9+NNTd6iz6duFvhoh21CnGEiKBuNO6UlnrfX9ytdaP265xiEBiQ?=
 =?us-ascii?Q?PdKo0jZ+rf7364863xK4uVQiH/2ngWpBuzceQMxxvL4xZife8Y/213ZxbHpL?=
 =?us-ascii?Q?vDvKvKHmsaAG8yZYl2WIxkQmXnfEZma3uWnE4cMPCeEQ68FancXwU8wJZ6TC?=
 =?us-ascii?Q?oc7tIldjoxvAqNYkbcnLrkwvlRMrbqcWc6ywqFd4gX1eiq7+18+FCrp/Eowq?=
 =?us-ascii?Q?Ano1xnOb9QLlMppaA25HwMKDhOVddTJ8q+elsaXYXYbHgOV7fyJkJariOl61?=
 =?us-ascii?Q?0dIjKBpfTylUxUePDWBmYHt6wEHTnrJakOo2B/rIWN7NdCxzDvRViKhxgjy9?=
 =?us-ascii?Q?ZnXv7urpH3XmJ0mQCBP0YJX56w7W+OA0Zj4QlxwRvl8fgs1weq4r3A1+7iIK?=
 =?us-ascii?Q?D4CZ1Llmr1dJ2o/+O2sMUuGOH1r4CyL5v/FjVyhlYhFoT12HSQRmM+k7ZlqV?=
 =?us-ascii?Q?6r8L7lH4X7x22QYeoDYEcJWKFJ2I88waKfeifsYHiTC6qFa1jac/hRqXxc1v?=
 =?us-ascii?Q?ZkaXBI5RjDqZKH07w/VhahjVN54pO3nGrdxrUiPFOJCVVXSR4ssmOQc2Hva5?=
 =?us-ascii?Q?NQWgkPhyk+5caKG+/92g9zMeIuVjOzGdjIbnOofHWr5mGBgjEqMpt8MGFSOV?=
 =?us-ascii?Q?nYSnbR4omRLb5EAzWJTkt5bFbSz6YSm4V37RLOUNB7A/9IstkpuI5n9oncz5?=
 =?us-ascii?Q?C9amQa6RwXpzF8PuOQJaBI5CB/nR1HvkV23N2Zag6GUhHqVoYLfhYp3hQSI5?=
 =?us-ascii?Q?qcmmCCQcWHyK058Vmjdn5n4PVJJh7AvFNrnmXK7QdwcBfbNYTG9R4DtOwk4/?=
 =?us-ascii?Q?ss5xkBQ5WMknKUPhbcpdgNJ66fTXjrCAXvBW0yQ9xz0BBT9hn10fMg/RuaRK?=
 =?us-ascii?Q?1ijWUqCkzroMY4ME1B/LCQeDYeXNyeOx00PGcf6i3fGObwceSb5iQugXkMoJ?=
 =?us-ascii?Q?ECWTHrRKuzFES2IDegQxzi2KthWnFLLHEHiw1goUxY89HqMPj/UP+B52X9O8?=
 =?us-ascii?Q?hUSzQoDyK5N8TVLbEnq9OZF7mUHmGnCSgb2a6Am/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3956d864-8d92-4913-ba61-08db6db59220
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 15:31:21.0634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6DnCl1kNJszYxisfuvfEPaT536uT9X8a8/CkqUPOwGggqNs8X4dcQcyktEhl4NB2cbnCkQevawbl64ooLLOdSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, June 15, 2023 22:03
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: mark GC 9.4.3 experimental for now

Mark as experimental for now until we get closer to production to avoid pos=
sible undesireable behavior when mixing newer boards with older kernels.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 859882109f55..60f765676a9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1896,6 +1896,8 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct a=
mdgpu_device *adev)
                amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
                break;
        case IP_VERSION(9, 4, 3):
+               if (!amdgpu_exp_hw_support)
+                       return -EINVAL;
                amdgpu_device_ip_block_add(adev, &gfx_v9_4_3_ip_block);
                break;
        case IP_VERSION(10, 1, 10):
--
2.40.1

