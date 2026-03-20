Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F4DFB5EA9
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 04:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C94910E89C;
	Fri, 20 Mar 2026 04:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DI7WYLTr";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013051.outbound.protection.outlook.com
 [40.93.196.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EC7410E89C
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 04:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqynbSfs9xNNRwAkUUDjft4YLc/Xv3W6o+Z5JMXnCJRrjbr6fGJU96ZR7z/QPQhsuXzdkCRez7m/bXZ/bjnPPRpfE9P4g0kZ5mw1A2W9O0NOX/vDsbvDh2BJQKp8C8wcgp0KYNjfQ3OoOmX+4faguBS6rBDUUv4Uqv/Xes84VjytEth8FHZHjynEcvVPuY/2mQQGevK9n3UftP78NtgHJhhRWG1JOnfavxz17BBPP6Aauj/VMcWMsTXljePOOMaT8ZIDgQFhQ3j36UUXGGX/ozSKh1Qjba3rilZGm/1piCcqspbrm03IBFbZ1ogsj07YZhI2urdKZVUQtZ4Cdj89jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvg3U1I0s9t/v9LlZqW4wugMYP4DL5jBGAMDmg+6jK8=;
 b=BdI8oMYL7hcM017a4GHcvwsSMfAIlAyGnWl3ciE1cH/Bo8fD2rKSmi1qsCfhD6Gh2zBT8aU3Zl862KdZWnSSbj8ctyssWbQW6otxXut+OsdzuzvxxAMr7Yv9W1/viHkhVTUQuZogNYZlY8ZSGm0lpgBrE5jYbb5ShoTlPN75f2C3+pBTs8+3rdvIQcoHcBqx8rKjJKALnDILFj37Z8gfdD1TVdnWDShtvlHLfrLhDNGnRHOpo1KDk0dnzkaPP+i+jlyLc8Y/P0gEIi3Wlht1/UjbWM4l11xdncpCoQW9KBplgNtnl/5iYwzbTAXFJuxtx9WeetPKY00XX3xb7ychbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvg3U1I0s9t/v9LlZqW4wugMYP4DL5jBGAMDmg+6jK8=;
 b=DI7WYLTrE93nEA7xjHtFLiHJg6jioBuKl2w6MLIK56j39hjrytMuTAmlDbcK2oxACeQF1F09n0DqVc6zhXoqGc7ZR39BaF/k+ISL9kNAreWg/81INJfluElYsdObhu7Xsquz5UbqxKD/IF4yqhJo3HXZDH/qOk4Bw0Yh7vkm8nQ=
Received: from PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Fri, 20 Mar
 2026 04:14:06 +0000
Received: from PH7PR12MB6633.namprd12.prod.outlook.com
 ([fe80::fbd5:79fe:588c:41c3]) by PH7PR12MB6633.namprd12.prod.outlook.com
 ([fe80::fbd5:79fe:588c:41c3%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 04:14:05 +0000
From: "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, =?Windows-1252?Q?Michel_D=E4nzer?=
 <michel.daenzer@mailbox.org>, "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Olsak, Marek" <Marek.Olsak@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation"
Thread-Topic: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation"
Thread-Index: AQHctq0tde2MDjjZ2kW1JaItaybTorWz802AgAATn4CAAAHhAIABG2YAgAAwkJOAABCwAIAAEdmAgAA2vQCAAQrWAIAAFqt3
Date: Fri, 20 Mar 2026 04:14:05 +0000
Message-ID: <PH7PR12MB6633017F95D0FB898F1411A9FF4CA@PH7PR12MB6633.namprd12.prod.outlook.com>
References: <20260318074708.2078535-1-sunil.khatri@amd.com>
 <dfca1bb0-26dd-45bd-ac11-c3756ce808ac@amd.com>
 <48df3b31-724a-4548-a52b-9f034664d422@amd.com>
 <DM4PR12MB5152791EDD4F7021198821E3E34EA@DM4PR12MB5152.namprd12.prod.outlook.com>
 <2e6d0e34-e093-41a9-a4b3-59afe3050dfc@amd.com>
 <PH7PR12MB6000DAD5B8EFDBCB3F3F4663FB4FA@PH7PR12MB6000.namprd12.prod.outlook.com>
 <PH7PR12MB6633BABDE8B0785EF6ADA694FF4FA@PH7PR12MB6633.namprd12.prod.outlook.com>
 <PH7PR12MB6000366C1E6582CD02D90AD6FB4FA@PH7PR12MB6000.namprd12.prod.outlook.com>
 <74e768dc-d4a1-445b-b699-e837a1d20234@amd.com>
 <f6526ba3-91a0-4407-94f6-a34176587b40@mailbox.org>
 <MN0PR12MB6004462D78DC45C7B45B0E10FB4CA@MN0PR12MB6004.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6004462D78DC45C7B45B0E10FB4CA@MN0PR12MB6004.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Prike.Liang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-20T04:14:05.104Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=1;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6633:EE_|SJ1PR12MB6145:EE_
x-ms-office365-filtering-correlation-id: 4e510c37-76e8-4560-b92a-08de86372057
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|921020|13003099007|38070700021|7053199007|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: X+8XbmS/gQ1mZB9LeLkF0lGsMLr4Mcy/gnU0MrzcfaxrN09ZmAb1GAMIkWVQQjiZgwd1KU1JXNEhyuEviI9zFmW8ETihLVequGakV1+HoW614OA8X+nTyoIn06DwZn1FdlmbrXfRijjvnkIG3CS+uJ98Arf5vaSKccD/Uf6n1dXUDdSDbbKfSABVHqhs5bwZK8n+L07z3m0PYIDp/CywoDxykdNEvdIiFftW0sXTeIvC4RuILm2SHrJs3TZrW18T+mmb5cnxwR25DkBtzK8HZJfsrXMiDSlIpfJdeHLic9t2DUH8r3RgDQQtJBoGT0xKYN0c1u9qQwVj3sYr4daImClA+NbNfDY0yasME72gVjW3kmfg/BghuWQkbHmQ8paxvi3H0JqGz6P/wy7NA62DRF2D8Q6vCPU4vdTRwAuNHuTKBw/2SFyy409ZXbaiCMbEyaodQOqrOCZ5GGIWPdn7QuxDmEmPFRwMW9x7SeMmq0jD70Vila6+S7PeyrQ27Uthd9aEh5f7vRFByMGc6OMg/bYTObEbqtCfyzaW1vGk6Be3o2GPLAmjah60BRdFnGdt7eyovh3wM5vDRIOb6ymURtvGq/d31HhflLMtNhguPzHo08917oA/baM6VeHRO1O1iSDEq+gK6YUSBwwlfCZixnpH3mEhTqqertV0rnSJS4DaXfNjT7ZS0X+K8P3mWseEO54zrZJcHwyCS/g/mr+Ebi3TSSgyF0INEc++CuORaoTl4/Q0Det1Rs3MGzC9Gy79
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6633.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(921020)(13003099007)(38070700021)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?qWv0rJU53gQvSduFms7vnG2Y36EeywsW6IUe/tWfjMSW+YEpAwaj0Jd7?=
 =?Windows-1252?Q?2EIn2ytBPFo6nh4U4C6NecsLRMh3QAFEcN5vG1lUL46dvkXlhzGY1EJR?=
 =?Windows-1252?Q?9rdAA53s4ehhhy48ZrJluRg9PthznfgijeN9AGMTFwDV09tTw235mrlX?=
 =?Windows-1252?Q?bDzfDiX9mxmPSNropKaeuYJfwdPgHayiGAuULeI51938ujAW5OWABMy4?=
 =?Windows-1252?Q?PQ7LBuz+bbJA5gsYafsNUI3a7lWGMQcB1rzL5U5YQ5u6eYmQIzeCC/74?=
 =?Windows-1252?Q?tkuuU7QaAm0I/0ClU/Lkzm5j7N0KoJA8TTgIQ+RFxBzQtfflASkKpGbT?=
 =?Windows-1252?Q?x5xwma85ZoNwiqgjPcabSCSCk/hg4m6SNHZJHt3k7y5f7F3LIY9qCIbn?=
 =?Windows-1252?Q?/raSejhaWFPqf1bBu4L4mCz3nM8U1bi5MwRxKdjity+Ha37JpSjQZJCG?=
 =?Windows-1252?Q?SrygWExg3VEQGCOT3IlDujucxBtel+nKChpWmeWX3m17a840kN+VtUz0?=
 =?Windows-1252?Q?Yf/zHNjNaAyD/5UAmYh6EUbFZyJM81zhUmvwqy0OuTagXD4iup3/nSNc?=
 =?Windows-1252?Q?E6cWL3GUVijZVKcEFD1x5tQM6hSdO5fLS8yxtO3tykSMlg+Ct2wVzzar?=
 =?Windows-1252?Q?6kkN+rSMXuppKgAKytSDYZRv10m/TYrAVngmb0Hzy9G5eADbg7TPiSQa?=
 =?Windows-1252?Q?KySx1C4r8GxPsAR9d393wsnZDmb/00Sfince+SstZW0GFARCj5uo2vvt?=
 =?Windows-1252?Q?15hAPbfD7desQ1alIXuAH4hr1m1sOcCTrmyiloBw8GCV0rMpEh61G5WQ?=
 =?Windows-1252?Q?atOOXnJ8dsvA18hz7F4WG1YKUNj2ZEcgQxQkdioRiYHwrV6CCLJYruuy?=
 =?Windows-1252?Q?gotoRk1DeUoqqgA5IDgYdiNt88JbsnwRSBvd0mBaI2QEqlSrjaIjl/J8?=
 =?Windows-1252?Q?cGB1mT1ZwA+bjZRzMqWjzpK3bxeixhjZT+62YMshpM6b52rYHoDjoB65?=
 =?Windows-1252?Q?fR5GhZam/mMbV4JlYostcgKH0paijTjjxSs8obRf8Ct/ZBghSxBw22IF?=
 =?Windows-1252?Q?PdsFvXd+tjTmm1yGkUBTRQv+ziGrNyOsxSNGdwXmrvFXKO6tDDldqvLa?=
 =?Windows-1252?Q?draDhM9UvfwWyD1EaluVz7xh17axCu+UWbCeLc1LGhdDkxIl188N+ThR?=
 =?Windows-1252?Q?3OgY8eH6DvufuYWqk/BroCMvaT8HesEXV2MHYYx7ldufpAAAPi6NuxN0?=
 =?Windows-1252?Q?I2i8Kl5PT0MmwGYgUvTe2KUIf0Ou+LhMUoRsAgemTRQ/42KgLy34pRzu?=
 =?Windows-1252?Q?NlfcBvXAtNMI7g1oXiDMoPf+FxtRXUVnfpQkSvS8mP6QuPxIl/CSU+gn?=
 =?Windows-1252?Q?SCuZQrlsqQcCoKo/zxd7J9SUaec+pBhubuw0/Vm9PqCk0lka/qGGA/JT?=
 =?Windows-1252?Q?R7m49hdS0YFTamwflbaaqTP314Zo01mDdj1H1Vz1tqOSo5KkkmfQ1kry?=
 =?Windows-1252?Q?FwEwtl0eExx35TIo2BOw6+svYNp9ghvBuPrRi/qKKiHY1Z5pgOLuZDn6?=
 =?Windows-1252?Q?mQCeBaoDid1/ZZT0VLnzEC4ZCy7FlWhvhihNVD97IbqRgUg12V7h3U6N?=
 =?Windows-1252?Q?pXDkleKIs4dq7kFfX5b5PJNRcdnk+nVXJ187GS2IqTfC8fJvBveoUlKS?=
 =?Windows-1252?Q?7/MvQ9uKaQrPGz3NGNxAVYNmN4/qN32xDDG3gq9ynsIB8VjUhQSpjGxw?=
 =?Windows-1252?Q?civWjagFFe+r6ORiuh0uqlkIW73iTshUXSK1CQwvI6MF0q7vP7W5Hy9v?=
 =?Windows-1252?Q?9rsgmrKjRZRi2f6bCJxc3B2ed6eiPlvtCnzfubER8jdTnKTp?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB6633017F95D0FB898F1411A9FF4CAPH7PR12MB6633namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6633.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e510c37-76e8-4560-b92a-08de86372057
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 04:14:05.7002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tTzf6dAMoLT0mVStniW5KRgTlmADCyB8Et1jd33YTMtkVbZg8s4ZqSrhtIDEzULX9QjlQssfwtqF5wejnlY28Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145
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

--_000_PH7PR12MB6633017F95D0FB898F1411A9FF4CAPH7PR12MB6633namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi,

I studied the documentation at https://docs.kernel.org/process/botching-up-=
ioctls.html

In this case there is size and a pointer, so it is not strictly required. B=
ut good to follow coding guidelines.

@Liang, Prike<mailto:Prike.Liang@amd.com> your proposed changes looks good.

Thank you,
Yogesh

________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Friday, March 20, 2026 8:11 AM
To: Michel D=E4nzer <michel.daenzer@mailbox.org>; Koenig, Christian <Christ=
ian.Koenig@amd.com>; Mohan Marimuthu, Yogesh <Yogesh.Mohanmarimuthu@amd.com=
>; Khatri, Sunil <Sunil.Khatri@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd=
.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Olsak, Marek <Marek.=
Olsak@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument =
validation"

[Public]

Yes, in this case it=92s cleaner and more robust to not allocate at all whe=
n num =3D=3D 0, and keep the pointer as NULL.
For the mesa driver, how about use the following allocation pattern?

unsigned num_syncobj_dependencies =3D csc->syncobj_dependencies.num;
uint32_t *syncobj_dependencies_list =3D NULL;
if (num_syncobj_dependencies > 0) {
    syncobj_dependencies_list =3D
        alloca(num_syncobj_dependencies * sizeof(uint32_t));
    /* fill the buffer */
}

Regards,
      Prike

> -----Original Message-----
> From: Michel D=E4nzer <michel.daenzer@mailbox.org>
> Sent: Thursday, March 19, 2026 6:47 PM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>; Mohan Marimuthu, Yogesh
> <Yogesh.Mohanmarimuthu@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>;
> Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Olsak, Marek <Marek.Olsak@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argumen=
t
> validation"
>
> On 3/19/26 08:30, Christian K=F6nig wrote:
> > Hi guys,
> >
> > well when mesa leaves some fields in the structure uninitialized then t=
hat is a
> pretty bad idea and we should eventually fix that.
> >
> > But always setting the pointers to valid arrays and just setting the nu=
mber of array
> elements to zero is perfectly valid.
> >
> > That doesn't even needs a debug message.
>
> As discussed recently for another patch, the "(How to avoid) Botching up =
ioctls"
> page of the kernel documentation says under Basics:
>
> * Check all unused fields and flags and all the padding for whether it=92=
s 0, and reject
> the ioctl if that=92s not the case.
>
> That seems to apply here, i.e. the kernel should have these checks and Me=
sa should
> initialize the pointer field to 0 when the corresponding num_* field is.
>
>
> P.S. I agree it probably doesn't make a practical difference in this spec=
ific case. I
> suspect the rule is aimed at when the ioctl struct is extended, in which =
case Mesa's
> current behaviour would be indistinguishable from user-space code which a=
ctually
> doesn't properly initialize the newly-added fields.
>
> It seems safer to stick to the rule even in cases like this where it's no=
t strictly
> required.
>
>
> --
> Earthling Michel D=E4nzer       \        GNOME / Xwayland / Mesa develope=
r
> https://redhat.com             \               Libre software enthusiast

--_000_PH7PR12MB6633017F95D0FB898F1411A9FF4CAPH7PR12MB6633namp_
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
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 128, 0)=
; margin-left: 5pt; font-size: 10pt;">
[Public]</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I studied the documentation at <a class=3D"OWAAutoLink" id=3D"OWAa8a90965-9=
aee-95ce-cc84-ba1df97f477d" href=3D"https://docs.kernel.org/process/botchin=
g-up-ioctls.html">
https://docs.kernel.org/process/botching-up-ioctls.html</a></div>
<div id=3D"appendonsend"></div>
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"><br=
>
</span>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
In this case there is size and a pointer, so it is not strictly required. B=
ut good to follow coding guidelines.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<a class=3D"tWKOu mention ms-bgc-nlr ms-fcl-b" id=3D"OWAAM929495" href=3D"m=
ailto:Prike.Liang@amd.com">@Liang, Prike</a>&nbsp;your proposed changes loo=
ks good.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thank you,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Yogesh</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Friday, March 20, 2026 8:11 AM<br>
<b>To:</b>&nbsp;Michel D=E4nzer &lt;michel.daenzer@mailbox.org&gt;; Koenig,=
 Christian &lt;Christian.Koenig@amd.com&gt;; Mohan Marimuthu, Yogesh &lt;Yo=
gesh.Mohanmarimuthu@amd.com&gt;; Khatri, Sunil &lt;Sunil.Khatri@amd.com&gt;=
; Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&gt;; Deucher, Alexander &lt;Ale=
xander.Deucher@amd.com&gt;;
 Olsak, Marek &lt;Marek.Olsak@amd.com&gt;<br>
<b>Cc:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Subject:</b>&nbsp;RE: [PATCH] Revert &quot;drm/amdgpu: harden SIGNAL/WAI=
T ioctl argument validation&quot;
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: &quot;Times New Roman&quot;; font-size: 12pt;"><=
a name=3D"BM_BEGIN"></a></div>
<div style=3D"font-family: &quot;Times New Roman&quot;; font-size: 11pt;">[=
Public]<br>
<br>
Yes, in this case it=92s cleaner and more robust to not allocate at all whe=
n num =3D=3D 0, and keep the pointer as NULL.<br>
For the mesa driver, how about use the following allocation pattern?<br>
<br>
unsigned num_syncobj_dependencies =3D csc-&gt;syncobj_dependencies.num;<br>
uint32_t *syncobj_dependencies_list =3D NULL;<br>
if (num_syncobj_dependencies &gt; 0) {<br>
&nbsp;&nbsp;&nbsp; syncobj_dependencies_list =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloca(num_syncobj_dependencies =
* sizeof(uint32_t));<br>
&nbsp;&nbsp;&nbsp; /* fill the buffer */<br>
}<br>
<br>
Regards,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Prike<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Michel D=E4nzer &lt;michel.daenzer@mailbox.org&gt;<br>
&gt; Sent: Thursday, March 19, 2026 6:47 PM<br>
&gt; To: Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Liang, Prike<b=
r>
&gt; &lt;Prike.Liang@amd.com&gt;; Mohan Marimuthu, Yogesh<br>
&gt; &lt;Yogesh.Mohanmarimuthu@amd.com&gt;; Khatri, Sunil &lt;Sunil.Khatri@=
amd.com&gt;;<br>
&gt; Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&gt;; Deucher, Alexander<br>
&gt; &lt;Alexander.Deucher@amd.com&gt;; Olsak, Marek &lt;Marek.Olsak@amd.co=
m&gt;<br>
&gt; Cc: amd-gfx@lists.freedesktop.org<br>
&gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu: harden SIGNAL/WAIT ioctl=
 argument<br>
&gt; validation&quot;<br>
&gt;<br>
&gt; On 3/19/26 08:30, Christian K=F6nig wrote:<br>
&gt; &gt; Hi guys,<br>
&gt; &gt;<br>
&gt; &gt; well when mesa leaves some fields in the structure uninitialized =
then that is a<br>
&gt; pretty bad idea and we should eventually fix that.<br>
&gt; &gt;<br>
&gt; &gt; But always setting the pointers to valid arrays and just setting =
the number of array<br>
&gt; elements to zero is perfectly valid.<br>
&gt; &gt;<br>
&gt; &gt; That doesn't even needs a debug message.<br>
&gt;<br>
&gt; As discussed recently for another patch, the &quot;(How to avoid) Botc=
hing up ioctls&quot;<br>
&gt; page of the kernel documentation says under Basics:<br>
&gt;<br>
&gt; * Check all unused fields and flags and all the padding for whether it=
=92s 0, and reject<br>
&gt; the ioctl if that=92s not the case.<br>
&gt;<br>
&gt; That seems to apply here, i.e. the kernel should have these checks and=
 Mesa should<br>
&gt; initialize the pointer field to 0 when the corresponding num_* field i=
s.<br>
&gt;<br>
&gt;<br>
&gt; P.S. I agree it probably doesn't make a practical difference in this s=
pecific case. I<br>
&gt; suspect the rule is aimed at when the ioctl struct is extended, in whi=
ch case Mesa's<br>
&gt; current behaviour would be indistinguishable from user-space code whic=
h actually<br>
&gt; doesn't properly initialize the newly-added fields.<br>
&gt;<br>
&gt; It seems safer to stick to the rule even in cases like this where it's=
 not strictly<br>
&gt; required.<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GNOME / Xwayland / Mesa developer<br>
&gt; <a data-auth=3D"NotApplicable" class=3D"OWAAutoLink" id=3D"OWA48716f8e=
-d1e0-a6a5-4192-1a85d4577e36" href=3D"https://redhat.com">
https://redhat.com</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; \&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Libre software enthusiast<br>
</div>
</body>
</html>

--_000_PH7PR12MB6633017F95D0FB898F1411A9FF4CAPH7PR12MB6633namp_--
