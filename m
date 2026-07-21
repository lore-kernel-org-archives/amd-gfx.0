Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46C3C4451C
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 07:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A17B10E2A1;
	Tue, 21 Jul 2026 07:20:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tey7qC2w";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4695610E2A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 07:20:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOLVj/Ky5zxQlUnTZ/wwlZSLqvSV/YLdjM3a6CiwGd1F9sxQs7HlKSv/iRx7kj3u/ORiIOC4rRVnZ1H2xgtDS4SuEhxFwp3EMsCHh7rO2vuQ650HNczzQkti3seVtK4qFecyUX9Z330ul36RBtynlsQzA+S422NsPnC6f3bEHupqQRzv4jnQg4FOvvihAI7QFeAGDB/iW+gqYcEJrLPdDqdz1qP8Sp5OEJbSHjvq9qPvPrSwTOeDK/uQtGWXrYQ0Ue9l0wC2EyWFpb86kmCzth2ekmPiOi7KdqQYBv+HorGha9BXuzNKMFv09rOQZM/PiPcSPr56xhAGZqZHtYRRJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ir3djTl1xXX/02yI/wyQLtrFlAJoweNRpa6CshQXJk=;
 b=WwlFRhlYhVO42hak6UgSZkNX0VPtBokvFF99PNlnNPv5qxb+pth56HJ8Ca6oomP7Yn4veFlCTQ8eQzNaCyoenCKBQnr/KvUDGl6DZJlaJufBAzhxi61ul7//McR5CkvYzaIa2FLOy1UX8BD3cw8Nx+wSrgmPsMhiRNJOE89Akj48761DnloCzEsgzCMLRh+b6zQ8d/+cL0siY0dp80WmuRUsnh8D46q9I4Z783g+zl698s5VEjtMi+AhsbbHBnls7+u56I+oWqxSEAvwU+iV5NNTWa78an5eaCndYj8WGWNKFFEDJeIBDp/oE4xsxz3aRz0FYBP39G1WLfkMov1qxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ir3djTl1xXX/02yI/wyQLtrFlAJoweNRpa6CshQXJk=;
 b=tey7qC2whuu4Y4H2xt5FXRAUfvN7tYrS0uRM13faBoGoKeiueVGsiCFb93hdocXr4k4HBSKHhgYr3DCw0pPX1gjg3+Ze5SaOozxVepJSfMcCo3lRODaAijjgR0w9uO+tte8NXxmZ5TthDmrt0NevLuR5nGavF7rhRa5anQbFYCE=
Received: from SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 by PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 07:20:01 +0000
Received: from SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::f66a:f590:f149:2fee]) by SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::f66a:f590:f149:2fee%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 07:20:01 +0000
From: "Fan, Shikang" <Shikang.Fan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "SHANMUGAM,
 SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC: "Yang, Philip" <Philip.Yang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>, "Zhang,
 Tiantian (Celine)" <Tiantian.Zhang@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation when
 MQD is in VRAM
Thread-Topic: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation when
 MQD is in VRAM
Thread-Index: AQHdFcno/vE+AMxPbkO89jaTg2SEG7ZxaYuAgAAUMtKABdc5soAAQU2M
Date: Tue, 21 Jul 2026 07:20:01 +0000
Message-ID: <SA1PR12MB7343FE954902BF06C7996A90EBC22@SA1PR12MB7343.namprd12.prod.outlook.com>
References: <20260715103056.3529178-1-shikang.fan@amd.com>
 <20260717085357.41610-1-shikang.fan@amd.com>
 <da934005-b10b-4e86-b8b0-a910e59b3d66@amd.com>
 <SA1PR12MB73439B22EB3FB6CFDCD16438EBC62@SA1PR12MB7343.namprd12.prod.outlook.com>
 <SA1PR12MB7343DCAFB25F4BA191AA3A6AEBC22@SA1PR12MB7343.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB7343DCAFB25F4BA191AA3A6AEBC22@SA1PR12MB7343.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Victor.Zhao@amd.com, Tiantian.Zhang@amd.com,
 Mario.Limonciello@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-21T07:20:00.540Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7343:EE_|PH7PR12MB5596:EE_
x-ms-office365-filtering-correlation-id: caa1a5b3-6d0c-4b34-2a47-08dee6f87a76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|6133799003|56012099006|5023799004|11063799006|10067099003|4143699003|22082099003|18002099003|8096899003;
x-microsoft-antispam-message-info: rMUYAMkFHy9oh/c1YpbFXKgRMzkA2rhvmFuw31QsJY8JL6cR9X4fbdK0kuC8Vx9p2AGMf4IE16kNh4bVmW4/QV7fuS2gI0IfuqeRUJ0PsxNvnEF+uZVx4w1TSthwuX+A+cYSm1XRuEEm+CJMA37aQkS64qlAqkIOIDWisSxjkezdUgssqxQeiN8aoPJ+BvgQzXu8Ua4YwHMkO81q4OWbOumrjNDhAgaDnvdtA3g8i+pBKroOytRbl4waJnJrJFc94b5EbeAcE8PpmJc6dwJ7pUji4JEij76QwBq7LzybcssDRtYJH0LqZDyovots7QP8J9hukVS2ErK2J5HylzOFXSww+p7MbeXaaOAXmg6s1t9joVFYRVusBlwDmJPKLPocS21hUxJM9vZbrrkGtdokhmn69coDy272XDhfLZ+9iv5+wcVPTF+br4St4mICcADEO2KACeSqY8bFibnHOon3XFT2jYFr0K9MhBXhvrCN+nSeA1fnLAdbzyX29eYyydc75OK6R8JAu636ud+w0smVSiBcqePRYNxoeD85U8PTkVh553gxUkpKJjX9Dc637eM24sdLSr/LMq7ish/4AFHUZHr8zCGV9IAU+U1oENiMaSCxJx3NJrx80latNTyFywcs2vrX2dQvHXgQFWUfoV7Od9zMolByRFHoEVNnQJCaYhFG5OVwbHn9OHdVs76hDScygSNDcpIyWG+gnIGHCJTPyCUQETiwyptnCJVwB/d7DBg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7343.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?qRhzg2OcblV772s5dVxvzlzQrZUyvztzmwFuVV9RZViwNc1LQtacvols?=
 =?Windows-1252?Q?9IifiuC6VyaNDgU4AHzmxN1r4doPgTt/CU96b44szN8Hb+BLZKCAwb5D?=
 =?Windows-1252?Q?C4DRIBwQBQm7GQPXS/8ytbHOLjOm3f+4FlWbj207oQcJ2I7h944iztg8?=
 =?Windows-1252?Q?OAEwilVe6ORJF/3qf8iOwrzcaD50DtR9u5VOWAKL/2hM33cgGJltqmHR?=
 =?Windows-1252?Q?BnNbK/mr+1YpJS9UE6HPRDfh/y/VuBzqjYn9woICAQ65MPsqEP+dOQOx?=
 =?Windows-1252?Q?E5a3iSvpDvsLqQiZNkgTfQBEhNdRB87+NqmsZz2e4y/xH+JsgUtSrVmn?=
 =?Windows-1252?Q?K04+WGFHgX9O85TpTHZemVgFuKXiI/otGwrbPYfjy+3q3xAUqMrmevjo?=
 =?Windows-1252?Q?dsXYeqAi91V36SfifBgWdK3zgZN+FX8ehXK42dRFoLyzrw/MzCYzM7JZ?=
 =?Windows-1252?Q?nTcM+eXrTh9xK20ri+yvPADBmdpzMvKT9J7SQxIn4aIuZRPBPVJgofcY?=
 =?Windows-1252?Q?nkIks0wafTD9CfINLcBoXbxc6Kldq+Lo8QCLnbh3z+1GysC6CA71bkLV?=
 =?Windows-1252?Q?44rF+h2h+nQ9wRtZKISIX0nRNmwDUz42P5358fT+NRtIzkC7uij7JcFe?=
 =?Windows-1252?Q?hOlEI4xgf/eZ4pcX/7RL7SIVjZ96etENOlbrpdrIdYngnVx5qEb4+FFm?=
 =?Windows-1252?Q?DXA48aZqglwySUPMdfUQhjClTneR3LqKjNKRu+eoXFueYsBWSFEwp4SZ?=
 =?Windows-1252?Q?QLLsWf1XCwVQgoXGYI2QYrbgVb7dW/43w5C3t+vBYf8TbW0o0oKfDcRn?=
 =?Windows-1252?Q?89l4Nnnv6l6oKxjruKl/PQtwG03+z5FvEJNrNuskIr7zuRkFCRdAEpR8?=
 =?Windows-1252?Q?OH4vfvmXcFx11PJLcEw0rlRlF5H5t6vieIUq+zi5n9nFoC/zPtX+7XZz?=
 =?Windows-1252?Q?7MOSeHsi/QX2Y8sezj68zz4tAHXv++JZ4qEcIL9Jw30zEqTACQhQQgve?=
 =?Windows-1252?Q?A9JmhKNU+sNkPLjmGgXoT/YiY1a5f34vHXB1hpmNf3/z5EygynYEY+FZ?=
 =?Windows-1252?Q?FburiNg1vu4C7Ctugj9nSTJubbc02o5RppyVoguPsVCOEyIkOfYMwEMh?=
 =?Windows-1252?Q?6i5Q+nsJKvkQRuSonnvJLFf3Lc3vywLjej8kguziBs1X9sxK6Z0zmde/?=
 =?Windows-1252?Q?d0Jzrfp49rUke0vUUCBSO5s6S2cm/uBdSyHHIoFmo9rb0cp2PRpKM6Nx?=
 =?Windows-1252?Q?dtmlSiJ0qlGku5IPA4M0oAK1ZPWCdMAOWI/IyuuisOO2U8fEepyLsTVy?=
 =?Windows-1252?Q?EMG/kr7lDqYhWOAhroq7jtXQ+hpmtZmdfiN4+3P3qHvhpfaY3a1R9IQ1?=
 =?Windows-1252?Q?sf+xntD0x9OltyVyPnVEXHck0SIqMJdHYBDF2dipqRw4WAvqelfvBb6l?=
 =?Windows-1252?Q?D7JUamPyTQ6zg0+h3P4/PgcvebGfiyu/F+VW30RVwN4fkZnOCqcmhq0W?=
 =?Windows-1252?Q?MKSscVwtwpCz3KMZ6RChLftUuHM4YXk8wbdWfQRCSlb/VoSVkG1pdsd5?=
 =?Windows-1252?Q?LjHmNx219hs03nILzyawaDSnWPWF9T1bxeMh3YCClaRWz9jbz2uZwMC2?=
 =?Windows-1252?Q?W1yCo4Z3sFxEvaSO9bzpoqQ4zu+Vy+DpUQoDO9qQZg+Z3aW+LGsn+diZ?=
 =?Windows-1252?Q?voNW4+5HS7hJM/+rw2UKXYXoiVKrGVE9T8PrbaDg0lNtOoGz8skDjfma?=
 =?Windows-1252?Q?WMibWFsuazh1HL7v7EAUXkugNbvrUeWopALv60MM2n6mVeyl5abgtdl0?=
 =?Windows-1252?Q?vVBjVmy6DGgIcy81AvX2v3w4CXerxFlgYdjqhtqy2E0FtmMy?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB7343FE954902BF06C7996A90EBC22SA1PR12MB7343namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7343.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa1a5b3-6d0c-4b34-2a47-08dee6f87a76
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 07:20:01.3435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b69BdG3K7o1N/Vx3wGl8NRxJgYciGjzm2W3jmHieiP0tgxSbSqwDGCADsdKSzovFe9KZxT6KvV62b2SdTHqcFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596
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

--_000_SA1PR12MB7343FE954902BF06C7996A90EBC22SA1PR12MB7343namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

AMD General

+@Zhao, Victor<mailto:Victor.Zhao@amd.com>, @Zhang, Tiantian (Celine)<mailt=
o:Tiantian.Zhang@amd.com>.  And also @Limonciello, Mario<mailto:Mario.Limon=
ciello@amd.com> to help with the review.

Regards,
Shikang

________________________________
From: Fan, Shikang <Shikang.Fan@amd.com>
Sent: Tuesday, July 21, 2026 11:25 AM
To: Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>; SHANMUGAM, SRINIVASAN <SRINIVASAN.SHA=
NMUGAM@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: Yang, Philip <Philip.Yang@amd.com>; Deucher, Alexander <Alexander.Deuch=
er@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation whe=
n MQD is in VRAM

AMD General

+@SHANMUGAM, SRINIVASAN<mailto:SRINIVASAN.SHANMUGAM@amd.com> and @Kuehling,=
 Felix<mailto:Felix.Kuehling@amd.com> to the review discussion as Christian=
 is currently OOO.

Regards,
Shikang

________________________________
From: Fan, Shikang <Shikang.Fan@amd.com>
Sent: Friday, July 17, 2026 6:25 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Cc: Yang, Philip <Philip.Yang@amd.com>; Deucher, Alexander <Alexander.Deuch=
er@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation whe=
n MQD is in VRAM

AMD General


I do have a few thoughts on the unpin-repin approach and re-building the MQ=
D from housekeeping information.

For unpin-repin: the MQD's GPU address may change after it's moved back fro=
m GTT, and several places hold the original address, so we'd need to update=
 all of them and be careful not to miss any =97 but overall it's doable.

For re-build: the one thing we can't reconstruct is the control stack. It r=
esides in the same BO as the MQD, and the driver doesn't preserve its conte=
nts.

Separately, I'd like to raise a potential pre-existing issue I noticed whil=
e writing the patch. mqd_on_vram() covers gfx942, gfx943, gfx944 and gfx950=
. gfx943/944/950 are all registered with the _v9_4_3 implementations, which=
 call flush_hdp() in init_mqd, update_mqd and restore_mqd. gfx942, however,=
 uses the base MQD functions, which lack the flush_hdp() call.

Regards,
Shikang

________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Friday, July 17, 2026 4:59 PM
To: Fan, Shikang <Shikang.Fan@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Yang, Philip <Philip.Yang@amd.com>; Deucher, Alexander <Alexander.Deuch=
er@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation whe=
n MQD is in VRAM

On 7/17/26 10:53, Shikang Fan wrote:
> On gfx942/944 and gfx9.5.0, KFD compute-queue MQDs live in a pinned VRAM
> BO (mqd_on_vram()). Pinned VRAM is skipped by TTM eviction and not saved
> across S4 hibernation, so the MQD is garbage on resume and the first
> submission faults. Save it to a system-RAM shadow at suspend and restore
> it on resume, reusing the CRIU checkpoint_mqd/restore_mqd primitives.
>
> v2:
>  - Also snapshot the MQD when a process is already runtime-evicted at
>    hibernation start. The qpd->evicted refcount early-return previously
>    skipped the save loop, losing the MQD across the VRAM wipe (both the
>    cpsch and nocpsch evict paths).
>
> Signed-off-by: Shikang Fan <shikang.fan@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 120 +++++++++++++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   9 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |   2 +
>  3 files changed, 129 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 51ee9c39104b..d168686ee324 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -65,6 +65,9 @@ static int map_queues_cpsch(struct device_queue_manager=
 *dqm);
>  static void deallocate_sdma_queue(struct device_queue_manager *dqm,
>                                struct queue *q);
>
> +static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, struct=
 queue *q);
> +static void dqm_save_mqd_backup(struct device_queue_manager *dqm, struct=
 queue *q);
> +
>  static inline void deallocate_hqd(struct device_queue_manager *dqm,
>                                struct queue *q);
>  static int allocate_hqd(struct device_queue_manager *dqm, struct queue *=
q);
> @@ -802,6 +805,10 @@ static int create_queue_nocpsch(struct device_queue_=
manager *dqm,
>                mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
>                                        &q->gart_mqd_addr, &q->properties)=
;
>
> +     retval =3D dqm_alloc_mqd_backup(dqm, q);
> +     if (retval)
> +             goto out_free_mqd;
> +
>        if (q->properties.is_active) {
>                if (!dqm->sched_running) {
>                        WARN_ONCE(1, "Load non-HWS mqd while stopped\n");
> @@ -1263,8 +1270,16 @@ static int evict_process_queues_nocpsch(struct dev=
ice_queue_manager *dqm,
>        int retval, ret =3D 0;
>
>        dqm_lock(dqm);
> -     if (qpd->evicted++ > 0) /* already evicted, do nothing */
> +     if (qpd->evicted++ > 0) { /* already evicted, do nothing */
> +             /* A process already runtime-evicted when hibernation start=
s
> +              * skips the save loop below, so snapshot its VRAM MQDs her=
e
> +              * before the S4 image is taken. dqm_save_mqd_backup() is a
> +              * no-op outside S4.
> +              */
> +             list_for_each_entry(q, &qpd->queues_list, list)
> +                     dqm_save_mqd_backup(dqm, q);
>                goto out;
> +     }
>
>        pdd =3D qpd_to_pdd(qpd);
>        pr_debug_ratelimited("Evicting process pid %d queues\n",
> @@ -1297,6 +1312,8 @@ static int evict_process_queues_nocpsch(struct devi=
ce_queue_manager *dqm,
>                         * maintain a consistent eviction state
>                         */
>                        ret =3D retval;
> +
> +             dqm_save_mqd_backup(dqm, q);
>        }
>
>  out:
> @@ -1304,6 +1321,88 @@ static int evict_process_queues_nocpsch(struct dev=
ice_queue_manager *dqm,
>        return ret;
>  }
>
> +/* MQD software-shadow save/restore across S4 hibernation, reusing the C=
RIU
> + * checkpoint_mqd/restore_mqd primitives.
> + */
> +static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, struct=
 queue *q)
> +{
> +     struct mqd_manager *mqd_mgr;
> +     uint32_t mqd_size, ctl_stack_size =3D 0;
> +
> +     if (!mqd_on_vram(dqm->dev->adev))
> +             return 0;
> +     if (q->properties.type !=3D KFD_QUEUE_TYPE_COMPUTE)
> +             return 0;
> +     if (!q->mqd)
> +             return 0;
> +
> +     mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->propertie=
s.type)];
> +     if (!mqd_mgr->checkpoint_mqd || !mqd_mgr->restore_mqd)
> +             return 0;
> +
> +     mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mqd_mgr->mqd_size) *
> +                NUM_XCC(dqm->dev->xcc_mask);
> +     if (mqd_mgr->get_checkpoint_info)
> +             mqd_mgr->get_checkpoint_info(mqd_mgr, q->mqd, &ctl_stack_si=
ze);
> +
> +     if (!q->mqd_backup) {
> +             q->mqd_backup =3D kzalloc(mqd_size, GFP_KERNEL);

Please note that you need to be super careful when allocating memory during=
 suspend. The amount available is really limited because both swap and OOM =
killer are already stopped.

Instead you should probably consider unpinning on suspend and repinning on =
resume, for this we have memory put asside.

Additional to that it could be that backing up the MQD is overkill, we shou=
ld be able to re-create the MQD after resume from the housekeeping informat=
ion we still have around.

Regards,
Christian.


> +             if (!q->mqd_backup)
> +                     return -ENOMEM;
> +             q->mqd_backup_size =3D mqd_size;
> +     }
> +     if (ctl_stack_size && !q->ctl_stack_backup) {
> +             q->ctl_stack_backup =3D kzalloc(ctl_stack_size, GFP_KERNEL)=
;
> +             if (!q->ctl_stack_backup) {
> +                     kfree(q->mqd_backup);
> +                     q->mqd_backup =3D NULL;
> +                     q->mqd_backup_size =3D 0;
> +                     return -ENOMEM;
> +             }
> +             q->ctl_stack_backup_size =3D ctl_stack_size;
> +     }
> +
> +     return 0;
> +}
> +
> +static void dqm_save_mqd_backup(struct device_queue_manager *dqm, struct=
 queue *q)
> +{
> +     struct mqd_manager *mqd_mgr;
> +
> +     /* in_s4 is reliably set at evict/suspend time; skip normal runtime=
 eviction
> +      * (pinned VRAM MQD stays intact then).
> +      */
> +     if (!dqm->dev->adev->in_s4)
> +             return;
> +     if (!q->mqd_backup)
> +             return;
> +     if (!q->mqd || !q->mqd_mem_obj || !q->mqd_mem_obj->cpu_ptr)
> +             return;
> +
> +     mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->propertie=
s.type)];
> +     mqd_mgr->checkpoint_mqd(mqd_mgr, q->mqd, q->mqd_backup, q->ctl_stac=
k_backup);
> +     q->mqd_backup_valid =3D true;
> +}
> +
> +static void dqm_restore_mqd_backup(struct device_queue_manager *dqm, str=
uct queue *q)
> +{
> +     struct mqd_manager *mqd_mgr;
> +
> +     if (!q->mqd_backup_valid || !q->mqd_backup)
> +             return;
> +     if (!q->mqd_mem_obj)
> +             return;
> +
> +     mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->propertie=
s.type)];
> +     if (!mqd_mgr->restore_mqd)
> +             return;
> +
> +     mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q->gart_mqd=
_addr,
> +                          &q->properties, q->mqd_backup, q->ctl_stack_ba=
ckup,
> +                          q->ctl_stack_backup_size);
> +     q->mqd_backup_valid =3D false;
> +}
> +
>  static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>                                      struct qcm_process_device *qpd)
>  {
> @@ -1313,8 +1412,16 @@ static int evict_process_queues_cpsch(struct devic=
e_queue_manager *dqm,
>        int retval =3D 0;
>
>        dqm_lock(dqm);
> -     if (qpd->evicted++ > 0) /* already evicted, do nothing */
> +     if (qpd->evicted++ > 0) { /* already evicted, do nothing */
> +             /* A process already runtime-evicted when hibernation start=
s
> +              * skips the save loop below, so snapshot its VRAM MQDs her=
e
> +              * before the S4 image is taken. dqm_save_mqd_backup() is a
> +              * no-op outside S4.
> +              */
> +             list_for_each_entry(q, &qpd->queues_list, list)
> +                     dqm_save_mqd_backup(dqm, q);
>                goto out;
> +     }
>
>        pdd =3D qpd_to_pdd(qpd);
>
> @@ -1350,6 +1457,8 @@ static int evict_process_queues_cpsch(struct device=
_queue_manager *dqm,
>                                goto out;
>                        }
>                }
> +
> +             dqm_save_mqd_backup(dqm, q);
>        }
>
>        if (!dqm->dev->kfd->shared_resources.enable_mes) {
> @@ -1423,6 +1532,7 @@ static int restore_process_queues_nocpsch(struct de=
vice_queue_manager *dqm,
>
>                mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>                                q->properties.type)];
> +             dqm_restore_mqd_backup(dqm, q);
>                q->properties.is_active =3D true;
>                increment_queue_count(dqm, qpd, q);
>
> @@ -1486,6 +1596,7 @@ static int restore_process_queues_cpsch(struct devi=
ce_queue_manager *dqm,
>                if (!QUEUE_IS_ACTIVE(q->properties))
>                        continue;
>
> +             dqm_restore_mqd_backup(dqm, q);

Those are the wrong point to call those functions if I'm not completely mis=
taken.

Regards,
Christian.

>                q->properties.is_active =3D true;
>                increment_queue_count(dqm, &pdd->qpd, q);
>
> @@ -2161,6 +2272,10 @@ static int create_queue_cpsch(struct device_queue_=
manager *dqm, struct queue *q,
>                mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
>                                        &q->gart_mqd_addr, &q->properties)=
;
>
> +     retval =3D dqm_alloc_mqd_backup(dqm, q);
> +     if (retval)
> +             goto out_free_mqd;
> +
>        list_add(&q->list, &qpd->queues_list);
>        qpd->queue_count++;
>
> @@ -2193,6 +2308,7 @@ static int create_queue_cpsch(struct device_queue_m=
anager *dqm, struct queue *q,
>        list_del(&q->list);
>        if (q->properties.is_active)
>                decrement_queue_count(dqm, qpd, q);
> +out_free_mqd:
>        mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
>        dqm_unlock(dqm);
>  out_deallocate_doorbell:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index 88191a4c1657..1f728f13813e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -637,6 +637,15 @@ struct queue {
>        void *gang_ctx_cpu_ptr;
>
>        struct amdgpu_bo *wptr_bo_gart;
> +
> +     /* system-RAM shadow of a VRAM-resident MQD (+ control stack)
> +      * for hibernation snapshot/restore
> +      */
> +     void *mqd_backup;
> +     void *ctl_stack_backup;
> +     uint32_t mqd_backup_size;
> +     uint32_t ctl_stack_backup_size;
> +     bool mqd_backup_valid;
>  };
>
>  enum KFD_MQD_TYPE {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_queue.c
> index 98a5512b701b..cbc90bf87792 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -83,6 +83,8 @@ int init_queue(struct queue **q, const struct queue_pro=
perties *properties)
>
>  void uninit_queue(struct queue *q)
>  {
> +     kfree(q->mqd_backup);
> +     kfree(q->ctl_stack_backup);
>        kfree(q);
>  }
>


--_000_SA1PR12MB7343FE954902BF06C7996A90EBC22SA1PR12MB7343namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
+<a href=3D"mailto:Victor.Zhao@amd.com" id=3D"OWAAM420325" class=3D"tWKOu m=
ention ms-bgc-nlr ms-fcl-b">@Zhao, Victor</a>,
<a href=3D"mailto:Tiantian.Zhang@amd.com" id=3D"OWAAM394558" class=3D"tWKOu=
 mention ms-bgc-nlr ms-fcl-b">
@Zhang, Tiantian (Celine)</a>. &nbsp;And also&nbsp;<a href=3D"mailto:Mario.=
Limonciello@amd.com" id=3D"OWAAM671300" class=3D"tWKOu mention ms-bgc-nlr m=
s-fcl-b">@Limonciello, Mario</a>&nbsp;to help with the review.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Shikang</div>
<div><span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0);"><br>
</span></div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Fan, Shikang &lt;Shikang.Fan@amd.com&gt;<br>
<b>Sent:</b> Tuesday, July 21, 2026 11:25 AM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; SHANMUGAM, SRINIVA=
SAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehlin=
g@amd.com&gt;<br>
<b>Cc:</b> Yang, Philip &lt;Philip.Yang@amd.com&gt;; Deucher, Alexander &lt=
;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernat=
ion when MQD is in VRAM
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; text-align: left; margin-left: 5pt; font-fami=
ly: Calibri; font-size: 10pt; color: rgb(0, 0, 255);">
AMD General</div>
<div style=3D"direction: ltr;"><br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
+<a href=3D"mailto:SRINIVASAN.SHANMUGAM@amd.com" id=3D"OWAAM517752" class=
=3D"x_tWKOu x_mention x_ms-bgc-nlr x_ms-fcl-b">@SHANMUGAM, SRINIVASAN</a>&n=
bsp;and
<a href=3D"mailto:Felix.Kuehling@amd.com" id=3D"OWAAM431627" class=3D"x_tWK=
Ou x_mention x_ms-bgc-nlr x_ms-fcl-b">
@Kuehling, Felix</a>&nbsp;to the review discussion as Christian is currentl=
y OOO.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Regards,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Shikang</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"direction: ltr; display: inline-block; width: 98%;">
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Fan, Shikang &lt;Shikang.Fan@amd.com&gt;<br>
<b>Sent:</b> Friday, July 17, 2026 6:25 PM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Yang, Philip &lt;Philip.Yang@amd.com&gt;; Deucher, Alexander &lt=
;Alexander.Deucher@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com&=
gt;<br>
<b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernat=
ion when MQD is in VRAM</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; text-align: left; margin-left: 5pt; font-fami=
ly: Calibri; font-size: 10pt; color: rgb(0, 0, 255);">
AMD General</div>
<div style=3D"direction: ltr;"><br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
I do have a few thoughts on the unpin-repin approach and re-building the MQ=
D from housekeeping information.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
For unpin-repin: the MQD's GPU address may change after it's moved back fro=
m GTT, and several places hold the original address, so we'd need to update=
 all of them and be careful not to miss any =97 but overall it's doable.</d=
iv>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
For re-build: the one thing we can't reconstruct is the control stack. It r=
esides in the same BO as the MQD, and the driver doesn't preserve its conte=
nts.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Separately, I'd like to raise a potential pre-existing issue I noticed whil=
e writing the patch. mqd_on_vram() covers gfx942, gfx943, gfx944 and gfx950=
. gfx943/944/950 are all registered with the _v9_4_3 implementations, which=
 call flush_hdp() in init_mqd, update_mqd
 and restore_mqd. gfx942, however, uses the base MQD functions, which lack =
the flush_hdp() call.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Regards,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Shikang</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"direction: ltr; display: inline-block; width: 98%;">
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Friday, July 17, 2026 4:59 PM<br>
<b>To:</b> Fan, Shikang &lt;Shikang.Fan@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Yang, Philip &lt;Philip.Yang@amd.com&gt;; Deucher, Alexander &lt=
;Alexander.Deucher@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com&=
gt;<br>
<b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernat=
ion when MQD is in VRAM</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-size: 11pt;">On 7/17/26 10:53, Shikang F=
an wrote:<br>
&gt; On gfx942/944 and gfx9.5.0, KFD compute-queue MQDs live in a pinned VR=
AM<br>
&gt; BO (mqd_on_vram()). Pinned VRAM is skipped by TTM eviction and not sav=
ed<br>
&gt; across S4 hibernation, so the MQD is garbage on resume and the first<b=
r>
&gt; submission faults. Save it to a system-RAM shadow at suspend and resto=
re<br>
&gt; it on resume, reusing the CRIU checkpoint_mqd/restore_mqd primitives.<=
br>
&gt;<br>
&gt; v2:<br>
&gt;&nbsp; - Also snapshot the MQD when a process is already runtime-evicte=
d at<br>
&gt;&nbsp;&nbsp;&nbsp; hibernation start. The qpd-&gt;evicted refcount earl=
y-return previously<br>
&gt;&nbsp;&nbsp;&nbsp; skipped the save loop, losing the MQD across the VRA=
M wipe (both the<br>
&gt;&nbsp;&nbsp;&nbsp; cpsch and nocpsch evict paths).<br>
&gt;<br>
&gt; Signed-off-by: Shikang Fan &lt;shikang.fan@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; .../drm/amd/amdkfd/kfd_device_queue_manager.c | 120 ++++++++++++=
+++++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 9 ++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_queue.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
&gt;&nbsp; 3 files changed, 129 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/d=
rivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; index 51ee9c39104b..d168686ee324 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; @@ -65,6 +65,9 @@ static int map_queues_cpsch(struct device_queue_mana=
ger *dqm);<br>
&gt;&nbsp; static void deallocate_sdma_queue(struct device_queue_manager *d=
qm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue *q);<br>
&gt;&nbsp;<br>
&gt; +static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, str=
uct queue *q);<br>
&gt; +static void dqm_save_mqd_backup(struct device_queue_manager *dqm, str=
uct queue *q);<br>
&gt; +<br>
&gt;&nbsp; static inline void deallocate_hqd(struct device_queue_manager *d=
qm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue *q);<br>
&gt;&nbsp; static int allocate_hqd(struct device_queue_manager *dqm, struct=
 queue *q);<br>
&gt; @@ -802,6 +805,10 @@ static int create_queue_nocpsch(struct device_que=
ue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;init_mqd(mqd_mgr, &amp;q-&gt;mqd, q-&gt;mqd=
_mem_obj,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &amp;q-&gt;gart_mqd_addr, &amp;q-&gt;properties);<br>
&gt;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; retval =3D dqm_alloc_mqd_backup(dqm, q);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto out_free_mqd;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_acti=
ve) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;sched_running) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON=
CE(1, &quot;Load non-HWS mqd while stopped\n&quot;);<br>
&gt; @@ -1263,8 +1270,16 @@ static int evict_process_queues_nocpsch(struct =
device_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval, ret =3D 0;<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) /* already evi=
cted, do nothing */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) { /* already e=
victed, do nothing */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* A process already runtime-evicted when hibernation starts<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * skips the save loop below, so snapshot its VRAM MQDs here<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * before the S4 image is taken. dqm_save_mqd_backup() is a<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * no-op outside S4.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; list_for_each_entry(q, &amp;qpd-&gt;queues_list, list)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_save_mqd_backup(dqm=
, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd =3D qpd_to_pdd(qpd);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug_ratelimited(&quot;E=
victing process pid %d queues\n&quot;,<br>
&gt; @@ -1297,6 +1312,8 @@ static int evict_process_queues_nocpsch(struct d=
evice_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 maintain a consistent eviction state<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D=
 retval;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm_save_mqd_backup(dqm, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;<br>
&gt;&nbsp; out:<br>
&gt; @@ -1304,6 +1321,88 @@ static int evict_process_queues_nocpsch(struct =
device_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt;&nbsp;<br>
&gt; +/* MQD software-shadow save/restore across S4 hibernation, reusing th=
e CRIU<br>
&gt; + * checkpoint_mqd/restore_mqd primitives.<br>
&gt; + */<br>
&gt; +static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, str=
uct queue *q)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mqd_size, ctl_stack_size =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_on_vram(dqm-&gt;dev-&gt;adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type !=3D KFD_QUEUE_TYP=
E_COMPUTE)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_fr=
om_queue_type(q-&gt;properties.type)];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_mgr-&gt;checkpoint_mqd || !mqd_mgr-=
&gt;restore_mqd)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mqd_mgr-&=
gt;mqd_size) *<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; NUM_XCC(dqm-&gt;dev-&gt;xcc_mask);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (mqd_mgr-&gt;get_checkpoint_info)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mqd_mgr-&gt;get_checkpoint_info(mqd_mgr, q-&gt;mqd, &amp;ctl_stack_size=
);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; q-&gt;mqd_backup =3D kzalloc(mqd_size, GFP_KERNEL);<br>
<br>
Please note that you need to be super careful when allocating memory during=
 suspend. The amount available is really limited because both swap and OOM =
killer are already stopped.<br>
<br>
Instead you should probably consider unpinning on suspend and repinning on =
resume, for this we have memory put asside.<br>
<br>
Additional to that it could be that backing up the MQD is overkill, we shou=
ld be able to re-create the MQD after resume from the housekeeping informat=
ion we still have around.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!q-&gt;mqd_backup)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; q-&gt;mqd_backup_size =3D mqd_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ctl_stack_size &amp;&amp; !q-&gt;ctl_sta=
ck_backup) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; q-&gt;ctl_stack_backup =3D kzalloc(ctl_stack_size, GFP_KERNEL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!q-&gt;ctl_stack_backup) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;mqd_backup)=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup =3D NU=
LL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_size =
=3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; q-&gt;ctl_stack_backup_size =3D ctl_stack_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void dqm_save_mqd_backup(struct device_queue_manager *dqm, str=
uct queue *q)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* in_s4 is reliably set at evict/suspend ti=
me; skip normal runtime eviction<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (pinned VRAM MQD stays intact then).=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;dev-&gt;adev-&gt;in_s4)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd || !q-&gt;mqd_mem_obj || !q-&=
gt;mqd_mem_obj-&gt;cpu_ptr)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_fr=
om_queue_type(q-&gt;properties.type)];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;checkpoint_mqd(mqd_mgr, q-&gt;mq=
d, q-&gt;mqd_backup, q-&gt;ctl_stack_backup);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_valid =3D true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void dqm_restore_mqd_backup(struct device_queue_manager *dqm, =
struct queue *q)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup_valid || !q-&gt;mqd_ba=
ckup)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_mem_obj)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_fr=
om_queue_type(q-&gt;properties.type)];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_mgr-&gt;restore_mqd)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;restore_mqd(mqd_mgr, &amp;q-&gt;=
mqd, q-&gt;mqd_mem_obj, &amp;q-&gt;gart_mqd_addr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; &amp;q-&gt;properties, q-&gt;mqd_backup, q-&gt;ctl_stack_backup,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; q-&gt;ctl_stack_backup_size);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_valid =3D false;<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; static int evict_process_queues_cpsch(struct device_queue_manage=
r *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct qcm_process_device *qpd)<br>
&gt;&nbsp; {<br>
&gt; @@ -1313,8 +1412,16 @@ static int evict_process_queues_cpsch(struct de=
vice_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval =3D 0;<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) /* already evi=
cted, do nothing */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) { /* already e=
victed, do nothing */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* A process already runtime-evicted when hibernation starts<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * skips the save loop below, so snapshot its VRAM MQDs here<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * before the S4 image is taken. dqm_save_mqd_backup() is a<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * no-op outside S4.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; list_for_each_entry(q, &amp;qpd-&gt;queues_list, list)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_save_mqd_backup(dqm=
, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd =3D qpd_to_pdd(qpd);<br>
&gt;&nbsp;<br>
&gt; @@ -1350,6 +1457,8 @@ static int evict_process_queues_cpsch(struct dev=
ice_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm_save_mqd_backup(dqm, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;dev-&gt;kfd-&gt=
;shared_resources.enable_mes) {<br>
&gt; @@ -1423,6 +1532,7 @@ static int restore_process_queues_nocpsch(struct=
 device_queue_manager *dqm,<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_ty=
pe(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.type)];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm_restore_mqd_backup(dqm, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; q-&gt;properties.is_active =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, qpd, q);<br>
&gt;&nbsp;<br>
&gt; @@ -1486,6 +1596,7 @@ static int restore_process_queues_cpsch(struct d=
evice_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!QUEUE_IS_ACTIVE(q-&gt;properties))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm_restore_mqd_backup(dqm, q);<br>
<br>
Those are the wrong point to call those functions if I'm not completely mis=
taken.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; q-&gt;properties.is_active =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, &amp;pdd-&gt;qpd, q);<br>
&gt;&nbsp;<br>
&gt; @@ -2161,6 +2272,10 @@ static int create_queue_cpsch(struct device_que=
ue_manager *dqm, struct queue *q,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;init_mqd(mqd_mgr, &amp;q-&gt;mqd, q-&gt;mqd=
_mem_obj,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &amp;q-&gt;gart_mqd_addr, &amp;q-&gt;properties);<br>
&gt;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; retval =3D dqm_alloc_mqd_backup(dqm, q);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto out_free_mqd;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;q-&gt;list, &a=
mp;qpd-&gt;queues_list);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;queue_count++;<br>
&gt;&nbsp;<br>
&gt; @@ -2193,6 +2308,7 @@ static int create_queue_cpsch(struct device_queu=
e_manager *dqm, struct queue *q,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;q-&gt;list);<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_acti=
ve)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; decrement_queue_count(dqm, qpd, q);<br>
&gt; +out_free_mqd:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;free_mqd(mqd_mgr=
, q-&gt;mqd, q-&gt;mqd_mem_obj);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_unlock(dqm);<br>
&gt;&nbsp; out_deallocate_doorbell:<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/a=
md/amdkfd/kfd_priv.h<br>
&gt; index 88191a4c1657..1f728f13813e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; @@ -637,6 +637,15 @@ struct queue {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_cpu_ptr;<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo_ga=
rt;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* system-RAM shadow of a VRAM-resident MQD =
(+ control stack)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for hibernation snapshot/restore<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; void *mqd_backup;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; void *ctl_stack_backup;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mqd_backup_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ctl_stack_backup_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool mqd_backup_valid;<br>
&gt;&nbsp; };<br>
&gt;&nbsp;<br>
&gt;&nbsp; enum KFD_MQD_TYPE {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_queue.c<br>
&gt; index 98a5512b701b..cbc90bf87792 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<br>
&gt; @@ -83,6 +83,8 @@ int init_queue(struct queue **q, const struct queue_=
properties *properties)<br>
&gt;&nbsp;<br>
&gt;&nbsp; void uninit_queue(struct queue *q)<br>
&gt;&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;mqd_backup);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;ctl_stack_backup);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(q);<br>
&gt;&nbsp; }<br>
&gt;&nbsp;<br>
<br>
</div>
</body>
</html>

--_000_SA1PR12MB7343FE954902BF06C7996A90EBC22SA1PR12MB7343namp_--
