Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C635C07E95
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 02:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 348A461361
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 02:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348A461361
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2CFB6E153;
	Wed, 14 Jul 2021 02:01:13 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2085.outbound.protection.outlook.com [40.107.101.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 967BE6E153
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 02:01:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBBK4/yCWXkxgYHmhd4npNEcqzlTIm2Uru5q4NO9Wn8oi/tPerGv1YWIy2C2O5wngutR7odDMol/5VaBz5sST7CRwyVL4x8MLwUWuJVHvl2U7dOlwlrDyT+Uf6Df/nWZfFzPMdBgm7/6DfxLlJ85roYcrSdjVIab02Vh2rUSHC+BsXcO0skfPMuc8HKC8M5+QIsDQi0kWDQG+Ty5q1emv17ifvBPlgZQHRYstQswSkSriawvdxkXLLAcfL1x/x8QWbs9uKgt5b2xxzjpDV9rjBwekEbDpFHHYXZgAKbAMhPR69oLk4O+fMfiBUEgEYi4dV4UrifzMn1kdk0bgKg1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JHPs4DlZABWSMvK26PhTaGcrrD2femsk+KS/qZrpKo=;
 b=A/veddqzGzfi6RvTJoFHzXmNPSivLlQ8kLpVH9s0VJxitC6I4xVU4P8L1yySEFUZXHFqKQxm/TtibU3EJee+63XhILrlRuEbWFF/ANaJ8ie6CXquxVFx8+ESTF2TpLg53QtHf8RlZNFWIdLianvywKnfX+rAyOuGpc/ldF1lygmEtKQzcbStVczXD/3X25fhZGsVXieHAyoHrarKc5wXnm9HwFU35pnczofY2ZJgjCXquOUn724/RZpYO8w6+Ty8tV3SWUn//ZS0JsGY2RlyRTaVBXvx/gEtB8ysCqlX7tlFlSfFjrWqfqZp/l2V59xTWNQCLAiNzx/ythgFy3Ck7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JHPs4DlZABWSMvK26PhTaGcrrD2femsk+KS/qZrpKo=;
 b=Kii4Qp7ajEmaPvLO5Uxgz+wPg1Paek/YSpX5ca5ZGZRlneYLsQqZUJHXaBjVBEJH6eVSnLDA1ucuLQSARIcsHal5i8fbsdxqzLrE7QPSVeuxsukMn3cuY79OdO2zLAHtsMpo4fHkqCVg/9jOaxkk4gFbXdTx+i+CTFaDN1EX1I8=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.22; Wed, 14 Jul 2021 02:01:10 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 02:01:10 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
Thread-Topic: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
Thread-Index: AQHXdzL1D0FsgqsKJkylqu+VRSwDVqtAeG5AgAC0HwCAAIG9oA==
Date: Wed, 14 Jul 2021 02:01:10 +0000
Message-ID: <DM6PR12MB2619C0AEB13E692BD66B5544E4139@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210712153051.4029-1-luben.tuikov@amd.com>
 <DM6PR12MB2619B19E2BBB61DA3B9DAFE8E4149@DM6PR12MB2619.namprd12.prod.outlook.com>
 <bc0a3dff-890b-16d6-2897-1a459f87cde9@amd.com>
In-Reply-To: <bc0a3dff-890b-16d6-2897-1a459f87cde9@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-14T02:01:06Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=503020b8-dd65-410a-9254-67db1b10b014;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 457e029e-58da-47c6-79ed-08d9466b405b
x-ms-traffictypediagnostic: DM5PR12MB1770:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB17708C626432313F08615360E4139@DM5PR12MB1770.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oR25spXa3gNZzjlzxrsdE6xdgquj4gA6+GGuBvFkCFBE1JtjD8sszIyPs6QhAw6RcwzRq2tKNI/7Lkf0zhNUXOQ8gNFgYzfc9K7X02rVl+YqKNbOCkJAcfcZ4IQsbtgD0rQkF/WaXY3EIhon0T1BU3DQzntHvOR+DQIk4YhvSCrmn61UTinu2AwLUQN7m9WpMg+cuEMVLPncs/j+FfFs+T6aW7mAcXF9zqpLb9RiEekmHf+wo4Ne533WVivg9R9raEPRWouwd1KtAdn8zBlsnz9VzG4c5K/N2xTG+SiDRSm3tDgmjmq7lF2ICwCfm73WGllKW7q46iZhxuPeEMT1R1aGVvkplBwCWmMJCl2qXCPQyZbGspXOa9D62+L3Fz9NDZy6Jh0Bnt9cVYQpAKXZfKs/058/xXC+BCbLhm6KgG3srDBulQKEp3QZSwmun8uJawngipX+4KC5nQK83+/FB64KtgbchUyj5tUAh1MdV/JKLQTdTYrO2akG45Z65QnG14jI6qwxPjc388GCczK8ahncSvWneOpwvDJwq5d8UvsDBkz03VTl2Iz7WBzOVvkazxZ5+YAT9RV1BmZTdygGftxlCf9pTQHp527xzdcPS5GrLL2yhSB3srsY/8CCmxQwVfiqCIWz5gWFpPAXHbqy0QzqZZO/8h46IpcQlbpP/1qfWadkX80Z9zWSPzgfMDWcczgDsrQq6c1mtJiw78PH+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(2906002)(122000001)(186003)(71200400001)(8936002)(26005)(38100700002)(66946007)(6506007)(76116006)(5660300002)(55016002)(33656002)(110136005)(53546011)(9686003)(64756008)(30864003)(8676002)(478600001)(66556008)(54906003)(66446008)(316002)(83380400001)(4326008)(7696005)(86362001)(66476007)(52536014)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ang4d1NZOVZCUnBlaU9FRUwwUExxZis3UmJDTWRKdUxuVXkwd2xhT1BaelV4?=
 =?utf-8?B?b3FzQjkrdElvdG5nT1NpbEdmUnlrVlZaclduV3MvTnBKeTdJUVBFb3Y4aEpn?=
 =?utf-8?B?TDROejRZdDZMaXc5RzFWZVlUckh1cmdoMGZEYXhnYjQ0VkpFZ0NvYWxKc1Ni?=
 =?utf-8?B?OFVQb0R3Q1Rtd014ZUpFVGlSRXVGalJqYTJubVJRYkFWY04wSU1DM3lSQnN4?=
 =?utf-8?B?ckZ1d0svNTUxcTIyR1FGVENUREMweWxHNk9MMlJ0dE8rbmdOOFkzaXFRQVRP?=
 =?utf-8?B?OVZvYXdxZGMrcXlWUWV6NGdhOGxjdUtnTjRtbHl5aHk4bEhJOTF5NkFWZW1N?=
 =?utf-8?B?Y3BkbjBNcnAzNU1MT1FmRHBFbDYrbVpUbkJ4cEdrSGRFaEQrc0c5UXljVnRE?=
 =?utf-8?B?MFRadlpRamVheVh0U0NKV0VWeHNua2h2R21VNGV4dkZBbEhNQXlkMGZJd2hw?=
 =?utf-8?B?WHc0OFdGRkt1OStVdjNyZmxxaTU5My9Ud0FpZ0NZNVllN25jcTBDRnpMOWtz?=
 =?utf-8?B?NXRST3B0Y0UwdVc3MlN3amNEWjhvNkt3WkhZSUw1ODNNbnZaaHJHVS85RWxQ?=
 =?utf-8?B?OTdLRkFLcXVxYzIvVGE1aDM2MmdvV3NURHpPZ1pWa1lRVURQOUNSbWJjZUly?=
 =?utf-8?B?RHVlbEkrQ3FNYVoyb1VuNmxzRWlNK09EZExYM084QW9LZ1d4ZXRONkRTM0ZU?=
 =?utf-8?B?eXc5WC9maG41Q2RBVk9SZjFWRERLWnViMnpiNjNEYU0vekU5ZkpCUU1ncGJ6?=
 =?utf-8?B?R2tuSVEvemxxc3p2a2RCdTJId2JZMG52eUswRjA3UWh5S0l3akhTN0h0Umtj?=
 =?utf-8?B?TytGcm5Td2RYOWtDc0JlWGlIbkp6QzdRVTZVT0FPaWVDY3FIRmNJR2FWSTNG?=
 =?utf-8?B?dyszYlVzQnNQSkNEWkp3SXN6dnJtbXZmL3NhTjFLa0Z0YmtjQk9sNFRoQnln?=
 =?utf-8?B?bkZCeVl3WnFLam1WemVHUzNSRHhIMFNEWks0ZmpQWnFEVVZlQ0ZDeVZFeTVh?=
 =?utf-8?B?NHRoOEdVd2M5N015WDEwL3RkSW9Wd0dTNTFHUGVaU3B1aEpzeVJwWmdCK3M4?=
 =?utf-8?B?aGtOb3ZRNVg1MUQ5aWRoazF4ZEZobThwTHFPTzBMNDZBcVRxNjNuR3Zxem01?=
 =?utf-8?B?QzhyRTkyVE51QjlEL3VxWjVGM0E1V3JvR3hmT0VpVVk0Tm5LY3hvT1BTRmZk?=
 =?utf-8?B?T3JzS2R6TVNIM3lsZ2hJRXVpN0xFenN2Mk0wOU5wb1hicWpUekZuTXNHZWlJ?=
 =?utf-8?B?d1c3UCsrTm9iU2doQ0xQYUY5RE1mYnhsTkpGRmxEeVY4dkQxVkQ2SnBlS09Q?=
 =?utf-8?B?MjZSSGFQWU5hcnRrY3ZKMVhMRGZpV1lGbndwMHdqRUFhdFhWd3lsREdKd1c3?=
 =?utf-8?B?Smc4OW11S2Q0cVc2c3BqOWFXUkhvcnBqc1BsQTNQRXUzem1VYmNSdnUydVl3?=
 =?utf-8?B?M2s2Sm4rTnpHUDRrVk5rdmxicWxsN1k3VlhqbCtYY0hoNTcwZi9SZ1ZKZUpQ?=
 =?utf-8?B?Q0hnTHBlY0NLYlg5b2JkQzR6STV5TUVCemhmYVpyVVdQaUtJWDNOUlFBdElC?=
 =?utf-8?B?TGZ5ckVrczhGanVURDNOR1MxSzVQOXluWDVUUEtvQklQNVhFQkJWbW5wdEUw?=
 =?utf-8?B?YXNEVDZpaUx0WDdoeXhwWm9VeVdTTWo4K3pQVUlFdmdrV2YrdjZJOEp5OHBR?=
 =?utf-8?B?ZHhhNC9RKzdySUlwVld2OVVtVHo5THcrVTd5NDMyYzRTR1N3Y3ptZkFUS3J6?=
 =?utf-8?Q?smNNQuGdWUrFv0noNYCsEEX1zoe29CB/dH/eMI6?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457e029e-58da-47c6-79ed-08d9466b405b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 02:01:10.2948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rcd/hW4i/t2nxQOHh/puBwPpF8xk3n0aYPOrMiOHNHBC6lB2totzf1HUe7EeOyFC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1770
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Baluja,
 Aaron" <Aaron.Baluja@amd.com>, "Alimucaj, Andi" <Anduil.Alimucaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> Sent: Wednesday, July 14, 2021 1:36 AM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Alimucaj, Andi
> <Anduil.Alimucaj@amd.com>; Baluja, Aaron <Aaron.Baluja@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
> 
> On 2021-07-13 3:07 a.m., Quan, Evan wrote:
> > [AMD Official Use Only]
> >
> >
> >
> >> -----Original Message-----
> >> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> >> Sent: Monday, July 12, 2021 11:31 PM
> >> To: amd-gfx@lists.freedesktop.org
> >> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander
> >> <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> >> Subject: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
> >>
> >> This fixes a bug which if we probe a non-existing I2C device, and the
> >> SMU returns 0xFF,
> > [Quan, Evan] Do we have to probe I2C device via issuing commands to SMU
> and check existence via SMU response?
> 
> Yes, yes we do.
> 
> > Is there other more friendly way?
> 
> No, there isn't.
> 
> > >from then on
> >> we can never communicate with the SMU, because the code before this
> >> patch reads and interprets 0xFF as a terminal error, and thus we
> >> never write 0 into register 90 to clear the status (and subsequently
> >> send a new command to the SMU.)
> >>
> >> It is not an error that the SMU returns status 0xFF. This means that
> >> the SMU executed the last command successfully (execution status),
> >> but the command result is an error of some sort (execution result),
> >> depending on what the command was.
> >>
> >> When doing a status check of the SMU, before we send a new command,
> >> the only status which precludes us from sending a new command is
> >> 0--the SMU hasn't finished executing a previous command, and
> >> 0xFC--the SMU is busy.
> >>
> >> This bug was seen as the following line in the kernel log,
> >>
> >> amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the
> >> right state!
> > [Quan, Evan] This was designed to prevent failure scenario from ruin.
> > Via this, we can prevent those SMU command/response related registers
> overwritten.
> > Then PMFW team can known which command invoked the first error.
> 
> Sorry, this is not correct.
> 
> The interface cannot block valid access to the SMU firmware, just because a
> command executed successfully, but with a failed result, i.e. set a clock
> frequency to such-and-such frequency was executed successfully by the
> SMU, but the frequency wasn't able to be set as required--the SMU IS NOT
> BLOCKED, but can execute more commands.
[Quan, Evan] 
1. First of all, if the response from SMU is not 1, it means SMU must detected something wrong.
We(driver) should properly handle that. I do not think it's a good idea to silently ignore that and proceed more commands.
2. Please be noticed that many commands(SMU messages) have dependence with each other. It means even if the further command
can be executed "successfully", it may be not executed in the expected way.
> 
> If the PMFW team wants to know which command invoked "the first error",
> they can check this explicitly, they can call smu_cmn_wait_for_response(),
> just like the reset code does--see the reset code.
[Quan, Evan] Per my knowledge gained during co-work with PMFW team, they expect no further driver-smu interaction(driver stops issuing command)
 when something went wrong. As they highly rely on SMU internal statistics for their debugging and further interaction may ruin them.
> 
> The way commit fcb1fe9c9e0031 modified the code, it blocks access to the
> SMU for various other users of the SMU, not least of which is the I2C.
[Quan, Evan] I'm wondering can we just list the I2C case as an exception. I means for the SMU command related with I2C we always assume the response is 1.
For other commands, we just leave them as they are.

BR
Evan
> 
> Regards,
> Luben
> 
> >
> > BR
> > Evan
> >> when subsequent SMU commands, not necessarily related to I2C, were
> >> sent to the SMU.
> >>
> >> This patch fixes this bug.
> >>
> >> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> >> Cc: Evan Quan <evan.quan@amd.com>
> >> Fixes: fcb1fe9c9e0031 ("drm/amd/powerplay: pre-check the SMU state
> >> before issuing message")
> >> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 196
> >> +++++++++++++++++++------
> >>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 +-
> >>  2 files changed, 152 insertions(+), 47 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> >> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> >> index c902fdf322c1be..775eb50a2e49a6 100644
> >> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> >> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> >> @@ -55,7 +55,7 @@
> >>
> >>  #undef __SMU_DUMMY_MAP
> >>  #define __SMU_DUMMY_MAP(type)	#type
> >> -static const char* __smu_message_names[] = {
> >> +static const char * const __smu_message_names[] = {
> >>  	SMU_MESSAGE_TYPES
> >>  };
> >>
> >> @@ -76,46 +76,161 @@ static void smu_cmn_read_arg(struct
> smu_context
> >> *smu,
> >>  	*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);  }
> >>
> >> -int smu_cmn_wait_for_response(struct smu_context *smu)
> >> +/**
> >> + * __smu_cmn_poll_stat -- poll for a status from the SMU
> >> + * smu: a pointer to SMU context
> >> + *
> >> + * Returns the status of the SMU, which could be,
> >> + * 0, the SMU is busy with your previous command;
> >> + * 1,    execution status: success, execution result: success;
> >> + * 0xFF, execution status: success, execution result: failure;
> >> + * 0xFE, unknown command;
> >> + * 0xFD, valid command, but bad (command) prerequisites;
> >> + * 0xFC, the command was rejected as the SMU is busy;
> >> + * 0xFB, "SMC_Result_DebugDataDumpEnd".
> >> + */
> >> +static u32 __smu_cmn_poll_stat(struct smu_context *smu)
> >>  {
> >>  	struct amdgpu_device *adev = smu->adev;
> >> -	uint32_t cur_value, i, timeout = adev->usec_timeout * 20;
> >> +	int timeout = adev->usec_timeout * 20;
> >> +	u32 reg;
> >>
> >> -	for (i = 0; i < timeout; i++) {
> >> -		cur_value = RREG32_SOC15(MP1, 0,
> >> mmMP1_SMN_C2PMSG_90);
> >> -		if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
> >> -			return cur_value;
> >> +	for ( ; timeout > 0; timeout--) {
> >> +		reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
> >> +		if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
> >> +			break;
> >>
> >>  		udelay(1);
> >>  	}
> >>
> >> -	/* timeout means wrong logic */
> >> -	if (i == timeout)
> >> -		return -ETIME;
> >> -
> >> -	return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
> >> +	return reg;
> >>  }
> >>
> >> -int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> >> -				     uint16_t msg, uint32_t param)
> >> +static void __smu_cmn_reg_print_error(struct smu_context *smu,
> >> +				      u32 reg_c2pmsg_90,
> >> +				      int msg_index,
> >> +				      u32 param,
> >> +				      enum smu_message_type msg)
> >>  {
> >>  	struct amdgpu_device *adev = smu->adev;
> >> -	int ret;
> >> +	const char *message = smu_get_message_name(smu, msg);
> >>
> >> -	ret = smu_cmn_wait_for_response(smu);
> >> -	if (ret != 0x1) {
> >> -		dev_err(adev->dev, "Msg issuing pre-check failed(0x%x) and
> >> "
> >> -		       "SMU may be not in the right state!\n", ret);
> >> -		if (ret != -ETIME)
> >> -			ret = -EIO;
> >> -		return ret;
> >> +	switch (reg_c2pmsg_90) {
> >> +	case 0:
> >> +		dev_err_ratelimited(adev->dev,
> >> +				    "SMU: I'm not done with your previous
> >> command!");
> >> +		break;
> >> +	case 1:
> >> +		/* The SMU executed the command. It completed with a
> >> +		 * successful result.
> >> +		 */
> >> +		break;
> >> +	case 0xFF:
> >> +		/* The SMU executed the command. It completed with a
> >> +		 * unsuccessful result.
> >> +		 */
> >> +		break;
> >> +	case 0xFE:
> >> +		dev_err_ratelimited(adev->dev,
> >> +				    "SMU: unknown command: index:%d
> >> param:0x%08X message:%s",
> >> +				    msg_index, param, message);
> >> +		break;
> >> +	case 0xFD:
> >> +		dev_err_ratelimited(adev->dev,
> >> +				    "SMU: valid command, bad prerequisites:
> >> index:%d param:0x%08X message:%s",
> >> +				    msg_index, param, message);
> >> +		break;
> >> +	case 0xFC:
> >> +		dev_err_ratelimited(adev->dev,
> >> +				    "SMU: I'm very busy for your command:
> >> index:%d param:0x%08X message:%s",
> >> +				    msg_index, param, message);
> >> +		break;
> >> +	case 0xFB:
> >> +		dev_err_ratelimited(adev->dev,
> >> +				    "SMU: I'm debugging!");
> >> +		break;
> >> +	default:
> >> +		dev_err_ratelimited(adev->dev,
> >> +				    "SMU: response:0x%08X for index:%d
> >> param:0x%08X message:%s?",
> >> +				    reg_c2pmsg_90, msg_index, param,
> >> message);
> >> +		break;
> >> +	}
> >> +}
> >> +
> >> +static int __smu_cmn_reg2errno(struct smu_context *smu, u32
> >> reg_c2pmsg_90)
> >> +{
> >> +	int res;
> >> +
> >> +	switch (reg_c2pmsg_90) {
> >> +	case 0:
> >> +		res = -ETIME;
> >> +		break;
> >> +	case 1:
> >> +		res = 0;
> >> +		break;
> >> +	case 0xFF:
> >> +		res = -EIO;
> >> +		break;
> >> +	case 0xFE:
> >> +		res = -EOPNOTSUPP;
> >> +		break;
> >> +	case 0xFD:
> >> +		res = -EIO;
> >> +		break;
> >> +	case 0xFC:
> >> +		res = -EBUSY;
> >> +		break;
> >> +	case 0xFB:
> >> +		res = -EIO;
> >> +		break;
> >> +	default:
> >> +		res = -EIO;
> >> +		break;
> >>  	}
> >>
> >> +	return res;
> >> +}
> >> +
> >> +static void __smu_cmn_send_msg(struct smu_context *smu,
> >> +			       u16 msg,
> >> +			       u32 param)
> >> +{
> >> +	struct amdgpu_device *adev = smu->adev;
> >> +
> >>  	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
> >>  	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
> >>  	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
> >> +}
> >>
> >> -	return 0;
> >> +int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> >> +				     uint16_t msg_index,
> >> +				     uint32_t param)
> >> +{
> >> +	u32 reg;
> >> +	int res;
> >> +
> >> +	if (smu->adev->in_pci_err_recovery)
> >> +		return 0;
> >> +
> >> +	mutex_lock(&smu->message_lock);
> >> +	reg = __smu_cmn_poll_stat(smu);
> >> +	if (reg == 0 || reg == 0xFC) {
> >> +		res = __smu_cmn_reg2errno(smu, reg);
> >> +		goto Out;
> >> +	}
> >> +	__smu_cmn_send_msg(smu, msg_index, param);
> >> +	res = 0;
> >> +Out:
> >> +	mutex_unlock(&smu->message_lock);
> >> +	return res;
> >> +}
> >> +
> >> +int smu_cmn_wait_for_response(struct smu_context *smu) {
> >> +	u32 reg;
> >> +
> >> +	reg = __smu_cmn_poll_stat(smu);
> >> +	return __smu_cmn_reg2errno(smu, reg);
> >>  }
> >>
> >>  int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
> @@
> >> -123,8 +238,8 @@ int smu_cmn_send_smc_msg_with_param(struct
> >> smu_context *smu,
> >>  				    uint32_t param,
> >>  				    uint32_t *read_arg)
> >>  {
> >> -	struct amdgpu_device *adev = smu->adev;
> >> -	int ret = 0, index = 0;
> >> +	int res, index;
> >> +	u32 reg;
> >>
> >>  	if (smu->adev->in_pci_err_recovery)
> >>  		return 0;
> >> @@ -136,31 +251,20 @@ int
> smu_cmn_send_smc_msg_with_param(struct
> >> smu_context *smu,
> >>  		return index == -EACCES ? 0 : index;
> >>
> >>  	mutex_lock(&smu->message_lock);
> >> -	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
> >> param);
> >> -	if (ret)
> >> -		goto out;
> >> -
> >> -	ret = smu_cmn_wait_for_response(smu);
> >> -	if (ret != 0x1) {
> >> -		if (ret == -ETIME) {
> >> -			dev_err(adev->dev, "message: %15s (%d) \tparam:
> >> 0x%08x is timeout (no response)\n",
> >> -				smu_get_message_name(smu, msg), index,
> >> param);
> >> -		} else {
> >> -			dev_err(adev->dev, "failed send message: %15s (%d)
> >> \tparam: 0x%08x response %#x\n",
> >> -				smu_get_message_name(smu, msg), index,
> >> param,
> >> -				ret);
> >> -			ret = -EIO;
> >> -		}
> >> -		goto out;
> >> +	reg = __smu_cmn_poll_stat(smu);
> >> +	if (reg == 0 || reg == 0xFC) {
> >> +		res = __smu_cmn_reg2errno(smu, reg);
> >> +		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
> >> +		goto Out;
> >>  	}
> >> -
> >> +	__smu_cmn_send_msg(smu, (uint16_t) index, param);
> >> +	reg = __smu_cmn_poll_stat(smu);
> >> +	res = __smu_cmn_reg2errno(smu, reg);
> >>  	if (read_arg)
> >>  		smu_cmn_read_arg(smu, read_arg);
> >> -
> >> -	ret = 0; /* 0 as driver return value */
> >> -out:
> >> +Out:
> >>  	mutex_unlock(&smu->message_lock);
> >> -	return ret;
> >> +	return res;
> >>  }
> >>
> >>  int smu_cmn_send_smc_msg(struct smu_context *smu, diff --git
> >> a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> >> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> >> index 9add5f16ff562a..16993daa2ae042 100644
> >> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> >> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> >> @@ -27,7 +27,8 @@
> >>
> >>  #if defined(SWSMU_CODE_LAYER_L2) ||
> defined(SWSMU_CODE_LAYER_L3)
> >> || defined(SWSMU_CODE_LAYER_L4)
> >>  int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> >> -				     uint16_t msg, uint32_t param);
> >> +				     uint16_t msg_index,
> >> +				     uint32_t param);
> >>  int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
> >>  				    enum smu_message_type msg,
> >>  				    uint32_t param,
> >> --
> >> 2.32.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
