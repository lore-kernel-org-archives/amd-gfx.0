Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE0A606A326
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 20:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=45jeRm4S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D426810E210;
	Mon,  2 Nov 2026 20:51:59 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9860210E105
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 20:51:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQtkUPC4SOAhj4blssH1ELtlSv5aN1U6AF1Qb+NKxFspy2QyqTHCYeF7Ssw7yjpDftooJufNhmIuof/ERumRLVNU4zbl40JTYX4vqX1vLP8qoGZiJMQT6sHMx8IN6q0KaxdZkYfn3NmNWc3Gm/+XOONg3vhubj8hdhRYpVtRqlLwATWib2tHrHHkkqctTDBsV0/jDbj8flG0cZEkxPln8OlFdtKcsZ7SY2YeU5x0W/C0Ayf3ucIRPz3eX0p6I5/dR4jVdqcsTQ2wvbWehVtBkRHpm28oyQiVjEjPtRV9/9YD0N4AKwDWpSrEbkrQtVk3lvtT7H/+QF42T6oGImzD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffboJEnebq/Cg2kcVvmAeLGbLDvl52gV61OBDukGI7s=;
 b=S+ZHed0/uWb6bfG7hnKOd/ov1g3uUBV88dPap3gdy9pXKfphr867TzeqCrHWpb02Nzb1ATjLhjK7ll8vT2pc0IyhosLrAuuh7o719mEDBA+sv9PUDvenixiekzFIjlDFNu0zHkhEsTWymfcFoqZQEXvpSijBR5h87YOvmlUYkfD70jRC649ClOi381XZ1iQc8Ln611nxOYAqwzH3SZ5v+cGT4PKYxFYfpMFelxmxaCjEkT0xsn+9JFha2byzCI3kboDvsM2D9WmqeEOHZVQ1qtIQh0OLb9++LjGoiZtQtr+7bf2KkNrNZWoK+cRfhzODfKTew//pay+r68lEpNMmeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffboJEnebq/Cg2kcVvmAeLGbLDvl52gV61OBDukGI7s=;
 b=45jeRm4SasN6TLbzY8jmrMV4Iuwa7mzQ1dpOHtK+TNT1lsetP74NySvptRBfJlXsaDjeLIWVNPMjRPDLGCy7RFf4VyAXVaZRfc1h1PP3fAA9Jtp1qu7X8+xEPYB8/SGWrLS1wVdVUvoEhg0N1vr/hqBGpFY9faTlKkSJIxJxGEQ=
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::7) by MN2PR12MB4469.namprd12.prod.outlook.com
 (2603:10b6:208:268::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 20:51:51 +0000
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74]) by CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 20:51:51 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH v2 1/3] drm/amdkfd: Acquire buffers in CRIU queue restore
 (again)
Thread-Topic: [PATCH v2 1/3] drm/amdkfd: Acquire buffers in CRIU queue restore
 (again)
Thread-Index: AQHdaHfUSRAEsvFx50uWjyFlJSUj9rcWlrWAgARHa4OAAF0UgIAAAaTAgAAEl4CAAABFJw==
Date: Mon, 2 Nov 2026 20:51:50 +0000
Message-ID: <CHAPR12MB999247430DC296A8BFA006B59EEF6A2@CHAPR12MB999247.namprd12.prod.outlook.com>
References: <20261030140550.2524662-1-David.Francis@amd.com>
 <20261030140550.2524662-2-David.Francis@amd.com>
 <bdbac10b-f1c5-4e3c-9e1d-7694b649c448@amd.com>
 <CHAPR12MB99924757FCFC078459155A971AEF6A2@CHAPR12MB999247.namprd12.prod.outlook.com>
 <3d5a7903-367b-42cc-958c-66ff65565194@amd.com>
 <CHAPR12MB999247AC90D109E731175BB99BEF6A2@CHAPR12MB999247.namprd12.prod.outlook.com>
 <77879b29-4676-432c-92d0-30b0d79712d6@amd.com>
In-Reply-To: <77879b29-4676-432c-92d0-30b0d79712d6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-02T20:51:50.482Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHAPR12MB999247:EE_|MN2PR12MB4469:EE_
x-ms-office365-filtering-correlation-id: f4cc3000-1a43-4e0a-732f-08df39231e98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|22082099003|18002099003|38070700021|56012099006|4143699003|11063799006|5023799004|261022075727099003|261021123027099003|261021121427099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261009223027099003|261022105027099003;
x-microsoft-antispam-message-info: vQN5EMeXUS7CRDXJ6sgf21GE5phPNC6qRT2mC5akMtUKglSLgFFU8t9e1QdVkM4dOZui1HE8amXvsH8r7CzwGNR6wmJ6Fjww46zOs4teGg7J8uRi8FCofdvtPaNFIyTZ5+tdQxNDKa3jL4axakPmmqFIuE//Oc1HzZ5ZKIvR+5Cn0L2e92iAtWLKSo023IUOL8nJXMSpscOC9IczQkvKhltOtlvliVQVAkz8LhTPFL0VYfcovL79NgRZD19FRTDN4CWBS0mDLp23RcndjQ7SDWPKuxERdxJKbgOvX/pegSkdgj1hLszolo1uDeJV6pQseF7A2VCL+xDegiyURybZtc22MCsAXOLckrY6kmZYws0Dtdkk+RWp02AXnDoXm7p5G3RjygU/0opfrx0newjqU7cai3e3N+7KYxEe/Ur0BW7j4zJz89biVWBMT6gc2RCrnBTPBCnb1Q8BUB5HFI3ENOOgS6N8pxuh2udFhX9pPxkQvq2OHFlCkZcn86FaxY+c7T7X/tzK/zjMkVSim4K4QIKvt+anCj8rbIu2EkQaVSNkbzWkM59u5A5hjCwbvAO77I8RimJOvC+bT8whd61XHvKbIKT6v/Kzs3fNhhKVkKjRCCr14lLSmvmSbrcMHNYb3NG6/TpofL4TruJeuG1aekFHgBCtKz39NHqcbBVywaNoWOW1lHuDoNvE84r4r0Hs6mZJDFPLClj684GJD48JbT9ejQFkX8CtBH+jB3pkXaM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999247.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(11063799006)(5023799004)(261022075727099003)(261021123027099003)(261021121427099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261009223027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ITkYD5YRn3URYg1gW4D/ARhymBxeV9OoahU8hO1/I8jACom9hpBt/HLzUTE5?=
 =?us-ascii?Q?Au+e3drG4FFA/4NWdixEuz8Whk974VnDiciQxSh5NeoLqActZGPradLLAVR1?=
 =?us-ascii?Q?/+Y7ZCOXnkbJE3+XQ3M7e5JHZ/c+lmEg83QSWAH01jLVkct2LIVxpIHacdq0?=
 =?us-ascii?Q?JZwb8RINw9k+5EpIOWSUGsbdJs6323sWLMEqs/2lRSwPdndNQunezRZiWoC/?=
 =?us-ascii?Q?U1EaIsOnTeUHoFF2eq6dLFfcy2nwbYrGZ9lnuiIi+NheYQeDONT80fcvkFNj?=
 =?us-ascii?Q?8yvEdExxYO9CrfkkhoHgSbAvbtlu462zrASlT91ggIOgbzWcJ/Ln2rP7UjLF?=
 =?us-ascii?Q?+L/kvspWFLuIv+K/d+68KL6j9izI7tRizuYB6cdWnzyVhcOv3RkHF8BytT7/?=
 =?us-ascii?Q?FLOhMSJ8E3EYGt/vOTQs4UGrYL7t1O6N6gSMYJlTPJVgohgyWgPhNHSHMCeT?=
 =?us-ascii?Q?wBZRceoWqTFrxC1qS61K8aGstfajQvtTueFuZ8tF3g88N+XlkuvCCBGOPiE2?=
 =?us-ascii?Q?o8ZNQuT2kXp53Ri/UiBrSqXXqTFifXQ7+nFSM8477K1BlU98NIHQ0KQ/IsCd?=
 =?us-ascii?Q?9lunG75F7V+w6Szg4/DskgsHt2PdimV5EJxTzxVWafKhNJz80ruy8dwhQtVO?=
 =?us-ascii?Q?z8JbUA3+cS6hDFy5eX/g2R0xpT4ylK2VJX0L/1maKd0dIUiZgrNcux6dwznd?=
 =?us-ascii?Q?/it/dxvqpbK1y4Qcj6iColzEdhN7Tpx7/JT8pygQCr1W4nIFjKdNVQQ3Vdwl?=
 =?us-ascii?Q?Z34D/FkkZyKNadD091rLW5KH4RT9mDGUX79MgYVb+Wq8xUPJvNrSc0IbLgMK?=
 =?us-ascii?Q?OODh0iavmfIFa3x9/XIDEyfIZrxtirf6XoaO4QwQrz6U0BYLO35XoFMobZUl?=
 =?us-ascii?Q?M2WHXlOQ/D5O3Bt/ZEB5n3Vu70Jl8PIgv0KYtF3tQl2sjuPU9i12G3OsRKMv?=
 =?us-ascii?Q?UVcvfdaQ68KvQkIQBpkH9lnJnW6u6o/3nF2YdvMjdGY1Ud/3Zrt4h1z8yqm9?=
 =?us-ascii?Q?689gSaaHq5E6L6tTFJrdX9vZRutxc9YkagDA1GPPITRANJWz66tYlpPwidnU?=
 =?us-ascii?Q?u14lBiFjbCUZOxav3pltrHBfkZ9ECpDBQfIzf+VrLrJsA9TmeFAt0yxn7vtj?=
 =?us-ascii?Q?6sKu9DM1Dphy+0Ghp+5ZZc5UDHOAit8ic7d4YtXxOxyoA20HMrT6zSWnhqDU?=
 =?us-ascii?Q?ulaEx3D7jdoeK9+dVT8invSfrNUdVCsnoNF4kve1Y0jYXnvQVm40I+35vQcI?=
 =?us-ascii?Q?uibWJBm4sJLtjx2LjtSbDb0cBHOknzgOzpT1h3uvS6keYZiGitieIxm0lnEP?=
 =?us-ascii?Q?paYmPeQU+tNHBQpWqvelQJcqG9u6d/dLp49+J17Z0JlDwy6lYMY+PoTiH8+u?=
 =?us-ascii?Q?myRzhCxF/TTRt8qZJfzLdiznCh3gek6rTb2xFYUgMbccQyiWkAiOXvXAoEql?=
 =?us-ascii?Q?J3McgErf1zwm8cSggzVGDyhSTz0BrBzDhFlVuMNaLI5LlI4mRQX9ZetT2fVF?=
 =?us-ascii?Q?lmbnYhV1HhgkR7sD/IY35qo2+5pWLBfCL3tYzWFkRk1Um/LpofeH02+ue8Sp?=
 =?us-ascii?Q?MgeDlNyIy19pXOmgBohCLjuzPNgYaWpqoHfSD6G5oGeUA7XsM2WtHzyxJUXb?=
 =?us-ascii?Q?EJMvfZ+knNqeJ8XOKxt9iy7/eeAiEt8IobDeVCbNM8bVE6A/vhgr5j1cQvwj?=
 =?us-ascii?Q?0qgEEY3IAr8FJtIXC8Ep9TtRTFK+eeYXDqi3eDT9eAebGFhT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999247.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4cc3000-1a43-4e0a-732f-08df39231e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 20:51:50.9632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yk1ix0g1pgyfWcLE+NP7vFvX+g7yxMkOiLkpA+VQsfaaxiLMuckI5eNd0CyFh0a9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>>> With that in mind, I think your change kind of makes sense. I think the
>>> cleanest solution would be to just ignore the ctl_stack_size in the
>>> q_data and always get it from the topo_dev->node_props. You could even
>>> remove from the q_data completely. It's not needed. Just make sure you
>>> bump KFD_CRIU_PRIV_VERSION so that restoring an old checkpoint on a new
>>> driver would fail gracefully.
>>>
>>> Then you could also remove all those per-GPU generation
>>> get_checkpoint_info functions.
>>>
>> I think that cleanup makes sense. Is there any concern about bumping
>> the CRIU priv version and creating this incompatibility with old dump fi=
les
>> when we don't have to? (We could for instance just leave that field as
>> padding)
>
>Yeah, I wouldn't consider this an ABI breakage since the private
>checkpoint data is opaque to user mode. I think preserving checkpoint
>viability across driver versions is not a requirement. The version check
>is there to protect against an unlikely scenario. That said, we could
>leave it as padding to avoid the version bump. But that kind of clutter
>can accumulate over time. We'd want to remember to clean it up when we
>need to bump the version for some other reason in the future.
>

I was thrown off by a difference between staging and unified branches;
we are currently already setting qp->ctl_stack_size to always be the
topo dev value, and using the priv data ctl_stack_size to represent somethi=
ng
different

        /* Per-XCC control stack size from topology, as create-queue requir=
es */
        if (qp.type =3D=3D KFD_QUEUE_TYPE_COMPUTE && pdd->dev->kfd->cwsr_en=
abled) {
                topo_dev =3D kfd_topology_device_by_id(pdd->dev->id);
                if (!topo_dev) {
                        ret =3D -EINVAL;
                        goto exit;
                }
                qp.ctl_stack_size =3D topo_dev->node_props.ctl_stack_size;
        }

        if (q_data->ctl_stack_size > (u64)qp.ctl_stack_size * NUM_XCC(pdd->=
dev->xcc_mask)) {
                ret =3D -EINVAL;
                goto exit;
        }

        *priv_data_offset +=3D sizeof(*q_data);
        q_extra_data_size =3D (uint64_t)q_data->ctl_stack_size + q_data->mq=
d_size;

Given that, it's probably best not to change set_queue_properties_from_criu
at all in this patch

________________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Monday, November 2, 2026 3:31 PM
To: Francis, David; amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian
Subject: Re: [PATCH v2 1/3] drm/amdkfd: Acquire buffers in CRIU queue resto=
re (again)

On 2026-11-02 15:17, Francis, David wrote:
>>>> I'm curious what this case is needed for. In what circumstances would =
a
>>>> CRIU checkpoint contain 0 ctl_stack_size? And is that's the case,
>>>> wouldn't that break restore anyway?
>>>>
>>> A lot of mqd managers don't set mqd->get_checkpoint_info,
>>> so the ctl_stack_size ends up as 0.
>>>
>>> kfd_queue_acquire_buffers requires the ctl_stack_size to be equal to
>>> topo_dev->node_props.ctl_stack_size anyways, so I think it
>>> makes sense to default to that value if the input is 0.
>> I guess get_checkpoint_info is not implemented for GPUs that don't
>> allocate the control stack in kernel mode. Either way, the control stack
>> ends up being saved or copied into the user mode context save buffer, so
>> the control stack contents are saved regardless of the size reported her=
e.
>>
>> With that in mind, I think your change kind of makes sense. I think the
>> cleanest solution would be to just ignore the ctl_stack_size in the
>> q_data and always get it from the topo_dev->node_props. You could even
>> remove from the q_data completely. It's not needed. Just make sure you
>> bump KFD_CRIU_PRIV_VERSION so that restoring an old checkpoint on a new
>> driver would fail gracefully.
>>
>> Then you could also remove all those per-GPU generation
>> get_checkpoint_info functions.
>>
> I think that cleanup makes sense. Is there any concern about bumping
> the CRIU priv version and creating this incompatibility with old dump fil=
es
> when we don't have to? (We could for instance just leave that field as
> padding)

Yeah, I wouldn't consider this an ABI breakage since the private
checkpoint data is opaque to user mode. I think preserving checkpoint
viability across driver versions is not a requirement. The version check
is there to protect against an unlikely scenario. That said, we could
leave it as padding to avoid the version bump. But that kind of clutter
can accumulate over time. We'd want to remember to clean it up when we
need to bump the version for some other reason in the future.

Regards,
   Felix


>
> David Francis
>
> ________________________________________
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Monday, November 2, 2026 3:09 PM
> To: Francis, David; amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian
> Subject: Re: [PATCH v2 1/3] drm/amdkfd: Acquire buffers in CRIU queue res=
tore (again)
>
> On 2026-11-02 09:39, Francis, David wrote:
>>>> +
>>>> +     if (q_data->type =3D=3D KFD_QUEUE_TYPE_COMPUTE) {
>>>> +             if (q_data->ctl_stack_size)
>>>> +                     qp->ctl_stack_size =3D q_data->ctl_stack_size / =
num_xcc;
>>>> +             else if (topo_dev)
>>>> +                     qp->ctl_stack_size =3D topo_dev->node_props.ctl_=
stack_size;
>>> I'm curious what this case is needed for. In what circumstances would a
>>> CRIU checkpoint contain 0 ctl_stack_size? And is that's the case,
>>> wouldn't that break restore anyway?
>>>
>> A lot of mqd managers don't set mqd->get_checkpoint_info,
>> so the ctl_stack_size ends up as 0.
>>
>> kfd_queue_acquire_buffers requires the ctl_stack_size to be equal to
>> topo_dev->node_props.ctl_stack_size anyways, so I think it
>> makes sense to default to that value if the input is 0.
> I guess get_checkpoint_info is not implemented for GPUs that don't
> allocate the control stack in kernel mode. Either way, the control stack
> ends up being saved or copied into the user mode context save buffer, so
> the control stack contents are saved regardless of the size reported here=
.
>
> With that in mind, I think your change kind of makes sense. I think the
> cleanest solution would be to just ignore the ctl_stack_size in the
> q_data and always get it from the topo_dev->node_props. You could even
> remove from the q_data completely. It's not needed. Just make sure you
> bump KFD_CRIU_PRIV_VERSION so that restoring an old checkpoint on a new
> driver would fail gracefully.
>
> Then you could also remove all those per-GPU generation
> get_checkpoint_info functions.
>
> Regards,
>     Felix
>
>
>> David Francis
>>
>> ________________________________________
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Friday, October 30, 2026 5:15 PM
>> To: Francis, David; amd-gfx@lists.freedesktop.org
>> Cc: Koenig, Christian
>> Subject: Re: [PATCH v2 1/3] drm/amdkfd: Acquire buffers in CRIU queue re=
store (again)
>>
>> On 2026-10-30 10:05, David Francis wrote:
>>> CRIU queue restore doesn't acquire the bo buffers in the same way
>>> normal queue creation does. In normal queue creation, the driver
>>> gets an additional reference on the queue's underlying buffers
>>> that lasts until the queue is destroyed; this prevents the
>>> queue's buffers from being removed from underneath it.
>>>
>>> Acquire them, but don't get the svm bo. SVM isn't yet fully
>>> restored by this point in CRIU and so there's no svm range to get.
>>> This will be addressed in the next patch.
>>>
>>> Signed-off-by: David Francis <David.Francis@amd.com>
>>> ---
>>>     drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
>>>     drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>>>     .../amd/amdkfd/kfd_process_queue_manager.c    | 34 ++++++++++++++++=
+--
>>>     drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  8 ++++-
>>>     4 files changed, 41 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_chardev.c
>>> index 6c710e4a5220c..d8233337b8d5e 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -433,7 +433,7 @@ static int kfd_ioctl_create_queue(struct file *file=
p, struct kfd_process *p,
>>>                 goto err_bind_process;
>>>         }
>>>
>>> -     err =3D kfd_queue_acquire_buffers(pdd, &q_properties);
>>> +     err =3D kfd_queue_acquire_buffers(pdd, &q_properties, false);
>>>         if (err) {
>>>                 pr_debug("failed to acquire user queue buffers\n");
>>>                 goto err_acquire_queue_buf;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/am=
d/amdkfd/kfd_priv.h
>>> index f0ce5fc4a138f..eb4d35a42e917 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -1381,7 +1381,7 @@ void print_queue(struct queue *q);
>>>     int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, s=
truct amdgpu_bo **pbo,
>>>                          u64 expected_size);
>>>     void kfd_queue_buffer_put(struct amdgpu_bo **bo);
>>> -int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct q=
ueue_properties *properties);
>>> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct q=
ueue_properties *properties, bool is_criu);
>>>     int kfd_queue_release_buffers(struct kfd_process_device *pdd, struc=
t queue_properties *properties);
>>>     void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo *=
*bo);
>>>     int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/d=
rivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> index 4c4a3a8587f46..509529af2dc3c 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> @@ -985,8 +985,14 @@ int kfd_criu_checkpoint_queues(struct kfd_process =
*p,
>>>     }
>>>
>>>     static void set_queue_properties_from_criu(struct queue_properties =
*qp,
>>> -                                       struct kfd_criu_queue_priv_data=
 *q_data)
>>> +                                        struct kfd_criu_queue_priv_dat=
a *q_data,
>>> +                                        struct kfd_process_device *pdd=
)
>>>     {
>>> +     struct kfd_topology_device *topo_dev;
>>> +     uint32_t num_xcc =3D NUM_XCC(pdd->dev->xcc_mask);
>>> +
>>> +     topo_dev =3D kfd_topology_device_by_id(pdd->dev->id);
>>> +
>>>         qp->is_interop =3D false;
>>>         qp->queue_percent =3D q_data->q_percent;
>>>         qp->priority =3D q_data->priority;
>>> @@ -998,6 +1004,16 @@ static void set_queue_properties_from_criu(struct=
 queue_properties *qp,
>>>         qp->eop_ring_buffer_size =3D q_data->eop_ring_buffer_size;
>>>         qp->ctx_save_restore_area_address =3D q_data->ctx_save_restore_=
area_address;
>>>         qp->ctx_save_restore_area_size =3D q_data->ctx_save_restore_are=
a_size;
>>> +
>>> +     if (q_data->type =3D=3D KFD_QUEUE_TYPE_COMPUTE) {
>>> +             if (q_data->ctl_stack_size)
>>> +                     qp->ctl_stack_size =3D q_data->ctl_stack_size / n=
um_xcc;
>>> +             else if (topo_dev)
>>> +                     qp->ctl_stack_size =3D topo_dev->node_props.ctl_s=
tack_size;
>> I'm curious what this case is needed for. In what circumstances would a
>> CRIU checkpoint contain 0 ctl_stack_size? And is that's the case,
>> wouldn't that break restore anyway?
>>
>> Other than that, this patch looks good to me.
>>
>> Regards,
>>      Felix
>>
>>
>>> +     } else {
>>> +             qp->ctl_stack_size =3D q_data->ctl_stack_size;
>>> +     }
>>> +
>>>         qp->type =3D q_data->type;
>>>         qp->format =3D q_data->format;
>>>     }
>>> @@ -1047,7 +1063,13 @@ int kfd_criu_restore_queue(struct kfd_process *p=
,
>>>         }
>>>
>>>         memset(&qp, 0, sizeof(qp));
>>> -     set_queue_properties_from_criu(&qp, q_data);
>>> +     set_queue_properties_from_criu(&qp, q_data, pdd);
>>> +
>>> +     if (q_data->type =3D=3D KFD_QUEUE_TYPE_COMPUTE && !qp.ctl_stack_s=
ize) {
>>> +             pr_err("Failed to determine ctl_stack_size for compute qu=
eue\n");
>>> +             ret =3D -EINVAL;
>>> +             goto exit;
>>> +     }
>>>
>>>         /* Per-XCC control stack size from topology, as create-queue re=
quires */
>>>         if (qp.type =3D=3D KFD_QUEUE_TYPE_COMPUTE && pdd->dev->kfd->cws=
r_enabled) {
>>> @@ -1095,9 +1117,17 @@ int kfd_criu_restore_queue(struct kfd_process *p=
,
>>>
>>>         print_queue_properties(&qp);
>>>
>>> +     ret =3D kfd_queue_acquire_buffers(pdd, &qp, true);
>>> +     if (ret) {
>>> +             pr_err("Failed to acquire user queue buffers err:%d\n", r=
et);
>>> +             goto exit;
>>> +     }
>>> +
>>>         ret =3D pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_d=
ata, mqd, ctl_stack, NULL);
>>>         if (ret) {
>>>                 pr_err("Failed to create new queue err:%d\n", ret);
>>> +             kfd_queue_unref_bo_vas(pdd, &qp);
>>> +             kfd_queue_release_buffers(pdd, &qp);
>>>                 goto exit;
>>>         }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_queue.c
>>> index 6010a5d7a7eb9..18d24ddb455eb 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> @@ -239,7 +239,7 @@ static void kfd_queue_put_bos(struct queue_properti=
es *properties)
>>>         kfd_queue_buffer_put(&properties->cwsr_bo);
>>>     }
>>>
>>> -int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct q=
ueue_properties *properties)
>>> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct q=
ueue_properties *properties, bool is_criu)
>>>     {
>>>         struct kfd_topology_device *topo_dev;
>>>         u64 expected_queue_size;
>>> @@ -334,6 +334,12 @@ int kfd_queue_acquire_buffers(struct kfd_process_d=
evice *pdd, struct queue_prope
>>>
>>>         amdgpu_bo_unreserve(vm->root.bo);
>>>
>>> +     /* CRIU svm buffers are restored at a later stage than queues. Th=
ey'll be in
>>> +      * before the queue is actually used, so no risk here
>>> +      */
>>> +     if (is_criu)
>>> +             return 0;
>>> +
>>>         err =3D kfd_queue_buffer_svm_get(pdd, properties->ctx_save_rest=
ore_area_address,
>>>                                        total_cwsr_size);
>>>         if (err)
