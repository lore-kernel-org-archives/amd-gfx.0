Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96891D232E9
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 07:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2972C10E348;
	Fri,  9 Jan 2026 07:13:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NDHPwdtb";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF7E710E348
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 07:13:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cU41vYV+qkE4+fwoy6+U6QPbM+gY44sI5QJ9TN45KOeuF1dV6+v/1kgKRvpsF43jCQTMSh50x4BpNVCx83hYIYaqRBLnHWTXz6J0B5gy8jl0wJ+8aVwnRdrnbPZR7NM1TEP0gQ5wSoirVd9Hze9x5ylc8T+nX5l5MCUsQHc/4XoZe3ACo4b0NbGCrH6GZGiJC2tvaHloVs9ZM6uNgzbfP3813Sh3lCyQL5GHIz707iQ8EhBL5EAvjc9vIx0iabYLBbuTUzpP/mQkaGjUJ1VifteSXXPx7JVupNTVGpoFh7zvdRmoQk2cCmo5Ejjx9nUqaNUkjrsSmr7t6GecdfpmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=He1AM71OXmE1nU5x0A+4O5BIofv2hfyCUZugIBGn+F8=;
 b=yzIcWIrwMLpdxyL6OgEFQ9TcJY8fJTY7+Ku4ddk26qu/pQR1ro9+uupWTwJ/L52+Y4wK0iS5KbhpN5qrTBbRGFY3MClMNG9xB1nCGrPxqkzW0c8Sc9TbxOvU39WbqDtFd+xZBWukcO2CPMjW/3BueN5RP8WSeX4w+tkV5ACBgzFhCdN2eW2vfzCMH4x9h8bP6KPARFwEEf0X1cYa91OZFRrWBylvMjI/OLhXjK0FHFnmYzsly/TZIcpDt7js75Gni8skrrKpLiICxn209WeTi2DQIcnjf/6YVwnxmKyyrTq6sQkBbeSnlKdl3ES7SR/n8PAC8x+UGQPfmK15Ntn9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=He1AM71OXmE1nU5x0A+4O5BIofv2hfyCUZugIBGn+F8=;
 b=NDHPwdtbQuwhyqo2HX4r1zcevl+pjmu3kzU1McKlDQQvfgu+Oa1Z+if5+Yk4acH+ECYfJbI3X9h/5xbjYOGqazxbGnnK3iuNAPthRRx2GXVbk1DC/uD3P4DdMxLxY7kJQkJRYLZpt6//X1YpeajySv2aEitEF4BjHiqueNjzHvQ=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by SJ0PR12MB8115.namprd12.prod.outlook.com (2603:10b6:a03:4e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 07:13:33 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::2f1e:82be:7d62:8457]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::2f1e:82be:7d62:8457%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 07:13:32 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Li,
 Chong(Alan)" <Chong.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdgpu: reduce the full gpu access time in
 amdgpu_device_init.
Thread-Topic: [PATCH] drm/amdgpu: reduce the full gpu access time in
 amdgpu_device_init.
Thread-Index: AQHcV4zXbEENLA91eU+SKQmzJnk2e7VF7CuAgAPSYWA=
Date: Fri, 9 Jan 2026 07:13:32 +0000
Message-ID: <PH0PR12MB5417D01ED80C54AAD0B107288F82A@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20251117063821.3434458-1-chongli2@amd.com>
 <e950970b-2e2e-4151-82d9-928a1787308f@amd.com>
In-Reply-To: <e950970b-2e2e-4151-82d9-928a1787308f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-06T20:47:13.1550000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|SJ0PR12MB8115:EE_
x-ms-office365-filtering-correlation-id: a091be30-45fa-482c-73dd-08de4f4e991d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+emCx2j19VO4a827LUBickZuofwjgG6tSGBW5xzk+EFE/7j/7eNFrHDnpH4b?=
 =?us-ascii?Q?66wZro9Xj5NNg+iqxO2u9+c+FGm9h8rN7nPaUCBHNFeF6v1iDtCk+ARvIgSq?=
 =?us-ascii?Q?bWoudWmxh1rF4grml9KVYjDt6+1TPV9p1dg44g7j9m8t5zJ3YTck70imnIWN?=
 =?us-ascii?Q?TnL+ITF/HUBzswIETTYl9Zl76CCtS2F/E2hz0nYbQBQ+aDKq0QS1gaNJpWk2?=
 =?us-ascii?Q?/2zULkczjBiibLzpyOHsee4DLcHV4veEwqZo8qsxha7ZfN8z2yh+KS0PL6ew?=
 =?us-ascii?Q?fi7wsCnm7aZE0K57WahRNH9gmNo4YGrNbw5VAiaUpQTgmaS3qCy7N0+CoZLB?=
 =?us-ascii?Q?b15un/eKAtDxjmGT+vHzhTc7/mKrA7PLnD8Ge67C5kqPNk3fR+5UtP2kRKkn?=
 =?us-ascii?Q?X3tb4LY7AWe36MKx+wj9CQMa6OTqjpmx/qd1Y2fNIYv+TjsMiVSpF8rCdpAS?=
 =?us-ascii?Q?ufN2SDFoSZaV8mbCOn37AudPKCFK0T4UBNWZiu4nMNTEsQTYzjj+ZKR7LcQD?=
 =?us-ascii?Q?ZvMeRCP/LMMsBI/fUQPikDtifuiKMRhpIyZO2dGECYldc8RP7TGjoG6+A+hu?=
 =?us-ascii?Q?/3oiWmXn5+Hq2/gZSkPr6G0KnbXXpN+JRnxvYebOpk5xGX2AyiBMsnrsI8xM?=
 =?us-ascii?Q?JyYU3Sn2+dPyQieAjDwf1lMQNY+6q5z5XQ5hKGW0cm/6D+Z3tgG1npt99jEA?=
 =?us-ascii?Q?bYNiKe1aSVDblNG6Uzi828b+XmcXWgOcq4Zg9kGoTe/ECCJ/YVyNnRys+whb?=
 =?us-ascii?Q?nkuWsQ1Zvu6xw6vDyfqEq/LyIRMXgfOivdugI0Q+fMK/vBA1z2ugeH0T1iOe?=
 =?us-ascii?Q?K6mkaNLtPxe0Yu+EAnkEc5FscGJLISWVs9YqvJchNszXz+rTuxfY0srhJ6GZ?=
 =?us-ascii?Q?VGKAk9gDyA/jMT6dns4bGQ928jz+EXn7Z7NHESr9xOIQuJtd3DyMG5yYkK9V?=
 =?us-ascii?Q?QPWl7CNjBwxt35BoK4O3eVpi80Kz70l8vzAxORQeS32jKDSeVOSfQOitDarS?=
 =?us-ascii?Q?Ufr9Gp3MgxIpSo6ju0VFp4wbw9f08YCWA0uze9IkTS6WCj5sDPNcAdu9J/Hr?=
 =?us-ascii?Q?Mfy8MGnNeAVnIW3T2nWrr00rz/+ORHcLhg5Oagpzw0O22ShW1LsR6gjl9Q8U?=
 =?us-ascii?Q?0untHw/JZ5ZIobK37D2sg+B1zX+h3h2iVE/HBUT5byLAhGAtWy2JTlzZNkJM?=
 =?us-ascii?Q?+ODWUTs6/mC9H0k18GsjAOgq0TDTX1HEiN0xKxIJ2wzSygHn2D4OLi239tgp?=
 =?us-ascii?Q?AjoRFEw57oYULUE3zsjxnZp2VfUFzBj4k3cmKoFiLWKujFxx+eRWEPkq5twu?=
 =?us-ascii?Q?QRHk5ozpn8MPZHcHx+30hv9mQnYhED6hRht2nS5auwyhCFXoUCeHmWWpGQ2o?=
 =?us-ascii?Q?IZD+CjMa9eELHDkrLwrjPUF2mUO5JFzNHh6jxO1MiT3/QP3MtrAKzuZnTBb6?=
 =?us-ascii?Q?WCTy3waxn/fcbBBTg9kMAWWMxhF1nMQvnPjDpPGzofC4131PDHBfmXJBt59F?=
 =?us-ascii?Q?m1s2PnwNm+wO5/CqAZQ0/1Q9jDXFH/sfq6NI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WbONw/TOJCMgq4pFc/3YamDsmwPkmggM+rvjsV/Qqq3Lu9hq9UvfnX6u7meA?=
 =?us-ascii?Q?jdclX1qQ3mJJbhH3pb3yVCC6f84O+O6F4mH3FJOugXcBWbkk5LNfltNicqZB?=
 =?us-ascii?Q?CE+WsQjUm6DOWUrj8grGP4Cg6tHV7Iu15ekZxSokhrx0NjlXy2PZlAQip49m?=
 =?us-ascii?Q?hQA8Ld6r8xE74jNdxuBNQw4ewAt6WL1CUfTrWBCDbnzT276keJbLE/ujCC32?=
 =?us-ascii?Q?P5zzZoatkwOrcNRvBO/WFcPdRAo+P9Ktj1iAFe+9UD5SvFqTMGJd+Hutfe2K?=
 =?us-ascii?Q?OTFGAI4cISDMF9tZLuS8qmuPQQPW1W2NIaJa3pFZiYLhAlHIydcqIdUj+P46?=
 =?us-ascii?Q?cMtuLtsrOYag1LOOz9SdcS/d0t+1ZeaaRpVv6JD+bVQWWYEYalj7o3O+Bzj+?=
 =?us-ascii?Q?rMNnG6X6HkQ8Kr+M9cN1GWEACIB/efSuCuu17R1ZLZtNiZEcHjgivxhlxoTo?=
 =?us-ascii?Q?v+9BuuK3+ksfULVj+GeLlQjCyEUi2qj6iSARf4Ijeh7PSb6zupZ4jyt9vIok?=
 =?us-ascii?Q?pHvs/5uVP/PpoyUfZCp7Z7v/35x167jldSXZdxWu3iPZ2IfcQqoBMqWpMZbB?=
 =?us-ascii?Q?pOhAkbzUNY4panZiLbBHioS62D522wrC7dlIgs5hRXQS/Kzk2axR33Tvo/xD?=
 =?us-ascii?Q?M4ZXJ2koo+F+QxqbfZhyysLM7nhTkPSFheplV5z7jId+6PLtMAJX4DhN4TDh?=
 =?us-ascii?Q?OEK7ZyBJiJ4B4qyIxRpG0nkqyon1AkBXghWzJMqveGthi+k288M4l2AqUB/9?=
 =?us-ascii?Q?tEf5eaiLkCX6TfKQ5dX/wZwTCeGQQz6mkhNfVliUjMNy/FzRe7tTTlTS+aLw?=
 =?us-ascii?Q?yY//QC1VJWlmlYigBBcK3sQlMszge1EESY9mHYRneN4R9JAHYK6n1D3CktAE?=
 =?us-ascii?Q?X1NPtQcF6KPnIuTdqLfjy+rXRdshiVt+fXPzGXZ7R7FCR0xqLA1mQh9GAXlB?=
 =?us-ascii?Q?44T6mBF3XuaJu4MX8WHJWMVH/6MUYp+gT7AA3xxQG5XKmIZ211vLb2DKqbWj?=
 =?us-ascii?Q?HIHBeMPah6ELRoWC8CRDCL8IS90sZS8x0MrPmF39n5xlg149KVXjTMqlnYz8?=
 =?us-ascii?Q?m7OhQW8eccKx+0eR4yqa/5AbPLdKxt0v9KCiMKR0wZPB5ORoWXI3IqrKfK/J?=
 =?us-ascii?Q?0GO4iLeIU1mb21Qrso9wTGRXikZaoCfCRr2tmkxwNhf8p2gNmU4ulWf+qZs8?=
 =?us-ascii?Q?zzAgq2FEAc6/JOcxoSAM53E9pOxh8scToBVgNPKxc5FJRTRKbs3Go8jPKwUq?=
 =?us-ascii?Q?Gi8/wZlL7vepk6x9yg5r94hs4HJG5JaDuYLevLYX3EN1NCs2g/LQkP8x6lG0?=
 =?us-ascii?Q?G3iGJpg/t6nsXN+sxqHOOMTSvcRcVyJlpNpDbil/u6a3Hx2YO91IbwOPRKnp?=
 =?us-ascii?Q?TE96CLnJ58iivLRBT5xcs5kXvfCFDfYP9GrN1xREwss3a0MMVdAu4LzlcJdp?=
 =?us-ascii?Q?s7OiAVq+FwQQ8RoWj+DLWGJKvWSAuy+Gv7JmhW5Ncr36G+O7ZE9iqvqqB/vh?=
 =?us-ascii?Q?esJq9sM038ujGdeGMtEoC2dG+xj2mIOAODbTLkBPP00ktUiHX0BAmAl0N4+x?=
 =?us-ascii?Q?r9hDAihS/IrqF+goFPWqZNIh6T0g+OJnlY6p6dQFzwYGvxxu4ML8wtpPjj9u?=
 =?us-ascii?Q?C6yujKxYuIo2UzRLBIYTrT1Tb5nhQ+FEcw6zVIcuv8F9By/9pcQQLkWIvkd4?=
 =?us-ascii?Q?0mXsmAXe191h4OIgF5vBIZF+gZKSqeVgp9PaRuUCJ7dyIDa2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a091be30-45fa-482c-73dd-08de4f4e991d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 07:13:32.7865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsxXQhwr4XYekvtPVrz1XaNbzjc/LYILSDBuMlcplEBCltGatrwmh0ZNa+hU8Sxm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8115
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

Hi Harish,
     Operations within full access mode are hardware-related and require ex=
clusive GPU ownership. Software-related operations, particularly those that=
 are time-consuming, must not be placed inside full access mode, as this wo=
uld impact other VFs by blocking their access to the GPU.

Emily Deng
Best Wishes

>-----Original Message-----
>From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>Sent: Wednesday, January 7, 2026 4:47 AM
>To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>;
>Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.co=
m>
>Subject: Re: [PATCH] drm/amdgpu: reduce the full gpu access time in
>amdgpu_device_init.
>
>Hi Alan,
>
>Based on your older patches, I understand that this patch is required beca=
use host
>(gim) driver assuemes guest driver is available within 3s. I am not sure h=
ow the 3s
>timeout was decided. I feel better approach should be a more robust handsh=
ake
>between guest and host driver. You might be able to temporarily get away b=
y
>rearranging the initialization code but that could break easily if some ot=
her change in
>future causes a delay.
>
>Best Regards,
>Harish
>
>
>On 2025-11-17 01:38, chong li wrote:
>> [Why]
>> function "devm_memremap_pages" in function "kgd2kfd_init_zone_device",
>> sometimes cost too much time.
>>
>> [How]
>> move the function "kgd2kfd_init_zone_device"
>> after release full gpu access(amdgpu_virt_release_full_gpu).
>>
>> v2:
>> improve the coding style.
>>
>> Signed-off-by: chong li <chongli2@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 +-
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 +++++++-
>> drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 23 ++++++++++++++++++++++
>> drivers/gpu/drm/amd/amdkfd/kfd_topology.h  |  6 ++++++
>>  4 files changed, 37 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index 40c46e6c8898..6d204ba2c267 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -37,7 +37,7 @@
>>  #include "amdgpu_sync.h"
>>  #include "amdgpu_vm.h"
>>  #include "amdgpu_xcp.h"
>> -
>> +#include "kfd_topology.h"
>>  extern uint64_t amdgpu_amdkfd_total_mem_size;
>>
>>  enum TLB_FLUSH_TYPE {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 0b40ddcb8ba1..b4e1f258119c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3333,7 +3333,6 @@ static int amdgpu_device_ip_init(struct
>> amdgpu_device *adev)
>>
>>      /* Don't init kfd if whole hive need to be reset during init */
>>      if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
>> -            kgd2kfd_init_zone_device(adev);
>>              amdgpu_amdkfd_device_init(adev);
>>      }
>>
>> @@ -4931,6 +4930,13 @@ int amdgpu_device_init(struct amdgpu_device
>> *adev,
>>
>>      if (adev->init_lvl->level =3D=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
>>              amdgpu_xgmi_reset_on_init(adev);
>> +
>> +    /* Don't init kfd if whole hive need to be reset during init */
>> +    if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
>> +            kgd2kfd_init_zone_device(adev);
>> +            kfd_update_svm_support_properties(adev);
>> +    }
>> +
>>      /*
>>       * Place those sysfs registering after `late_init`. As some of thos=
e
>>       * operations performed in `late_init` might affect the sysfs diff
>> --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> index 8644039777b8..8511b00a7463 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> @@ -2475,3 +2475,26 @@ int kfd_debugfs_rls_by_device(struct seq_file
>> *m, void *data)  }
>>
>>  #endif
>> +
>> +void kfd_update_svm_support_properties(struct amdgpu_device *adev) {
>> +    struct kfd_topology_device *dev;
>> +    int ret;
>> +
>> +    down_write(&topology_lock);
>> +    list_for_each_entry(dev, &topology_device_list, list) {
>> +            if (!dev->gpu || dev->gpu->adev !=3D adev)
>> +                    continue;
>> +
>> +            if (KFD_IS_SVM_API_SUPPORTED(adev)) {
>> +                    dev->node_props.capability |=3D
>HSA_CAP_SVMAPI_SUPPORTED;
>> +                    ret =3D kfd_topology_update_sysfs();
>> +                    if (!ret)
>> +                            sys_props.generation_count++;
>> +                    else
>> +                            dev_err(adev->dev, "Failed to update SVM su=
pport
>properties. ret=3D%d\n", ret);
>> +            } else
>> +                    dev->node_props.capability &=3D
>~HSA_CAP_SVMAPI_SUPPORTED;
>> +    }
>> +    up_write(&topology_lock);
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>> index ab7a3bf1bdef..129b447fcf84 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>> @@ -202,4 +202,10 @@ struct kfd_topology_device *kfd_create_topology_dev=
ice(
>>              struct list_head *device_list);
>>  void kfd_release_topology_device_list(struct list_head *device_list);
>>
>> +#if IS_ENABLED(CONFIG_HSA_AMD)
>> +void kfd_update_svm_support_properties(struct amdgpu_device *adev);
>> +#else static inline void kfd_update_svm_support_properties(struct
>> +amdgpu_device *adev) {} #endif
>> +
>>  #endif /* __KFD_TOPOLOGY_H__ */

