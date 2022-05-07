Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC835C433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  7 May 2022 06:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57DD1112784;
	Sat,  7 May 2022 06:24:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46FB8112786
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 May 2022 06:24:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ej3x/hFFx83l37JMgScGS480X/mSfYr1QUtZML4ZGHS85gNoK2nE7p5WXqiB2ljMvjTkBqDjLOOAH3R7AyI2HSy15uaRygZfWCxH6aZlEa/o6/ar5Dq7D3nW9A5DOoHGpROk5VfsxCuXMBlYFq0115IKUrj9e41Ykv02OvjSH1/a7aSdGzQE3Sa+BDKgczMOXTAeOeoxfT5xHOVb+tJiIxvIuxiC0+R9NVMHY4dJs3/FO/O7bNmtKQjpTEkry8HpPyBDtQ0hzlB20IsYj/sAdnljYphX5PR61KkEJAi4Wsjx+XS1T/+S4olBOoc3RtblhfPpX+8tvLS7d9hcv0ei3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qlNOzQXDJ6XL9u+wAvbw9Mk5DSnWt/wqFBeV7NmL1g=;
 b=F1jPQBFq9PzNnZ83FL8sNZO4PaJ4yeC+XpcY8YX77nGVCv8jtqCE0nHIPeBaGX2DDpFGe7o2tjNc5Gyc+MldWt6ygo/Mt6WfB5IPHkng7NY8sM5+fU749y+MZgcD4sHX5QCA+Y7diynfPfmO2/YLj6sqt7XLzK7VgcXL5dIkJYSAsJfvEfNYOVzVFZN6u6V2oo83oPiCJeq7s4zQOD/UhWorCWlpB/AedG3dGmoGJ9fuzKGL/sy3KJJIwBqHpH6dBKWm+LMt0WLWBkvdK3UGdwAQoWCUTmkhR7WnFQYoHIh9oqLvYgqt8rGZvtjRY93pi69lDjVxds+nWE8+G/7KuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qlNOzQXDJ6XL9u+wAvbw9Mk5DSnWt/wqFBeV7NmL1g=;
 b=qfVio7fwvjxizZEb3QYC/9XfTKrdcHwDZCut1Zv8BY6DdgOhktMY9z4t89owr/zuYScdCWoRcJamyEZ1DcTKXd9+DrMPI7G8Do5rMCHYV2t6tH1VcMmFMJlpRykOJYfOcPp/P6pYPp3yHW+CDMbwZF+A/Kekus8uoZQaxQz4cUU=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.25; Sat, 7 May 2022 06:24:37 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::f9e4:75ff:738d:8050]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::f9e4:75ff:738d:8050%7]) with mapi id 15.20.5227.020; Sat, 7 May 2022
 06:24:37 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/mes: fix format specifier for size_t
Thread-Topic: [PATCH] drm/amdgpu/mes: fix format specifier for size_t
Thread-Index: AQHYYWBEfpZaJM/BE0eTgLzollhxCa0S82lQ
Date: Sat, 7 May 2022 06:24:37 +0000
Message-ID: <DM5PR12MB2469E918CBB711D05D1349FBF1C49@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220506154430.3837653-1-alexander.deucher@amd.com>
In-Reply-To: <20220506154430.3837653-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02a2838a-82ab-4d67-55fd-08da2ff24293
x-ms-traffictypediagnostic: DM4PR12MB5231:EE_
x-microsoft-antispam-prvs: <DM4PR12MB52317E41C8E928C74DAF74ACF1C49@DM4PR12MB5231.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fii2SENpfQZ4w/YReMWglhO+6yFyyTq8TzURrh8+rNomPiUJTRZxPBCcIGCGhJuje4shuLULDNDkqQMbwro1SOpaG0cCoHdghCcruaGDvDiOz/7e7INkv06vkSMAWx1cAeNoQBGo44xwFlja+kAho23mgSqgc7UMltHCV6QIywgJGBLxKI8yuacw+ANZO/FvGyVTLueX2iSCKRvQyNaRM14nPykY6ScJayvqDEUFJl8Aa0XrXn7tlzFFAGilPh74iHBAWjhu0UaQ7l4Niiwnos8s4ovxMMwsInJqbr+gca9ZG2MaEHTZEhuk1ylcCEl9FsD2eEMcj3+e2SG832wzf9rIS3SvzOuQkmDStwc6u84oU7TDG5+yh4tn8AsDc0HjoAI2ZEun2FuKwTnih6Xhf3i8GXXzbD4NgZbH6Nj8sML08cGwpeOijFeLiUBPsAaKfx23obBp9x7QvRHs75clxOT92xuavl5p+HSZJAmOTRyViQbr2gL2Jo6kCA60Pgt01TreKMaNHmtY+Wrjab2JRrr31qUP1XXIs81uHyAaRnFX4bkrypY58Fyv/OMPldzm/dCUfPYRkhLm0AYDJtMs5BrEHcHiaLyUVFqqWk9ErHANlNFJVyirS8sQ5sIkQRovrmA94RXUdZMAjrwlzQVxdIT0ZRWaSF4QtZXGqZ7RskMxgv7TswNPoRlGkyQqD4V3xsoUU4OOaSAEE+ILS52ISg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(52536014)(33656002)(38100700002)(38070700005)(26005)(5660300002)(9686003)(86362001)(122000001)(4326008)(8936002)(7696005)(6506007)(2906002)(508600001)(53546011)(76116006)(316002)(55016003)(54906003)(186003)(110136005)(66946007)(83380400001)(8676002)(66556008)(64756008)(66446008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JmwStVJQvTDNddp+Ne+GHL43PKyONJS30MgARHkqQiOluJfmVJRdp/YLaQO/?=
 =?us-ascii?Q?ritcRzdXlk07Bmh6VtZ2ftc1vcIanLWWjY5XHzUIDi0M1X1N5Zy9zPhDBkJP?=
 =?us-ascii?Q?xuWSFhT3Z4oWwK2dMTNPMBrkVMsZWDDGsHftTqBmod8EXxWVc4dRC76TWdpE?=
 =?us-ascii?Q?alsGC3LvaLAApImP71m7JlY4O+UeVQrrUa5c/o7hZ1hIehLhhv+T0YNLe/Sz?=
 =?us-ascii?Q?Vm+idMXcDINM4HV4JRwhR2aSgirdRTXd8cn3nQ0DGkD3HiWA1d/HSoo/+a8T?=
 =?us-ascii?Q?qNlzDg9AWuTSQG3VLMwT534t0rMxZthsAmleqFs/7t+GkVoUIWnSQYqpOYcU?=
 =?us-ascii?Q?+xCipNJ9iO94AuDA9cjlNRRzUYrc0e7kCkfMEeIClNFp8ssYnpzgvT6OLUat?=
 =?us-ascii?Q?RF4B0Em6KWC7iJWRJ1XIPYbSW14sPiBStK4zcNoGXL0B5S1YrZ8MKrhIgOwq?=
 =?us-ascii?Q?OxhO4LzRc2zrHnjZ7lTcWN4+k21GzdMcF7vPYQWC247l5/Z/SkCV/Y0Kgzdj?=
 =?us-ascii?Q?STuRLBzr4BMIHNNhtbSIvKuK1rNXPCS75yFfRETtJJWhwNtZyk4CdqTiQrZA?=
 =?us-ascii?Q?S+HI64jnGrt+hQIWD44NsQaubqbqcW/IUULHvi3ai5hM2g8OIU8/QMtgdSeG?=
 =?us-ascii?Q?o+YxDvtjmeHLX6ps9mOJpgRbdhogi1YsS4JGm//CKTB/v4z418WYUqZrdPCH?=
 =?us-ascii?Q?F2gyIiyqoDc4kz+rJkNL7yDu7AxFHEykqNrrX7D4eRp0zL6KB4KqlvilvgO5?=
 =?us-ascii?Q?iWN6ZHlLSHOdvtUPLUBpQs27TuIKead20pkiJ8hPNYQZpN/nHWUupcmQ+FUV?=
 =?us-ascii?Q?w+4kx+Wqxdc2Gif+2N7KMCzFGANMWgpvqiSMUsXcusR1K7eF7dURvcyvlTxx?=
 =?us-ascii?Q?FLzCpJwgWJyU3jjyySKMSP5JPrbxkfoxkyowj7MRyzxDq7EpBOT3ZtAFTxHk?=
 =?us-ascii?Q?5Ufk7dQHh+BQ0d1IZerbGmU45ntnCxNvuqHl5Uyfp+kG8fmMAYljVc4XU/sF?=
 =?us-ascii?Q?lOB+f0NWBSHJz/GNd4+rt4U0cz4HoAzzyGHuUzkxOqilTp2TJ4SNObPWgS1U?=
 =?us-ascii?Q?6vTzVIWfc7hMRANZP/0jiJoFSala/acY2T6hLeSpaUQvPOY9j7+Jk5tXWoHy?=
 =?us-ascii?Q?3CoBrhqbeDx0nwJ+Yz+8W8MEXVDi4g8sUYMGvg//ANY0P84ZxS/fqcjWv5Xd?=
 =?us-ascii?Q?Pe/s1areEy8Y5p5QrGq3dNZb0x8vtJsuRDbWZ1Q0gQmmJsifrhhG68RmdFk5?=
 =?us-ascii?Q?V+MjMEqWNG2RIsRQzg9i+VU1ALFjYKbairkPyBT+T/ggCiSiojOUCe7EPVjh?=
 =?us-ascii?Q?GmBMvEXveViPGOCP6JSpdJhD8pJinmJK401V5vha4Baj81cSO864+BHpPK2J?=
 =?us-ascii?Q?+eoPQDhr0ZTzcZLYlQppSP3Lfz5iOqNmAKxO0eeaHMZP2PJTuggY612yLMfy?=
 =?us-ascii?Q?yqQjWlDC5GewAIwEK7tCRPr96GdH/9ml1epkFjHk0s5HNcqsZN8r+eo6joap?=
 =?us-ascii?Q?2P7ZPpDb0nzhLuSGVRGnLcg3esUsp+LBVOwzx82UVDyjrzvbm9fpKG2OCutF?=
 =?us-ascii?Q?9Z32fTgkXflp3FH8BXbDvEU0NVk3CV60eGCqH3of/zqgsRn2kncXZMeLUzbh?=
 =?us-ascii?Q?615VN/yt9wn8layCrgrMwBrruz8GuR9zT1vejKf+CAJVzIuTy2fcKRl2ENFa?=
 =?us-ascii?Q?ftJzGWbVYqRyg8fGocrGPtukjIIrGGtSs7l86B8BUopmeoTnP0W4EwblMLfT?=
 =?us-ascii?Q?cbmg11Ohlg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a2838a-82ab-4d67-55fd-08da2ff24293
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2022 06:24:37.1577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x346a1Z2uqu0yXc7GBtHpjHNpEDwp6P1kXApnS1w9PtMpzh6lJzsNWdBhC0oNRdKVNmQ1dXz9SdVpSfP8sEK0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, May 6, 2022 11:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; kernel test robot <lkp@=
intel.com>
Subject: [PATCH] drm/amdgpu/mes: fix format specifier for size_t

To avoid a warning on 32 bit.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 72bafba1c470..69a70a0aaed9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -135,7 +135,7 @@ static int amdgpu_mes_doorbell_init(struct amdgpu_devic=
e *adev)
 	adev->mes.doorbell_id_offset =3D doorbell_start_offset / sizeof(u32);
 	adev->mes.max_doorbell_slices =3D doorbell_process_limit;
=20
-	DRM_INFO("max_doorbell_slices=3D%ld\n", doorbell_process_limit);
+	DRM_INFO("max_doorbell_slices=3D%zu\n", doorbell_process_limit);
 	return 0;
 }
=20
--=20
2.35.1

