Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F22AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Apr 2022 15:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C64D310EA94;
	Thu,  7 Apr 2022 15:10:15 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E94910EADD
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Apr 2022 15:08:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6Bm6q0LvuYawmCuJawaqclf0IIybeVb7IilV+Yhvsd06+Zdi7RyzlgawYrcZErnd6hOD19BfTQRfT3XFqYRBJjdVr9hy14oCwCXbRjP6xvWuKczf5G9dcS0lQBUZe/RWE7dKxabG0Dzbe5b97fMRPHyfI/xPUrvvA++UDYCjZhE3QuIKLc3SGhqmGIy7zv6S4WSx4j2eS6tFAme7EuSHM6EEXy9tOxaFZ/V8iiK7fgncDoWl5DHURuxDuGmp8Kmy1ZEOnyQK6hvEyh8dFQ4c93uXWKdMRsKqd/ZwWPVLlz0KLQcvgby+CB/gKv2hcr3dCmMjARATlvchL9MenGzgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgOAkVPJWcMMHzeWaVphYahIfSlecmVD204VyR9p9yQ=;
 b=bZq27T2zVj+EQwDcUvRRreyMd4RxsaPvBXnQQxFRcyj0TUkUhc1fYroHVvzMHSjG8An7DuAwn8MDPxtgrdZTdaM4Qeps4xucoafDOend+36hl0uwmQpzWopPYIzipjkoWnB3QKyiWmkNZJQer3D4RD3XMc9NenYLUVq4jOgDS0kxbbVtCZwiY9r5NgxKqx/Xaenl0QHJT5imKCitDS7Fyhc9i/IO0wmzsEwE3hiALVNMTYivDt2J795aGfqRUhympgKNg5rGG5HHSbZqvvAOqsUI0XUpFBbLQF8e7ZgJ9gtlwwiF38+oqaAndDUWXHGsUCAvgIUtaNa4G3793vyu9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgOAkVPJWcMMHzeWaVphYahIfSlecmVD204VyR9p9yQ=;
 b=IMG94aPYSxcjJb12q9I8bGgAoaI4vjQMWnV6iBNsG71WBB5BkVJwo0jUYuo6fJTUV4dfNs2tSlnR2B+h9ftqogoZcrThQJFHhkGDIOv6SR7mVWR7Ih25ZbjlPFxwxjc4wi9pT1L1f9SKRp3hxOCCwxElM+dwz6VLgtuenQHBOV8=
Received: from PSAP153MB0517.APCP153.PROD.OUTLOOK.COM (2603:1096:301:67::8) by
 HKAP153MB0354.APCP153.PROD.OUTLOOK.COM (2603:1096:203:da::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.12; Thu, 7 Apr 2022 15:08:45 +0000
Received: from PSAP153MB0517.APCP153.PROD.OUTLOOK.COM
 ([fe80::c88f:d71a:2b3d:1c32]) by PSAP153MB0517.APCP153.PROD.OUTLOOK.COM
 ([fe80::c88f:d71a:2b3d:1c32%9]) with mapi id 15.20.5164.011; Thu, 7 Apr 2022
 15:08:44 +0000
From: Shuotao Xu <shuotaoxu@microsoft.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
Thread-Topic: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
Thread-Index: AQHYSV+lQh0DehaAkU6mUF/D9OJf/qzi7iYAgAABCGOAAAWHAIAAAhPygACboOCAAPv2Gg==
Date: Thu, 7 Apr 2022 15:08:44 +0000
Message-ID: <PSAP153MB0517AFB4B9CF54A17CD5223EB7E69@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
References: <PSAP153MB051776C60FFB06BB3278EEB4B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
 <2cdfcdee-bf4d-006a-19c1-c806feb4100d@amd.com>
 <PSAP153MB0517571E0AECDB007D90A8F3B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
 <990573e7-bc0e-0c3a-11b9-c725fdee44df@amd.com>
 <PSAP153MB05176F6C82945DE2C3443248B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
 <DM5PR12MB1786CA4217F5A00B4CF706AAEEE69@DM5PR12MB1786.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1786CA4217F5A00B4CF706AAEEE69@DM5PR12MB1786.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-07T02:22:49.0000000Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP
 2.0; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-07T15:02:53.6671359Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6da79517-7f2a-45ed-31c5-08da18a8827f
x-ms-traffictypediagnostic: HKAP153MB0354:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <HKAP153MB035493C4A3F04CFA9C219E6BB7E69@HKAP153MB0354.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o4gAFtdgkofTs+j4qvhEapjJMkaJMVQZioxY1Dw0sLB5X8m8vh9IZ7rQ8naPEoJC1HV7KV556U3lE/Ic04VkaNzjCldV/kqI3tf3Qv3jNSxBHjDQG60kpKPeB+LFJiBEN7dDM+Jo26K0vWsfYXcaPyt2IuSI9Q+/Nakb4E66iL9hyDIWUTieT4ts3aXXzUy+5fX8oAsKPqv8qe5allNifLudFVTzd8UMDuV7Oq7uuTfX7//ffPXjhj7HvS4/pqPe8j+pg1GRcupdHkA5ofh/ZgOVXUsMzeRqs0PJeh6lHvui7eORT0TwD/BWedEhk5Zd9+o8NVa7T2IXlON3dpOyFwkEtc5rh04O5MuT1PK+cBuqixT/v8szDOpZsckbkMPbP/mLxANARs6FuKKfFncUjOyZ3v9qTaV/mYtdUkxcaKBs3vlzQTNSDgnkOa3z3ZVDTsvAff3wL+TUWBan07/MBdk6yiDNKJWUxrZ1HuD2ptfiUVDfrVgnd62Y4xAAE7jcWdpwxtcHVDLZDDHfLEOxhM30SfZxNfkbuEi9+SBsTuBHPQ3VWNMX3LVgvvlsqi9uOGVv2GJLycYhBLtRBTNE3QiWVpONS2VlhZHMZQFc4HaHFsFEwHWFysImktf5frXACaRLibGPNL6VJu9DI7U+hFiWDCRJhGEx5YrHjYXb8A+YQbir0kfI6XcXsTZPNvtTZZq73uXObvcKWghXmwKEB+huTw6bMgxbGToFxKpRWd0Ykk7ZqKMDersE033gzIzVibjVtX2wsB/ecokV9zwFxxFnj2GpCsQ81u+eBzhJU8xLrFacv/GeGSd/KcDa/9jkQdb1x49plSVlMJS6soYWVYbB3jNyPJqwXurZ9MINbEFBhUFLahMKgKSSCk3bODJSBfMHyjxydygX0CaVuJWHmw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAP153MB0517.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(9686003)(2906002)(966005)(71200400001)(508600001)(82960400001)(66476007)(82950400001)(53546011)(166002)(7696005)(6506007)(38100700002)(5660300002)(91956017)(107886003)(30864003)(86362001)(186003)(10290500003)(55016003)(122000001)(38070700005)(110136005)(16799955002)(54906003)(83380400001)(4326008)(33656002)(8936002)(66446008)(9326002)(8990500004)(76116006)(66946007)(8676002)(52536014)(316002)(66556008)(64756008)(559001)(579004)(10090945011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?EzjwPUmDpNiqxaPmYfjQcoE+f8dGeTu7HpfYEC/A9Ij3ugXMTdoO5GKI?=
 =?Windows-1252?Q?CCOgkPogSFOEUDCxg08X8AxAiF/OIHwDMpNd4x5ax2jxaD34Z5pmyZaC?=
 =?Windows-1252?Q?qqjWmWBp711cU5iutX8ZOCsXXp6JgT2FVVPFB7G0+beLb/iF1NLMZW7W?=
 =?Windows-1252?Q?LZWAQFUd9caIcOiP8FOyr7rEoRTgNF+ZkN9je+F/5T64+UkWgporJF0w?=
 =?Windows-1252?Q?rEuyvqFczSyBXmHuoPfcLyhl166rSdIWUGEzTbP8bZGbLx2fHAv/y6wg?=
 =?Windows-1252?Q?EeJkOl5oaT8a/dLzwx9TcXvrpkzJeKejb3djAhdCLUxwvvF0ADtam8QX?=
 =?Windows-1252?Q?2O6H2plXvZIl/zHEK0uYfwt66CdRF3eOJOXB7hwytws3b8VVPPfXmnEo?=
 =?Windows-1252?Q?GosoeLYZOGWl8Sxh+frxOM4fZt+1SiiclYv4R4QErEQibMuWCGqkCHlj?=
 =?Windows-1252?Q?bUyFmoGDKJ0m9SAJaHnqEgosYxRfzgORy365x+zmm+UatqbryBVoq/f6?=
 =?Windows-1252?Q?ClMtwPMlAXKUK9SM2eK9zZtcAvKmxzUWv5QQiSrfmnerZysAl711QEXt?=
 =?Windows-1252?Q?0nw+XTW0Ia5kvzhz0B3Lg7z4R/u0e6BQbuUTRnZVrvPv9Hey+OgQCx1r?=
 =?Windows-1252?Q?tRzQSZHWmKVVh2i+XveZkT56BmRaWd6M3N42O+jxkOM0BW73SmQ2XFQC?=
 =?Windows-1252?Q?EEsrzp2FPsaoF8mMLotooHtlHBt1c0+3/hi2iejGxs1WLrx4rJaJyfcB?=
 =?Windows-1252?Q?GcU0JJXKzBaBU6ha4kvmd+Vi+CXbhXY933NsiJmNY8MZXBWpVTFh91of?=
 =?Windows-1252?Q?bHWhYs1wWRzSaN5H/IkeAR4rwurMlbm5f3I2p8uD5yQpp8egHJe3SDWc?=
 =?Windows-1252?Q?1L4o4IScm1tmjPDv666Pxw6csBgwpTKp+isYW4I4M4mwRdRdyjZi3Ni1?=
 =?Windows-1252?Q?qwzTCj76sSGl1o+f77uKIRy0g3g8eNH2NYD0tTV90MVTlUJxS4HCyACM?=
 =?Windows-1252?Q?gFaIVvgsnjhVQx5E7k/ImTeBATblKpFxchGO30pu+utInHG3hblUnPXH?=
 =?Windows-1252?Q?A/oHlspOAlzmu6IZEB5sHngxsMUzW7qJgeTxnnLtV+/j4U0ENLHUyoC7?=
 =?Windows-1252?Q?QN61Mp1w6NnlOycfOPa26vR+T+VM6I6vBM/veeb4hyidPmdmx+FuKzca?=
 =?Windows-1252?Q?oToRDUP0w5tDUio5Rdc/UwmBun7jKaPZaqp/OYrEGYR/XGpDvCcVpFge?=
 =?Windows-1252?Q?DszME9/3WaYDAOOLNyrQ/OpgSWLYweptMBZs7DjAIVRtAWCReX6KtHz5?=
 =?Windows-1252?Q?nyDbh4NCcPXvrFx3uoCs6LDm1zseEse5tJntk8GBfCtELMv3g2CFvIXt?=
 =?Windows-1252?Q?kMV8+B4pF5/bDKHZ6jfF/PiT6XxH3jOmzvr7IObBrYXAWFMltHgvWXqP?=
 =?Windows-1252?Q?olo1eggFMr78b2d+gY2wvdGftdr00rBcR6wOVR7lVAybVv4CWgzrbtI/?=
 =?Windows-1252?Q?ovrKZweuRDJ74mt++qNCWs6jc3EzCgR8Lb749nGxVbGFwdHr1XwF6/tp?=
 =?Windows-1252?Q?wdQ84Pgic1ZYndYG+4YpgJBVzInxbWjBdwXQyEvrt/P38j1sQQJmjTCy?=
 =?Windows-1252?Q?NrcIY3X0vDTnlOrQWardPO75ma6UQ47pez+4Q9il4SW6BrUNRqiVZhsh?=
 =?Windows-1252?Q?VMG4Rr/iCoLS6QtkV+NPhnHdKme7HcZIRzS3eG4QQHOy6Tgo4wuOYZfM?=
 =?Windows-1252?Q?fmu9pIs/Uhjp2L6NllHOKsJEBHb2Ny6BWK7gO/DDTUIuAWOTMD7hReqo?=
 =?Windows-1252?Q?BDGuhb47zevnmuyjbQtcc9+KVjeXIL/fXAVVcpa59IZVPA0qxPvB9HC7?=
 =?Windows-1252?Q?uq2o1GzPBmd7GA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PSAP153MB0517AFB4B9CF54A17CD5223EB7E69PSAP153MB0517APCP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAP153MB0517.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da79517-7f2a-45ed-31c5-08da18a8827f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 15:08:44.5043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 61G1DZlVpElqc+xarz+LtLdASNICihP21/Mj6bgrjF8OA1Kc2pmJSjsyRxzqIe+F7J2HihlrBHBBNls8Sk28gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HKAP153MB0354
X-Mailman-Approved-At: Thu, 07 Apr 2022 15:10:15 +0000
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
Cc: Ziyue Yang <Ziyue.Yang@microsoft.com>, Lei Qu <Lei.Qu@microsoft.com>,
 Peng Cheng <pengc@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PSAP153MB0517AFB4B9CF54A17CD5223EB7E69PSAP153MB0517APCP_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Joshi,

Per your comment, I produced a fix to work with multi-GPU system for hotplu=
g support for our group=92s internal usage.

I have tested on a 4-node MI100 system, which seems to be working. It is pu=
shed in the github PR.
The details are in: https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver=
/pull/131#issuecomment-1091843803

I will send the patch to the mail-list also.

May I know when your patch is ready for public review?

All the best,
Shuotao


From: Joshi, Mukul <Mukul.Joshi@amd.com>
Date: Thursday, April 7, 2022 at 10:24 AM
To: Shuotao Xu <shuotaoxu@microsoft.com>, Grodzovsky, Andrey <Andrey.Grodzo=
vsky@amd.com>, amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org=
>
Cc: Ziyue Yang <Ziyue.Yang@microsoft.com>, Lei Qu <Lei.Qu@microsoft.com>, P=
eng Cheng <pengc@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>
Subject: RE: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
You don't often get email from mukul.joshi@amd.com. Learn why this is impor=
tant<http://aka.ms/LearnAboutSenderIdentification>

[AMD Official Use Only]

Hi Shuotao,

Thanks for your patch.
I have been working on something similar as I also found that we don=92t cl=
eanup IO links upon device removal.

The IO-links cleanup change in your patch would work only either on a singl=
e GPU system or a multi-GPU system where the last node (in the sysfs topolo=
gy) is hot-plugged out. That=92s because of the way the atomic counter, top=
ology_crat_proximity_domain, is used in the code.

I have a patch which takes care of these issues on a multi-GPU system.
I should be able to send that out for review in sometime.

Thanks,
Mukul

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Shuotao =
Xu
Sent: Wednesday, April 6, 2022 11:12 AM
To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Ziyue Yang <Ziyue.Yang@microsoft.com>; Lei Qu <Lei.Qu@microsoft.com>; P=
eng Cheng <pengc@microsoft.com>; Ran Shu <Ran.Shu@microsoft.com>
Subject: Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support

[CAUTION: External Email]
Hi Andrey,

Thanks for your kind comment on linux patch submission protocol, please let=
 me know if there is anyway to rectify it.

dmesg is fine except with some warning during pci rescan after pci removal =
of an AMD MI100.

The issue is that after this rocm application will return segfault with the=
 amdgpu driver unless the entire amdgpu kernel module is unloaded and loade=
d, which we did not meet our hotplug requirement. The issues upon investiga=
tion are
1) kfd_lock is locked after hotplug, and kfd_open will return fault right a=
way to libhsakmt .
2) iolink/p2plink has anormalies after hotplug, and libhsakmt will found su=
ch anomalies and return error.

Our patch has been tested with a single-instance AMD MI100 GPU and showed i=
t worked.

I am attaching the dmesg after rescan anyway, which will show the warning a=
nd the segfault.

[  132.054822] pci 0000:43:00.0: [1002:738c] type 00 class 0x038000
[  132.054856] pci 0000:43:00.0: reg 0x10: [mem 0x38b000000000-0x38b7ffffff=
ff 64bit pref]
[  132.054877] pci 0000:43:00.0: reg 0x18: [mem 0x38b800000000-0x38b8001fff=
ff 64bit pref]
[  132.054890] pci 0000:43:00.0: reg 0x20: [io  0xa000-0xa0ff]
[  132.054904] pci 0000:43:00.0: reg 0x24: [mem 0xb8400000-0xb847ffff]
[  132.054918] pci 0000:43:00.0: reg 0x30: [mem 0xb8480000-0xb849ffff pref]
[  132.055134] pci 0000:43:00.0: PME# supported from D1 D2 D3hot D3cold
[  132.055217] pci 0000:43:00.0: 63.008 Gb/s available PCIe bandwidth, limi=
ted by 8.0 GT/s PCIe x8 link at 0000:3c:14.0 (capable of 252.048 Gb/s with =
16.0 GT/s PCIe x16 link)
[  132.056001] pci 0000:43:00.0: Adding to iommu group 73
[  132.057943] pci 0000:43:00.0: BAR 0: assigned [mem 0x38b000000000-0x38b7=
ffffffff 64bit pref]
[  132.057960] pci 0000:43:00.0: BAR 2: assigned [mem 0x38b800000000-0x38b8=
001fffff 64bit pref]
[  132.057974] pci 0000:43:00.0: BAR 5: assigned [mem 0xb8400000-0xb847ffff=
]
[  132.057981] pci 0000:43:00.0: BAR 6: assigned [mem 0xb8480000-0xb849ffff=
 pref]
[  132.057984] pci 0000:43:00.0: BAR 4: assigned [io  0xa000-0xa0ff]

[  132.058429] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  132.058453] WARNING: possible circular locking dependency detected
[  132.058477] 5.16.0-kfd+ #1 Not tainted
[  132.058492] ------------------------------------------------------
[  132.058515] bash/3632 is trying to acquire lock:
[  132.058534] ffffadee20adfb50 ((work_completion)(&wfc.work)){+.+.}-{0:0},=
 at: __flush_work+0x2f5/0x470
[  132.058554] [drm] initializing kernel modesetting (ARCTURUS 0x1002:0x738=
C 0x1002:0x0C34 0x01).
[  132.058577]
               but task is already holding lock:
[  132.058580] ffffffffa3c62308
[  132.058630] amdgpu 0000:43:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re not supported
[  132.058638]  (
[  132.058678] [drm] register mmio base: 0xB8400000
[  132.058683] pci_rescan_remove_lock
[  132.058694] [drm] register mmio size: 524288
[  132.058713] ){+.+.}-{3:3}, at: rescan_store+0x55/0x90
[  132.058773]
               which lock already depends on the new lock.

[  132.058804]
               the existing dependency chain (in reverse order) is:
[  132.058819] [drm] add ip block number 0 <soc15_common>
[  132.058831]
               -> #1 (
[  132.058854] [drm] add ip block number 1 <gmc_v9_0>
[  132.058858] [drm] add ip block number 2 <vega20_ih>
[  132.058874] pci_rescan_remove_lock
[  132.058894] [drm] add ip block number 3 <psp>
[  132.058915] ){+.+.}-{3:3}
[  132.058931] [drm] add ip block number 4 <smu>
[  132.058951] :
[  132.058965] [drm] add ip block number 5 <gfx_v9_0>
[  132.058986]        __mutex_lock+0xa4/0x990
[  132.058996] [drm] add ip block number 6 <sdma_v4_0>
[  132.059016]        i801_add_tco_spt.isra.20+0x2a/0x1a0
[  132.059033] [drm] add ip block number 7 <vcn_v2_5>
[  132.059054]        i801_add_tco+0xf6/0x110
[  132.059075] [drm] add ip block number 8 <jpeg_v2_5>
[  132.059096]        i801_probe+0x402/0x860
[  132.059151]        local_pci_probe+0x40/0x90
[  132.059170]        work_for_cpu_fn+0x10/0x20
[  132.059189]        process_one_work+0x2a4/0x640
[  132.059208]        worker_thread+0x228/0x3f0
[  132.059227]        kthread+0x16d/0x1a0
[  132.059795]        ret_from_fork+0x1f/0x30
[  132.060337]
               -> #0 ((work_completion)(&wfc.work)){+.+.}-{0:0}:
[  132.061405]        __lock_acquire+0x1552/0x1ac0
[  132.061950]        lock_acquire+0x26c/0x300
[  132.062484]        __flush_work+0x315/0x470
[  132.063009]        work_on_cpu+0x98/0xc0
[  132.063526]        pci_device_probe+0x1bc/0x1d0
[  132.064036]        really_probe+0x102/0x450
[  132.064532]        __driver_probe_device+0x100/0x170
[  132.065020]        driver_probe_device+0x1f/0xa0
[  132.065497]        __device_attach_driver+0x6b/0xe0
[  132.065975]        bus_for_each_drv+0x6a/0xb0
[  132.066449]        __device_attach+0xe2/0x160
[  132.066912]        pci_bus_add_device+0x4a/0x80
[  132.067365]        pci_bus_add_devices+0x2c/0x70
[  132.067812]        pci_bus_add_devices+0x65/0x70
[  132.068253]        pci_bus_add_devices+0x65/0x70
[  132.068688]        pci_bus_add_devices+0x65/0x70
[  132.068936] amdgpu 0000:43:00.0: amdgpu: Fetched VBIOS from ROM BAR
[  132.069109]        pci_bus_add_devices+0x65/0x70
[  132.069602] amdgpu: ATOM BIOS: 113-D3431401-X00
[  132.070058]        pci_bus_add_devices+0x65/0x70
[  132.070572] [drm] VCN(0) decode is enabled in VM mode
[  132.070997]        pci_rescan_bus+0x23/0x30
[  132.071000]        rescan_store+0x61/0x90
[  132.071003]        kernfs_fop_write_iter+0x132/0x1b0
[  132.071501] [drm] VCN(1) decode is enabled in VM mode
[  132.071964]        new_sync_write+0x11f/0x1b0
[  132.072432] [drm] VCN(0) encode is enabled in VM mode
[  132.072900]        vfs_write+0x35b/0x3b0
[  132.073376] [drm] VCN(1) encode is enabled in VM mode
[  132.073847]        ksys_write+0xa7/0xe0
[  132.074335] [drm] JPEG(0) JPEG decode is enabled in VM mode
[  132.074803]        do_syscall_64+0x34/0x80
[  132.074808]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  132.074811]
               other info that might help us debug this:

[  132.074813]  Possible unsafe locking scenario:

[  132.075302] [drm] JPEG(1) JPEG decode is enabled in VM mode
[  132.075779]        CPU0                    CPU1
[  132.076361] amdgpu 0000:43:00.0: amdgpu: MEM ECC is active.
[  132.076765]        ----                    ----
[  132.077265] amdgpu 0000:43:00.0: amdgpu: SRAM ECC is active.
[  132.078649]   lock(pci_rescan_remove_lock);
[  132.078652]                                lock((work_completion)(&wfc.w=
ork));
[  132.078653]                                lock(pci_rescan_remove_lock);
[  132.078655]   lock((work_completion)(&wfc.work));
[  132.078656]
                *** DEADLOCK ***

[  132.078656] 5 locks held by bash/3632:
[  132.078658]  #0: ffff9c39c7b89438
[  132.079612] amdgpu 0000:43:00.0: amdgpu: RAS INFO: ras initialized succe=
ssfully, hardware ability[7fff] ras_mask[7fff]
[  132.080089]  (
[  132.080602] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, f=
ragment size is 9-bit
[  132.081082] sb_writers
[  132.081601] amdgpu 0000:43:00.0: amdgpu: VRAM: 32752M 0x0000008000000000=
 - 0x00000087FEFFFFFF (32752M used)
[  132.082102] #6
[  132.082630] amdgpu 0000:43:00.0: amdgpu: GART: 512M 0x0000000000000000 -=
 0x000000001FFFFFFF
[  132.083152] ){.+.+}-{0:0}
[  132.083687] amdgpu 0000:43:00.0: amdgpu: AGP: 267878400M 0x0000008800000=
000 - 0x0000FFFFFFFFFFFF
[  132.084210] , at: ksys_write+0xa7/0xe0
[  132.085708] [drm] Detected VRAM RAM=3D32752M, BAR=3D32768M
[  132.086205]  #1:
[  132.086733] [drm] RAM width 4096bits HBM
[  132.087269] ffff9c5959011088
[  132.087890] [drm] amdgpu: 32752M of VRAM memory ready
[  132.088389]  (
[  132.088972] [drm] amdgpu: 32752M of GTT memory ready.
[  132.089572] &of->mutex
[  132.090206] [drm] GART: num cpu pages 131072, num gpu pages 131072
[  132.090804] ){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x103/0x1b0
[  132.090808]  #2: ffff9c39c882a9e0 (kn->active#423){.+.+}-{0:0}, at: kern=
fs_fop_write_iter+0x10c/0x1b0
[  132.091639] [drm] PCIE GART of 512M enabled.
[  132.092117]  #3:
[  132.092801] [drm] PTB located at 0x0000008000000000
[  132.093480] ffffffffa3c62308
[  132.094566] amdgpu 0000:43:00.0: amdgpu: PSP runtime database doesn't ex=
ist
[  132.094822]  (pci_rescan_remove_lock){+.+.}-{3:3}, at: rescan_store+0x55=
/0x90
[  132.094827]  #4: ffff9c597392b248 (&dev->mutex){....}-{3:3}, at: __devic=
e_attach+0x39/0x160
[  132.094835]
               stack backtrace:
[  132.097098] [drm] Found VCN firmware Version ENC: 1.1 DEC: 1 VEP: 0 Revi=
sion: 21
[  132.097467] CPU: 47 PID: 3632 Comm: bash Not tainted 5.16.0-kfd+ #1
[  132.098169] amdgpu 0000:43:00.0: amdgpu: Will use PSP to load VCN firmwa=
re
[  132.098839] Hardware name: Supermicro SYS-4029GP-TRT2/X11DPG-OT-CPU, BIO=
S 2.1 08/14/2018
[  132.098841] Call Trace:
[  132.098842]  <TASK>
[  132.098843]  dump_stack_lvl+0x44/0x57
[  132.098848]  check_noncircular+0x105/0x120
[  132.098853]  ? unwind_get_return_address+0x1b/0x30
[  132.112924]  ? register_lock_class+0x46/0x780
[  132.113630]  ? __lock_acquire+0x1552/0x1ac0
[  132.114342]  __lock_acquire+0x1552/0x1ac0
[  132.115050]  lock_acquire+0x26c/0x300
[  132.115755]  ? __flush_work+0x2f5/0x470
[  132.116460]  ? lock_is_held_type+0xdf/0x130
[  132.117177]  __flush_work+0x315/0x470
[  132.117890]  ? __flush_work+0x2f5/0x470
[  132.118604]  ? lock_is_held_type+0xdf/0x130
[  132.119305]  ? mark_held_locks+0x49/0x70
[  132.119981]  ? queue_work_on+0x2f/0x70
[  132.120645]  ? lockdep_hardirqs_on+0x79/0x100
[  132.121300]  work_on_cpu+0x98/0xc0
[  132.121702] [drm] reserve 0x400000 from 0x87fec00000 for PSP TMR
[  132.121947]  ? __traceiter_workqueue_execute_end+0x40/0x40
[  132.123270]  ? pci_device_shutdown+0x60/0x60
[  132.123880]  pci_device_probe+0x1bc/0x1d0
[  132.124475]  really_probe+0x102/0x450
[  132.125060]  __driver_probe_device+0x100/0x170
[  132.125641]  driver_probe_device+0x1f/0xa0
[  132.126215]  __device_attach_driver+0x6b/0xe0
[  132.126797]  ? driver_allows_async_probing+0x50/0x50
[  132.127383]  ? driver_allows_async_probing+0x50/0x50
[  132.127960]  bus_for_each_drv+0x6a/0xb0
[  132.128528]  __device_attach+0xe2/0x160
[  132.129095]  pci_bus_add_device+0x4a/0x80
[  132.129659]  pci_bus_add_devices+0x2c/0x70
[  132.130213]  pci_bus_add_devices+0x65/0x70
[  132.130753]  pci_bus_add_devices+0x65/0x70
[  132.131283]  pci_bus_add_devices+0x65/0x70
[  132.131780]  pci_bus_add_devices+0x65/0x70
[  132.132270]  pci_bus_add_devices+0x65/0x70
[  132.132757]  pci_rescan_bus+0x23/0x30
[  132.133233]  rescan_store+0x61/0x90
[  132.133701]  kernfs_fop_write_iter+0x132/0x1b0
[  132.134167]  new_sync_write+0x11f/0x1b0
[  132.134627]  vfs_write+0x35b/0x3b0
[  132.135062]  ksys_write+0xa7/0xe0
[  132.135503]  do_syscall_64+0x34/0x80
[  132.135933]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  132.136358] RIP: 0033:0x7f0058a73224
[  132.136775] Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 =
00 00 66 90 48 8d 05 c1 07 2e 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 89 f5
[  132.137663] RSP: 002b:00007ffc4f4c71a8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[  132.138121] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f0058a=
73224
[  132.138590] RDX: 0000000000000002 RSI: 000055d466c24450 RDI: 00000000000=
00001
[  132.139064] RBP: 000055d466c24450 R08: 000000000000000a R09: 00000000000=
00001
[  132.139532] R10: 000000000000000a R11: 0000000000000246 R12: 00007f0058d=
4f760
[  132.140003] R13: 0000000000000002 R14: 00007f0058d4b2a0 R15: 00007f0058d=
4a760
[  132.140485]  </TASK>
[  132.183669] amdgpu 0000:43:00.0: amdgpu: HDCP: optional hdcp ta ucode is=
 not available
[  132.184214] amdgpu 0000:43:00.0: amdgpu: DTM: optional dtm ta ucode is n=
ot available
[  132.184735] amdgpu 0000:43:00.0: amdgpu: RAP: optional rap ta ucode is n=
ot available
[  132.185234] amdgpu 0000:43:00.0: amdgpu: SECUREDISPLAY: securedisplay ta=
 ucode is not available
[  132.185823] amdgpu 0000:43:00.0: amdgpu: use vbios provided pptable
[  132.186327] amdgpu 0000:43:00.0: amdgpu: smc_dpm_info table revision(for=
mat.content): 4.6
[  132.188783] amdgpu 0000:43:00.0: amdgpu: SMU is initialized successfully=
!
[  132.190039] [drm] kiq ring mec 2 pipe 1 q 0
[  132.203608] [drm] VCN decode and encode initialized successfully(under D=
PG Mode).
[  132.204178] [drm] JPEG decode initialized successfully.
[  132.246079] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[  132.327589] memmap_init_zone_device initialised 8388608 pages in 64ms
[  132.328139] amdgpu: HMM registered 32752MB device memory
[  132.328784] amdgpu: Virtual CRAT table created for GPU
[  132.329844] amdgpu: Topology: Add dGPU node [0x738c:0x1002]
[  132.330387] kfd kfd: amdgpu: added device 1002:738c
[  132.330965] amdgpu 0000:43:00.0: amdgpu: SE 8, SH per SE 1, CU per SH 16=
, active_cu_number 72
[  132.331725] amdgpu 0000:43:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 0 on hub 0
[  132.332296] amdgpu 0000:43:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 1 on hub 0
[  132.332856] amdgpu 0000:43:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 4 on hub 0
[  132.333414] amdgpu 0000:43:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 5 on hub 0
[  132.333965] amdgpu 0000:43:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 6 on hub 0
[  132.334507] amdgpu 0000:43:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 7 on hub 0
[  132.335057] amdgpu 0000:43:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 8 on hub 0
[  132.335594] amdgpu 0000:43:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 9 on hub 0
[  132.336137] amdgpu 0000:43:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng =
10 on hub 0
[  132.336679] amdgpu 0000:43:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on=
 hub 1
[  132.337234] amdgpu 0000:43:00.0: amdgpu: ring sdma1 uses VM inv eng 1 on=
 hub 1
[  132.337790] amdgpu 0000:43:00.0: amdgpu: ring sdma2 uses VM inv eng 4 on=
 hub 1
[  132.338343] amdgpu 0000:43:00.0: amdgpu: ring sdma3 uses VM inv eng 5 on=
 hub 1
[  132.338906] amdgpu 0000:43:00.0: amdgpu: ring sdma4 uses VM inv eng 6 on=
 hub 1
[  132.339448] amdgpu 0000:43:00.0: amdgpu: ring sdma5 uses VM inv eng 0 on=
 hub 2
[  132.339987] amdgpu 0000:43:00.0: amdgpu: ring sdma6 uses VM inv eng 1 on=
 hub 2
[  132.340519] amdgpu 0000:43:00.0: amdgpu: ring sdma7 uses VM inv eng 4 on=
 hub 2
[  132.341041] amdgpu 0000:43:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng =
5 on hub 2
[  132.341570] amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv en=
g 6 on hub 2
[  132.342101] amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv en=
g 7 on hub 2
[  132.342630] amdgpu 0000:43:00.0: amdgpu: ring vcn_dec_1 uses VM inv eng =
8 on hub 2
[  132.343152] amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_1.0 uses VM inv en=
g 9 on hub 2
[  132.343657] amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_1.1 uses VM inv en=
g 10 on hub 2
[  132.344136] amdgpu 0000:43:00.0: amdgpu: ring jpeg_dec_0 uses VM inv eng=
 11 on hub 2
[  132.344610] amdgpu 0000:43:00.0: amdgpu: ring jpeg_dec_1 uses VM inv eng=
 12 on hub 2
[  132.378213] amdgpu: Detected AMDGPU 6 Perf Events.
[  132.387349] [drm] Initialized amdgpu 3.46.0 20150101 for 0000:43:00.0 on=
 minor 1
[  132.388530] pcieport 0000:d7:00.0: bridge window [io  0x1000-0x0fff] to =
[bus d8] add_size 1000
[  132.389078] pcieport 0000:d7:00.0: BAR 13: no space for [io  size 0x1000=
]
[  132.389600] pcieport 0000:d7:00.0: BAR 13: failed to assign [io  size 0x=
1000]
[  132.390091] pcieport 0000:d7:00.0: BAR 13: no space for [io  size 0x1000=
]
[  132.390568] pcieport 0000:d7:00.0: BAR 13: failed to assign [io  size 0x=
1000]
[  155.359200] HelloWorld[3824]: segfault at 68 ip 00007f4c979f764e sp 0000=
7ffc9b3bb610 error 4 in libamdhip64.so.4.4.21432-f9dccde4[7f4c979b3000+2eb0=
00]
[  155.360268] Code: 48 8b 45 e8 64 48 33 04 25 28 00 00 00 74 05 e8 b8 c7 =
fb ff 48 8b 5d f8 c9 c3 f3 0f 1e fa 55 48 89 e5 48 89 7d f8 48 8b 45 f8 <48=
> 8b 40 68 5d c3 f3 0f 1e fa 55 48 89 e5 48 89 7d f8 48 8b 45 f8

Best regards,
Shuotao

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com<mailto:andrey.grodzovsky=
@amd.com>>
Date: Wednesday, April 6, 2022 at 10:36 PM
To: Shuotao Xu <shuotaoxu@microsoft.com<mailto:shuotaoxu@microsoft.com>>, a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Ziyue Yang <Ziyue.Yang@microsoft.com<mailto:Ziyue.Yang@microsoft.com>>,=
 Lei Qu <Lei.Qu@microsoft.com<mailto:Lei.Qu@microsoft.com>>, Peng Cheng <pe=
ngc@microsoft.com<mailto:pengc@microsoft.com>>, Ran Shu <Ran.Shu@microsoft.=
com<mailto:Ran.Shu@microsoft.com>>
Subject: Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
[You don't often get email from andrey.grodzovsky@amd.com<mailto:andrey.gro=
dzovsky@amd.com>. Learn why this is important at http://aka.ms/LearnAboutSe=
nderIdentification.]<https://nam06.safelinks.protection.outlook.com/?url=3D=
http%3A%2F%2Faka.ms%2FLearnAboutSenderIdentification.%255d&data=3D05%7C01%7=
Cshuotaoxu%40microsoft.com%7Ca782bea4842e45f15b7408da183d85b4%7C72f988bf86f=
141af91ab2d7cd011db47%7C1%7C0%7C637848950411722793%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7=
C%7C%7C&sdata=3DoY6DZbPB%2BJZSSDdMNg4s44cRc4TnT20Vtew%2Fw4Uziq8%3D&reserved=
=3D0>

Can you attach dmesg for the failure without your patch against
amd-staging-drm-next ?

Also, in general, patches for amdgpu upstream branches should be
submitted to amd-gfx mailing list inline using git-send which makes it
easy to comment and review them inline.

Andrey

On 2022-04-06 10:25, Shuotao Xu wrote:
> Hi Andrey,
>
> We just tried kernel 5.16 based on
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b.freedesktop.org%2Fagd5f%2Flinux.git&amp;data=3D05%7C01%7Cshuotaoxu%40micr=
osoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd011=
db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM=
DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=
=3Djz51aMtsG7PIEfLy1jLvLGd%2BsBREvOFf9Gc6BZlmsmU%3D&amp;reserved=3D0<https:=
//nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.freede=
sktop.org%2Fagd5f%2Flinux.git&data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C=
a782bea4842e45f15b7408da183d85b4%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0=
%7C637848950411722793%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV=
2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DssS4iNDEer0H%=
2FkK1N34xiC76v3TKv4GNYYWvlELU670%3D&reserved=3D0>
> <https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitl=
ab.freedesktop.org%2Fagd5f%2Flinux.git&amp;data=3D05%7C01%7Cshuotaoxu%40mic=
rosoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd01=
1db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw=
MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdat=
a=3Djz51aMtsG7PIEfLy1jLvLGd%2BsBREvOFf9Gc6BZlmsmU%3D&amp;reserved=3D0<https=
://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.freed=
esktop.org%2Fagd5f%2Flinux.git&data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7=
Ca782bea4842e45f15b7408da183d85b4%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C=
0%7C637848950411722793%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DssS4iNDEer0H=
%2FkK1N34xiC76v3TKv4GNYYWvlELU670%3D&reserved=3D0>>
> amd-staging-drm-next branch, and found out that hotplug did not work out
> of box for Rocm compute stack.
>
> We did not try the rendering stack since we currently are more focused
> on AI workloads.
>
> We have also created a patch against the amd-staging-drm-next branch to
> enable hotplug for ROCM stack, which were sent in another later email
> with same subject. I am attaching the patch in this email, in case that
> you would want to delete that later email.
>
> Best regards,
>
> Shuotao
>
> *From: *Andrey Grodzovsky <andrey.grodzovsky@amd.com<mailto:andrey.grodzo=
vsky@amd.com>>
> *Date: *Wednesday, April 6, 2022 at 10:13 PM
> *To: *Shuotao Xu <shuotaoxu@microsoft.com<mailto:shuotaoxu@microsoft.com>=
>,
> amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
> *Cc: *Ziyue Yang <Ziyue.Yang@microsoft.com<mailto:Ziyue.Yang@microsoft.co=
m>>, Lei Qu
> <Lei.Qu@microsoft.com<mailto:Lei.Qu@microsoft.com>>, Peng Cheng <pengc@mi=
crosoft.com<mailto:pengc@microsoft.com>>, Ran Shu
> <Ran.Shu@microsoft.com<mailto:Ran.Shu@microsoft.com>>
> *Subject: *[EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
>
> [You don't often get email from andrey.grodzovsky@amd.com<mailto:andrey.g=
rodzovsky@amd.com>. Learn why
> this is important at http://aka.ms/LearnAboutSenderIdentification.]<https=
://nam06.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Faka.ms%2FLear=
nAboutSenderIdentification.%255d&data=3D05%7C01%7Cshuotaoxu%40microsoft.com=
%7Ca782bea4842e45f15b7408da183d85b4%7C72f988bf86f141af91ab2d7cd011db47%7C1%=
7C0%7C637848950411722793%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj=
oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DoY6DZbPB%2=
BJZSSDdMNg4s44cRc4TnT20Vtew%2Fw4Uziq8%3D&reserved=3D0>
> <https://nam06.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Faka.m=
s%2FLearnAboutSenderIdentification.%255d&amp;data=3D05%7C01%7Cshuotaoxu%40m=
icrosoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd=
011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sd=
ata=3DHfSwu6SWfoCYyscJqGFdKHBPtaj%2BKB4lyo13zkm6hi4%3D&amp;reserved=3D0<htt=
ps://nam06.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Faka.ms%2FLe=
arnAboutSenderIdentification.%255d&data=3D05%7C01%7Cshuotaoxu%40microsoft.c=
om%7Ca782bea4842e45f15b7408da183d85b4%7C72f988bf86f141af91ab2d7cd011db47%7C=
1%7C0%7C637848950411722793%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ=
IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DoY6DZbPB=
%2BJZSSDdMNg4s44cRc4TnT20Vtew%2Fw4Uziq8%3D&reserved=3D0>>
>
> Looks like you are using 5.13 kernel for this work, FYI we added
> hot plug support for the graphic stack in 5.14 kernel (see
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.p=
horonix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU-Hot-Unpl=
ug&amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308d=
a17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7=
CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi=
LCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D4l9mT8zNR%2FvqsEFr7noIDqKf16IGN8=
xmO2T6jnpipzo%3D&amp;reserved=3D0)<https://nam06.safelinks.protection.outlo=
ok.com/?url=3Dhttps%3A%2F%2Fwww.phoronix.com%2Fscan.php%3Fpage%3Dnews_item%=
26px%3DLinux-5.14-AMDGPU-Hot-Unplug&data=3D05%7C01%7Cshuotaoxu%40microsoft.=
com%7Ca782bea4842e45f15b7408da183d85b4%7C72f988bf86f141af91ab2d7cd011db47%7=
C1%7C0%7C637848950411722793%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ=
QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D2nCzwhL=
%2Bg8GIJ3WlDacVB6Rbb1hAtHRHhfihZRStzuI%3D&reserved=3D0>
> <https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.=
phoronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU-Hot-Unp=
lug&amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308=
da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%=
7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw=
iLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D4l9mT8zNR%2FvqsEFr7noIDqKf16IGN=
8xmO2T6jnpipzo%3D&amp;reserved=3D0<https://nam06.safelinks.protection.outlo=
ok.com/?url=3Dhttps%3A%2F%2Fwww.phoronix.com%2Fscan.php%3Fpage%3Dnews_item%=
26px%3DLinux-5.14-AMDGPU-Hot-Unplug&data=3D05%7C01%7Cshuotaoxu%40microsoft.=
com%7Ca782bea4842e45f15b7408da183d85b4%7C72f988bf86f141af91ab2d7cd011db47%7=
C1%7C0%7C637848950411722793%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ=
QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D2nCzwhL=
%2Bg8GIJ3WlDacVB6Rbb1hAtHRHhfihZRStzuI%3D&reserved=3D0>>
>
>
> I am not sure about the code part since it all touches KFD driver (KFD
> team can comment on that) - but I was just wondering if you try 5.14
> kernel would things just work for you out of the box ?
>
> Andrey
>
> On 2022-04-05 22:45, Shuotao Xu wrote:
>> Dear AMD Colleagues,
>>
>> We are from Microsoft Research, and are working on GPU disaggregation
>> technology.
>>
>> We have created a new pull requestAdd PCIe hotplug support for amdgpu by
>> xushuotao =B7 Pull Request #131 =B7 RadeonOpenCompute/ROCK-Kernel-Driver
>> (github.com)
>> <https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
hub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&amp;data=3D05=
%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f9=
88bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7=
C3000%7C%7C%7C&amp;sdata=3DqEeZR6R95jrjAaltd1MnpyFedOiVZaNQuCxcoNog90g%3D&a=
mp;reserved=3D0
<https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub=
.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&data=3D05%7C01%7=
Cshuotaoxu%40microsoft.com%7Ca782bea4842e45f15b7408da183d85b4%7C72f988bf86f=
141af91ab2d7cd011db47%7C1%7C0%7C637848950411722793%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7=
C%7C%7C&sdata=3DxvW04nplXWAZ7jxsTnABR1JKY7HcHw80nPYJPPpD%2BrI%3D&reserved=
=3D0>> <https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&amp;data=
=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7=
C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7C=
TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0=
%3D%7C3000%7C%7C%7C&amp;sdata=3DqEeZR6R95jrjAaltd1MnpyFedOiVZaNQuCxcoNog90g=
%3D&amp;reserved=3D0<https://nam06.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F=
131&data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7Ca782bea4842e45f15b7408da18=
3d85b4%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848950411772785%7CUn=
known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ=
XVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DEK5BHdupZ2UJsJXTAcYa5rAYoy3uCVvSrTH1uCO=
S1wQ%3D&reserved=3D0>>>in
>> ROCK-Kernel-Driver, which will enable PCIe hot-plug support for amdgpu.
>>
>> We believe the support of hot-plug of GPU devices can open doors for
>> many advanced applications in data center in the next few years, and we
>> would like to have some reviewers on this PR so we can continue further
>> technical discussions around this feature.
>>
>> Would you please help review this PR?
>>
>> Thank you very much!
>>
>> Best regards,
>>
>> Shuotao Xu
>>
>

--_000_PSAP153MB0517AFB4B9CF54A17CD5223EB7E69PSAP153MB0517APCP_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi Joshi,<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Per your comment, I=
 produced a fix to work with multi-GPU system for hotplug support for our g=
roup=92s internal usage.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I have tested on a =
4-node MI100 system, which seems to be working. It is pushed in the github =
PR.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">The details are in:=
 <a href=3D"https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver/pull/13=
1#issuecomment-1091843803">
https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver/pull/131#issuecomme=
nt-1091843803</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I will send the pat=
ch to the mail-list also.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">May I know when you=
r patch is ready for public review?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">All the best,<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Shuotao<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Joshi, Mukul &lt;Mu=
kul.Joshi@amd.com&gt;<br>
<b>Date: </b>Thursday, April 7, 2022 at 10:24 AM<br>
<b>To: </b>Shuotao Xu &lt;shuotaoxu@microsoft.com&gt;, Grodzovsky, Andrey &=
lt;Andrey.Grodzovsky@amd.com&gt;, amd-gfx@lists.freedesktop.org &lt;amd-gfx=
@lists.freedesktop.org&gt;<br>
<b>Cc: </b>Ziyue Yang &lt;Ziyue.Yang@microsoft.com&gt;, Lei Qu &lt;Lei.Qu@m=
icrosoft.com&gt;, Peng Cheng &lt;pengc@microsoft.com&gt;, Ran Shu &lt;Ran.S=
hu@microsoft.com&gt;<br>
<b>Subject: </b>RE: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug S=
upport<o:p></o:p></span></p>
</div>
<table class=3D"MsoNormalTable" border=3D"0" cellspacing=3D"0" cellpadding=
=3D"0" align=3D"left" width=3D"100%" style=3D"width:100.0%;cellpadding:0;ce=
llspacing:0;display:table;border-collapse:seperate;float:none">
<tbody>
<tr>
<td style=3D"background:#A6A6A6;padding:5.25pt 1.5pt 5.25pt 1.5pt;valign:mi=
ddle"></td>
<td width=3D"100%" style=3D"width:100.0%;background:#EAEAEA;padding:5.25pt =
3.75pt 5.25pt 11.25pt">
<div>
<p class=3D"MsoNormal" style=3D"mso-element:frame;mso-element-frame-hspace:=
2.25pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-el=
ement-anchor-horizontal:column;mso-height-rule:exactly">
<span style=3D"font-size:9.0pt;font-family:&quot;Segoe UI&quot;,sans-serif;=
color:#212121">You don't often get email from mukul.joshi@amd.com.
<a href=3D"http://aka.ms/LearnAboutSenderIdentification">Learn why this is =
important</a><o:p></o:p></span></p>
</div>
</td>
<td width=3D"75" style=3D"width:56.25pt;background:#EAEAEA;padding:5.25pt 3=
.75pt 5.25pt 3.75pt;align:left">
</td>
</tr>
</tbody>
</table>
<div>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi Shuotao,</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks for your pat=
ch.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I have been working=
 on something similar as I also found that we don=92t cleanup IO links upon=
 device removal.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">The IO-links cleanu=
p change in your patch would work only either on a single GPU system or a m=
ulti-GPU system where the last node (in the sysfs topology) is hot-plugged =
out. That=92s because of the way the atomic
 counter, topology_crat_proximity_domain, is used in the code.</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I have a patch whic=
h takes care of these issues on a multi-GPU system.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I should be able to=
 send that out for review in sometime.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks,</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Mukul</span><o:p></=
o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt">From:</span></b>=
<span style=3D"font-size:11.0pt"> amd-gfx &lt;amd-gfx-bounces@lists.freedes=
ktop.org&gt;
<b>On Behalf Of </b>Shuotao Xu<br>
<b>Sent:</b> Wednesday, April 6, 2022 11:12 AM<br>
<b>To:</b> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org<br>
<b>Cc:</b> Ziyue Yang &lt;Ziyue.Yang@microsoft.com&gt;; Lei Qu &lt;Lei.Qu@m=
icrosoft.com&gt;; Peng Cheng &lt;pengc@microsoft.com&gt;; Ran Shu &lt;Ran.S=
hu@microsoft.com&gt;<br>
<b>Subject:</b> Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug S=
upport</span><o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[CAUTION: External =
Email] </span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi Andrey,</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks for your kin=
d comment on linux patch submission protocol, please let me know if there i=
s anyway to rectify it.
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">dmesg is fine excep=
t with some warning during pci rescan after pci removal of an AMD MI100.
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">The issue is that a=
fter this rocm application will return segfault with the amdgpu driver unle=
ss the entire amdgpu kernel module is unloaded and loaded, which we did not=
 meet our hotplug requirement. The issues
 upon investigation are</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">1) kfd_lock is lock=
ed after hotplug, and kfd_open will return fault right away to libhsakmt .
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">2) iolink/p2plink h=
as anormalies after hotplug, and libhsakmt will found such anomalies and re=
turn error.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Our patch has been =
tested with a single-instance AMD MI100 GPU and showed it worked.</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I am attaching the =
dmesg after rescan anyway, which will show the warning and the segfault.</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.054822]=
 pci 0000:43:00.0: [1002:738c] type 00 class 0x038000</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.054856]=
 pci 0000:43:00.0: reg 0x10: [mem 0x38b000000000-0x38b7ffffffff 64bit pref]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.054877]=
 pci 0000:43:00.0: reg 0x18: [mem 0x38b800000000-0x38b8001fffff 64bit pref]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.054890]=
 pci 0000:43:00.0: reg 0x20: [io&nbsp; 0xa000-0xa0ff]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.054904]=
 pci 0000:43:00.0: reg 0x24: [mem 0xb8400000-0xb847ffff]</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.054918]=
 pci 0000:43:00.0: reg 0x30: [mem 0xb8480000-0xb849ffff pref]</span><o:p></=
o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.055134]=
 pci 0000:43:00.0: PME# supported from D1 D2 D3hot D3cold</span><o:p></o:p>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.055217]=
 pci 0000:43:00.0: 63.008 Gb/s available PCIe bandwidth, limited by 8.0 GT/=
s PCIe x8 link at 0000:3c:14.0 (capable of 252.048 Gb/s with 16.0 GT/s PCIe=
 x16 link)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.056001]=
 pci 0000:43:00.0: Adding to iommu group 73</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.057943]=
 pci 0000:43:00.0: BAR 0: assigned [mem 0x38b000000000-0x38b7ffffffff 64bit=
 pref]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.057960]=
 pci 0000:43:00.0: BAR 2: assigned [mem 0x38b800000000-0x38b8001fffff 64bit=
 pref]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.057974]=
 pci 0000:43:00.0: BAR 5: assigned [mem 0xb8400000-0xb847ffff]</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.057981]=
 pci 0000:43:00.0: BAR 6: assigned [mem 0xb8480000-0xb849ffff pref]</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.057984]=
 pci 0000:43:00.0: BAR 4: assigned [io&nbsp; 0xa000-0xa0ff]</span><o:p></o:=
p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058429]=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058453]=
 WARNING: possible circular locking dependency detected</span><o:p></o:p></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058477]=
 5.16.0-kfd+ #1 Not tainted</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058492]=
 ------------------------------------------------------</span><o:p></o:p></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058515]=
 bash/3632 is trying to acquire lock:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058534]=
 ffffadee20adfb50 ((work_completion)(&amp;wfc.work)){+.+.}-{0:0}, at: __flu=
sh_work+0x2f5/0x470</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058554]=
 [drm] initializing kernel modesetting (ARCTURUS 0x1002:0x738C 0x1002:0x0C3=
4 0x01).</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058577]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; but task =
is already holding lock:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058580]=
 ffffffffa3c62308</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058630]=
 amdgpu 0000:43:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not support=
ed</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058638]=
&nbsp; (</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058678]=
 [drm] register mmio base: 0xB8400000</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058683]=
 pci_rescan_remove_lock</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058694]=
 [drm] register mmio size: 524288</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058713]=
 ){+.+.}-{3:3}, at: rescan_store+0x55/0x90</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058773]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; which loc=
k already depends on the new lock.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058804]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the exist=
ing dependency chain (in reverse order) is:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058819]=
 [drm] add ip block number 0 &lt;soc15_common&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058831]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt; #1 =
(</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058854]=
 [drm] add ip block number 1 &lt;gmc_v9_0&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058858]=
 [drm] add ip block number 2 &lt;vega20_ih&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058874]=
 pci_rescan_remove_lock</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058894]=
 [drm] add ip block number 3 &lt;psp&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058915]=
 ){+.+.}-{3:3}</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058931]=
 [drm] add ip block number 4 &lt;smu&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058951]=
 :</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058965]=
 [drm] add ip block number 5 &lt;gfx_v9_0&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058986]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __mutex_lock+0xa4/0x990</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058996]=
 [drm] add ip block number 6 &lt;sdma_v4_0&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059016]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i801_add_tco_spt.isra.20+0x2a/0x=
1a0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059033]=
 [drm] add ip block number 7 &lt;vcn_v2_5&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059054]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i801_add_tco+0xf6/0x110</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059075]=
 [drm] add ip block number 8 &lt;jpeg_v2_5&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059096]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i801_probe+0x402/0x860</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059151]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; local_pci_probe+0x40/0x90</span>=
<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059170]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; work_for_cpu_fn+0x10/0x20</span>=
<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059189]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process_one_work+0x2a4/0x640</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059208]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; worker_thread+0x228/0x3f0</span>=
<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059227]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kthread+0x16d/0x1a0</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059795]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret_from_fork+0x1f/0x30</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.060337]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt; #0 =
((work_completion)(&amp;wfc.work)){+.+.}-{0:0}:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.061405]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __lock_acquire+0x1552/0x1ac0</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.061950]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock_acquire+0x26c/0x300</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.062484]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __flush_work+0x315/0x470</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.063009]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; work_on_cpu+0x98/0xc0</span><o:p=
></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.063526]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_device_probe+0x1bc/0x1d0</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.064036]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; really_probe+0x102/0x450</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.064532]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __driver_probe_device+0x100/0x17=
0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.065020]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; driver_probe_device+0x1f/0xa0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.065497]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __device_attach_driver+0x6b/0xe0=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.065975]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bus_for_each_drv+0x6a/0xb0</span=
><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.066449]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __device_attach+0xe2/0x160</span=
><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.066912]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_bus_add_device+0x4a/0x80</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.067365]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_bus_add_devices+0x2c/0x70</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.067812]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_bus_add_devices+0x65/0x70</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.068253]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_bus_add_devices+0x65/0x70</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.068688]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_bus_add_devices+0x65/0x70</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.068936]=
 amdgpu 0000:43:00.0: amdgpu: Fetched VBIOS from ROM BAR</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.069109]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;pci_bus_add_devices+0x65/0x70</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.069602]=
 amdgpu: ATOM BIOS: 113-D3431401-X00</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.070058]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_bus_add_devices+0x65/0x70</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.070572]=
 [drm] VCN(0) decode is enabled in VM mode</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.070997]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_rescan_bus+0x23/0x30</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.071000]=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rescan_store+0x61/0x90</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.071003]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernfs_fop_write_iter+0x132/0x1b=
0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.071501]=
 [drm] VCN(1) decode is enabled in VM mode</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.071964]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_sync_write+0x11f/0x1b0</span=
><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.072432]=
 [drm] VCN(0) encode is enabled in VM mode</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.072900]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vfs_write+0x35b/0x3b0</span><o:p=
></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.073376]=
 [drm] VCN(1) encode is enabled in VM mode</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.073847]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ksys_write+0xa7/0xe0</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.074335]=
 [drm] JPEG(0) JPEG decode is enabled in VM mode</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.074803]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_syscall_64+0x34/0x80</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.074808]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry_SYSCALL_64_after_hwframe+0=
x44/0xae</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.074811]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; other inf=
o that might help us debug this:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.074813]=
&nbsp; Possible unsafe locking scenario:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.075302]=
 [drm] JPEG(1) JPEG decode is enabled in VM mode</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.075779]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; CPU1</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.076361]=
 amdgpu 0000:43:00.0: amdgpu: MEM ECC is active.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.076765]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ----&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; ----</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.077265]=
 amdgpu 0000:43:00.0: amdgpu: SRAM ECC is active.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078649]=
&nbsp;&nbsp; lock(pci_rescan_remove_lock);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078652]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock((work_completion)(&amp;wfc.work))=
;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078653]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock(pci_rescan_remove_lock);</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078655]=
&nbsp;&nbsp; lock((work_completion)(&amp;wfc.work));</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078656]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ***=
 DEADLOCK ***</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078656]=
 5 locks held by bash/3632:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078658]=
&nbsp; #0: ffff9c39c7b89438</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.079612]=
 amdgpu 0000:43:00.0: amdgpu: RAS INFO: ras initialized successfully, hardw=
are ability[7fff] ras_mask[7fff]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.080089]=
&nbsp; (</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.080602]=
 [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size i=
s 9-bit</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.081082]=
 sb_writers</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.081601]=
 amdgpu 0000:43:00.0: amdgpu: VRAM: 32752M 0x0000008000000000 - 0x00000087F=
EFFFFFF (32752M used)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.082102]=
 #6</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.082630]=
 amdgpu 0000:43:00.0: amdgpu: GART: 512M 0x0000000000000000 - 0x000000001FF=
FFFFF</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.083152]=
 ){.+.+}-{0:0}</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.083687]=
 amdgpu 0000:43:00.0: amdgpu: AGP: 267878400M 0x0000008800000000 - 0x0000FF=
FFFFFFFFFF</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.084210]=
 , at: ksys_write+0xa7/0xe0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.085708]=
 [drm] Detected VRAM RAM=3D32752M, BAR=3D32768M</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.086205]=
&nbsp; #1:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.086733]=
 [drm] RAM width 4096bits HBM</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.087269]=
 ffff9c5959011088</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.087890]=
 [drm] amdgpu: 32752M of VRAM memory ready</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.088389]=
&nbsp; (</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.088972]=
 [drm] amdgpu: 32752M of GTT memory ready.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.089572]=
 &amp;of-&gt;mutex</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.090206]=
 [drm] GART: num cpu pages 131072, num gpu pages 131072</span><o:p></o:p></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.090804]=
 ){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x103/0x1b0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.090808]=
&nbsp; #2: ffff9c39c882a9e0 (kn-&gt;active#423){.+.+}-{0:0}, at: kernfs_fop=
_write_iter+0x10c/0x1b0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.091639]=
 [drm] PCIE GART of 512M enabled.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.092117]=
&nbsp; #3:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.092801]=
 [drm] PTB located at 0x0000008000000000</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.093480]=
 ffffffffa3c62308</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.094566]=
 amdgpu 0000:43:00.0: amdgpu: PSP runtime database doesn't exist</span><o:p=
></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.094822]=
&nbsp; (pci_rescan_remove_lock){+.+.}-{3:3}, at: rescan_store+0x55/0x90</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.094827]=
 &nbsp;#4: ffff9c597392b248 (&amp;dev-&gt;mutex){....}-{3:3}, at: __device_=
attach+0x39/0x160</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.094835]=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stack bac=
ktrace:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.097098]=
 [drm] Found VCN firmware Version ENC: 1.1 DEC: 1 VEP: 0 Revision: 21</span=
><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.097467]=
 CPU: 47 PID: 3632 Comm: bash Not tainted 5.16.0-kfd+ #1</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098169]=
 amdgpu 0000:43:00.0: amdgpu: Will use PSP to load VCN firmware</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098839]=
 Hardware name: Supermicro SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 2.1 08/14/20=
18</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098841]=
 Call Trace:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098842]=
&nbsp; &lt;TASK&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098843]=
&nbsp; dump_stack_lvl+0x44/0x57</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098848]=
&nbsp; check_noncircular+0x105/0x120</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098853]=
&nbsp; ? unwind_get_return_address+0x1b/0x30</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.112924]=
&nbsp; ? register_lock_class+0x46/0x780</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.113630]=
&nbsp; ? __lock_acquire+0x1552/0x1ac0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.114342]=
&nbsp; __lock_acquire+0x1552/0x1ac0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.115050]=
&nbsp; lock_acquire+0x26c/0x300</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.115755]=
&nbsp; ? __flush_work+0x2f5/0x470</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.116460]=
&nbsp; ? lock_is_held_type+0xdf/0x130</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.117177]=
&nbsp; __flush_work+0x315/0x470</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.117890]=
&nbsp; ? __flush_work+0x2f5/0x470</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.118604]=
&nbsp; ? lock_is_held_type+0xdf/0x130</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.119305]=
&nbsp; ? mark_held_locks+0x49/0x70</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.119981]=
&nbsp; ? queue_work_on+0x2f/0x70</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.120645]=
&nbsp; ? lockdep_hardirqs_on+0x79/0x100</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.121300]=
&nbsp; work_on_cpu+0x98/0xc0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.121702]=
 [drm] reserve 0x400000 from 0x87fec00000 for PSP TMR</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.121947]=
&nbsp; ? __traceiter_workqueue_execute_end+0x40/0x40</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.123270]=
&nbsp; ? pci_device_shutdown+0x60/0x60</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.123880]=
&nbsp; pci_device_probe+0x1bc/0x1d0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.124475]=
&nbsp; really_probe+0x102/0x450</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.125060]=
&nbsp; __driver_probe_device+0x100/0x170</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.125641]=
&nbsp; driver_probe_device+0x1f/0xa0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.126215]=
&nbsp; __device_attach_driver+0x6b/0xe0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.126797]=
&nbsp; ? driver_allows_async_probing+0x50/0x50</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.127383]=
&nbsp; ? driver_allows_async_probing+0x50/0x50</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.127960]=
&nbsp; bus_for_each_drv+0x6a/0xb0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.128528]=
&nbsp; __device_attach+0xe2/0x160</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.129095]=
&nbsp; pci_bus_add_device+0x4a/0x80</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.129659]=
&nbsp; pci_bus_add_devices+0x2c/0x70</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.130213]=
&nbsp; pci_bus_add_devices+0x65/0x70</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.130753]=
&nbsp; pci_bus_add_devices+0x65/0x70</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.131283]=
&nbsp; pci_bus_add_devices+0x65/0x70</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.131780]=
&nbsp; pci_bus_add_devices+0x65/0x70</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.132270]=
&nbsp; pci_bus_add_devices+0x65/0x70</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.132757]=
&nbsp; pci_rescan_bus+0x23/0x30</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.133233]=
&nbsp; rescan_store+0x61/0x90</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.133701]=
&nbsp; kernfs_fop_write_iter+0x132/0x1b0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.134167]=
&nbsp; new_sync_write+0x11f/0x1b0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.134627]=
&nbsp; vfs_write+0x35b/0x3b0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.135062]=
&nbsp; ksys_write+0xa7/0xe0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.135503]=
&nbsp; do_syscall_64+0x34/0x80</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.135933]=
&nbsp; entry_SYSCALL_64_after_hwframe+0x44/0xae</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.136358]=
 RIP: 0033:0x7f0058a73224</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.136775]=
 Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48=
 8d 05 c1 07 2e 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 &lt;48&gt; 3d 00 =
f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53
 48 89 f5</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.137663]=
 RSP: 002b:00007ffc4f4c71a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.138121]=
 RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f0058a73224</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.138590]=
 RDX: 0000000000000002 RSI: 000055d466c24450 RDI: 0000000000000001</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.139064]=
 RBP: 000055d466c24450 R08: 000000000000000a R09: 0000000000000001</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.139532]=
 R10: 000000000000000a R11: 0000000000000246 R12: 00007f0058d4f760</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.140003]=
 R13: 0000000000000002 R14: 00007f0058d4b2a0 R15: 00007f0058d4a760</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.140485]=
&nbsp; &lt;/TASK&gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.183669]=
 amdgpu 0000:43:00.0: amdgpu: HDCP: optional hdcp ta ucode is not available=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.184214]=
 amdgpu 0000:43:00.0: amdgpu: DTM: optional dtm ta ucode is not available</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.184735]=
 amdgpu 0000:43:00.0: amdgpu: RAP: optional rap ta ucode is not available</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.185234]=
 amdgpu 0000:43:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not =
available</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.185823]=
 amdgpu 0000:43:00.0: amdgpu: use vbios provided pptable</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.186327]=
 amdgpu 0000:43:00.0: amdgpu: smc_dpm_info table revision(format.content): =
4.6</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.188783]=
 amdgpu 0000:43:00.0: amdgpu: SMU is initialized successfully!</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.190039]=
 [drm] kiq ring mec 2 pipe 1 q 0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.203608]=
 [drm] VCN decode and encode initialized successfully(under DPG Mode).</spa=
n><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.204178]=
 [drm] JPEG decode initialized successfully.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.246079]=
 kfd kfd: amdgpu: Allocated 3969056 bytes on gart</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.327589]=
 memmap_init_zone_device initialised 8388608 pages in 64ms</span><o:p></o:p=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.328139]=
 amdgpu: HMM registered 32752MB device memory</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.328784]=
 amdgpu: Virtual CRAT table created for GPU</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.329844]=
 amdgpu: Topology: Add dGPU node [0x738c:0x1002]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.330387]=
 kfd kfd: amdgpu: added device 1002:738c</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.330965]=
 amdgpu 0000:43:00.0: amdgpu: SE 8, SH per SE 1, CU per SH 16, active_cu_nu=
mber 72</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.331725]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 0 on hub 0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.332296]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 1 on hub 0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.332856]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 4 on hub 0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.333414]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 5 on hub 0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.333965]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 6 on hub 0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.334507]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 7 on hub 0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.335057]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 8 on hub 0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.335594]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 9 on hub 0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.336137]=
 amdgpu 0000:43:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 10 on hub 0</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.336679]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.337234]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma1 uses VM inv eng 1 on hub 1</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.337790]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma2 uses VM inv eng 4 on hub 1</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.338343]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma3 uses VM inv eng 5 on hub 1</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.338906]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma4 uses VM inv eng 6 on hub 1</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.339448]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma5 uses VM inv eng 0 on hub 2</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.339987]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma6 uses VM inv eng 1 on hub 2</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.340519]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma7 uses VM inv eng 4 on hub 2</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.341041]=
 amdgpu 0000:43:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 5 on hub 2</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.341570]=
 amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 6 on hub 2</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.342101]=
 amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 7 on hub 2</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.342630]=
 amdgpu 0000:43:00.0: amdgpu: ring vcn_dec_1 uses VM inv eng 8 on hub 2</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.343152]=
 amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_1.0 uses VM inv eng 9 on hub 2</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.343657]=
 amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_1.1 uses VM inv eng 10 on hub 2<=
/span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.344136]=
 amdgpu 0000:43:00.0: amdgpu: ring jpeg_dec_0 uses VM inv eng 11 on hub 2</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.344610]=
 amdgpu 0000:43:00.0: amdgpu: ring jpeg_dec_1 uses VM inv eng 12 on hub 2</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.378213]=
 amdgpu: Detected AMDGPU 6 Perf Events.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.387349]=
 [drm] Initialized amdgpu 3.46.0 20150101 for 0000:43:00.0 on minor 1</span=
><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.388530]=
 pcieport 0000:d7:00.0: bridge window [io&nbsp; 0x1000-0x0fff] to [bus d8] =
add_size 1000</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.389078]=
 pcieport 0000:d7:00.0: BAR 13: no space for [io&nbsp; size 0x1000]</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.389600]=
 pcieport 0000:d7:00.0: BAR 13: failed to assign [io&nbsp; size 0x1000]</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.390091]=
 pcieport 0000:d7:00.0: BAR 13: no space for [io&nbsp; size 0x1000]</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.390568]=
 pcieport 0000:d7:00.0: BAR 13: failed to assign [io&nbsp; size 0x1000]</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 155.359200]=
 HelloWorld[3824]: segfault at 68 ip 00007f4c979f764e sp 00007ffc9b3bb610 e=
rror 4 in libamdhip64.so.4.4.21432-f9dccde4[7f4c979b3000+2eb000]</span><o:p=
></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 155.360268]=
 Code: 48 8b 45 e8 64 48 33 04 25 28 00 00 00 74 05 e8 b8 c7 fb ff 48 8b 5d=
 f8 c9 c3 f3 0f 1e fa 55 48 89 e5 48 89 7d f8 48 8b 45 f8 &lt;48&gt; 8b 40 =
68 5d c3 f3 0f 1e fa 55 48 89 e5 48 89 7d f8 48
 8b 45 f8</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Best regards,</span=
><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Shuotao</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span><o:p><=
/o:p></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Andrey Grodzovsky &=
lt;<a href=3D"mailto:andrey.grodzovsky@amd.com">andrey.grodzovsky@amd.com</=
a>&gt;<br>
<b>Date: </b>Wednesday, April 6, 2022 at 10:36 PM<br>
<b>To: </b>Shuotao Xu &lt;<a href=3D"mailto:shuotaoxu@microsoft.com">shuota=
oxu@microsoft.com</a>&gt;,
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc: </b>Ziyue Yang &lt;<a href=3D"mailto:Ziyue.Yang@microsoft.com">Ziyue=
.Yang@microsoft.com</a>&gt;, Lei Qu &lt;<a href=3D"mailto:Lei.Qu@microsoft.=
com">Lei.Qu@microsoft.com</a>&gt;, Peng Cheng &lt;<a href=3D"mailto:pengc@m=
icrosoft.com">pengc@microsoft.com</a>&gt;, Ran Shu &lt;<a href=3D"mailto:Ra=
n.Shu@microsoft.com">Ran.Shu@microsoft.com</a>&gt;<br>
<b>Subject: </b>Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug S=
upport</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[You don't often ge=
t email from
<a href=3D"mailto:andrey.grodzovsky@amd.com">andrey.grodzovsky@amd.com</a>.=
 Learn why this is important at
<a href=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F=
%2Faka.ms%2FLearnAboutSenderIdentification.%255d&amp;data=3D05%7C01%7Cshuot=
aoxu%40microsoft.com%7Ca782bea4842e45f15b7408da183d85b4%7C72f988bf86f141af9=
1ab2d7cd011db47%7C1%7C0%7C637848950411722793%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7=
C&amp;sdata=3DoY6DZbPB%2BJZSSDdMNg4s44cRc4TnT20Vtew%2Fw4Uziq8%3D&amp;reserv=
ed=3D0">
http://aka.ms/LearnAboutSenderIdentification.]</a><br>
<br>
Can you attach dmesg for the failure without your patch against<br>
amd-staging-drm-next ?<br>
<br>
Also, in general, patches for amdgpu upstream branches should be<br>
submitted to amd-gfx mailing list inline using git-send which makes it<br>
easy to comment and review them inline.<br>
<br>
Andrey<br>
<br>
On 2022-04-06 10:25, Shuotao Xu wrote:<br>
&gt; Hi Andrey,<br>
&gt;<br>
&gt; We just tried kernel 5.16 based on<br>
&gt; <a href=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux.git&amp;data=3D05%7C01%7Csh=
uotaoxu%40microsoft.com%7Ca782bea4842e45f15b7408da183d85b4%7C72f988bf86f141=
af91ab2d7cd011db47%7C1%7C0%7C637848950411722793%7CUnknown%7CTWFpbGZsb3d8eyJ=
WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7=
C%7C&amp;sdata=3DssS4iNDEer0H%2FkK1N34xiC76v3TKv4GNYYWvlELU670%3D&amp;reser=
ved=3D0">
https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.=
freedesktop.org%2Fagd5f%2Flinux.git&amp;amp;data=3D05%7C01%7Cshuotaoxu%40mi=
crosoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd0=
11db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA=
wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp=
;sdata=3Djz51aMtsG7PIEfLy1jLvLGd%2BsBREvOFf9Gc6BZlmsmU%3D&amp;amp;reserved=
=3D0</a><br>
&gt; &lt;<a href=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux.git&amp;data=3D05%7C01%=
7Cshuotaoxu%40microsoft.com%7Ca782bea4842e45f15b7408da183d85b4%7C72f988bf86=
f141af91ab2d7cd011db47%7C1%7C0%7C637848950411722793%7CUnknown%7CTWFpbGZsb3d=
8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%=
7C%7C%7C&amp;sdata=3DssS4iNDEer0H%2FkK1N34xiC76v3TKv4GNYYWvlELU670%3D&amp;r=
eserved=3D0">https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux.git&amp;amp;data=3D05%7C01%7Cs=
huotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f14=
1af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%=
7C%7C&amp;amp;sdata=3Djz51aMtsG7PIEfLy1jLvLGd%2BsBREvOFf9Gc6BZlmsmU%3D&amp;=
amp;reserved=3D0</a>&gt;<br>
&gt; amd-staging-drm-next branch, and found out that hotplug did not work o=
ut<br>
&gt; of box for Rocm compute stack.<br>
&gt;<br>
&gt; We did not try the rendering stack since we currently are more focused=
<br>
&gt; on AI workloads.<br>
&gt;<br>
&gt; We have also created a patch against the amd-staging-drm-next branch t=
o<br>
&gt; enable hotplug for ROCM stack, which were sent in another later email<=
br>
&gt; with same subject. I am attaching the patch in this email, in case tha=
t<br>
&gt; you would want to delete that later email.<br>
&gt;<br>
&gt; Best regards,<br>
&gt;<br>
&gt; Shuotao<br>
&gt;<br>
&gt; *From: *Andrey Grodzovsky &lt;<a href=3D"mailto:andrey.grodzovsky@amd.=
com">andrey.grodzovsky@amd.com</a>&gt;<br>
&gt; *Date: *Wednesday, April 6, 2022 at 10:13 PM<br>
&gt; *To: *Shuotao Xu &lt;<a href=3D"mailto:shuotaoxu@microsoft.com">shuota=
oxu@microsoft.com</a>&gt;,<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedes=
ktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@l=
ists.freedesktop.org</a>&gt;<br>
&gt; *Cc: *Ziyue Yang &lt;<a href=3D"mailto:Ziyue.Yang@microsoft.com">Ziyue=
.Yang@microsoft.com</a>&gt;, Lei Qu<br>
&gt; &lt;<a href=3D"mailto:Lei.Qu@microsoft.com">Lei.Qu@microsoft.com</a>&g=
t;, Peng Cheng &lt;<a href=3D"mailto:pengc@microsoft.com">pengc@microsoft.c=
om</a>&gt;, Ran Shu<br>
&gt; &lt;<a href=3D"mailto:Ran.Shu@microsoft.com">Ran.Shu@microsoft.com</a>=
&gt;<br>
&gt; *Subject: *[EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Suppo=
rt<br>
&gt;<br>
&gt; [You don't often get email from <a href=3D"mailto:andrey.grodzovsky@am=
d.com">andrey.grodzovsky@amd.com</a>. Learn why<br>
&gt; this is important at <a href=3D"https://nam06.safelinks.protection.out=
look.com/?url=3Dhttp%3A%2F%2Faka.ms%2FLearnAboutSenderIdentification.%255d&=
amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7Ca782bea4842e45f15b7408da18=
3d85b4%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848950411722793%7CUn=
known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ=
XVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DoY6DZbPB%2BJZSSDdMNg4s44cRc4TnT20Vt=
ew%2Fw4Uziq8%3D&amp;reserved=3D0">
http://aka.ms/LearnAboutSenderIdentification.]</a><br>
&gt; &lt;<a href=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dh=
ttp%3A%2F%2Faka.ms%2FLearnAboutSenderIdentification.%255d&amp;data=3D05%7C0=
1%7Cshuotaoxu%40microsoft.com%7Ca782bea4842e45f15b7408da183d85b4%7C72f988bf=
86f141af91ab2d7cd011db47%7C1%7C0%7C637848950411722793%7CUnknown%7CTWFpbGZsb=
3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300=
0%7C%7C%7C&amp;sdata=3DoY6DZbPB%2BJZSSDdMNg4s44cRc4TnT20Vtew%2Fw4Uziq8%3D&a=
mp;reserved=3D0">https://nam06.safelinks.protection.outlook.com/?url=3Dhttp=
%3A%2F%2Faka.ms%2FLearnAboutSenderIdentification.%255d&amp;amp;data=3D05%7C=
01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988b=
f86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30=
00%7C%7C%7C&amp;amp;sdata=3DHfSwu6SWfoCYyscJqGFdKHBPtaj%2BKB4lyo13zkm6hi4%3=
D&amp;amp;reserved=3D0</a>&gt;<br>
&gt;<br>
&gt; Looks like you are using 5.13 kernel for this work, FYI we added<br>
&gt; hot plug support for the graphic stack in 5.14 kernel (see<br>
&gt; <a href=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fwww.phoronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-A=
MDGPU-Hot-Unplug&amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7Ca782bea48=
42e45f15b7408da183d85b4%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848=
950411722793%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC=
JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D2nCzwhL%2Bg8GIJ3Wl=
DacVB6Rbb1hAtHRHhfihZRStzuI%3D&amp;reserved=3D0">
https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.pho=
ronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU-Hot-Unplug=
&amp;amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b8730=
8da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564=
%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW=
wiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3D4l9mT8zNR%2FvqsEFr7noIDqKf=
16IGN8xmO2T6jnpipzo%3D&amp;amp;reserved=3D0)</a><br>
&gt; &lt;<a href=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Fwww.phoronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.=
14-AMDGPU-Hot-Unplug&amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7Ca782b=
ea4842e45f15b7408da183d85b4%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63=
7848950411722793%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz=
IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D2nCzwhL%2Bg8GI=
J3WlDacVB6Rbb1hAtHRHhfihZRStzuI%3D&amp;reserved=3D0">https://nam06.safelink=
s.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.phoronix.com%2Fscan.php%3=
Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU-Hot-Unplug&amp;amp;data=3D05%7C0=
1%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf=
86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb=
3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300=
0%7C%7C%7C&amp;amp;sdata=3D4l9mT8zNR%2FvqsEFr7noIDqKf16IGN8xmO2T6jnpipzo%3D=
&amp;amp;reserved=3D0</a>&gt;<br>
&gt;<br>
&gt;<br>
&gt; I am not sure about the code part since it all touches KFD driver (KFD=
<br>
&gt; team can comment on that) - but I was just wondering if you try 5.14<b=
r>
&gt; kernel would things just work for you out of the box ?<br>
&gt;<br>
&gt; Andrey<br>
&gt;<br>
&gt; On 2022-04-05 22:45, Shuotao Xu wrote:<br>
&gt;&gt; Dear AMD Colleagues,<br>
&gt;&gt;<br>
&gt;&gt; We are from Microsoft Research, and are working on GPU disaggregat=
ion<br>
&gt;&gt; technology.<br>
&gt;&gt;<br>
&gt;&gt; We have created a new pull requestAdd PCIe hotplug support for amd=
gpu by<br>
&gt;&gt; xushuotao =B7 Pull Request #131 =B7 RadeonOpenCompute/ROCK-Kernel-=
Driver<br>
&gt;&gt; (github.com)<br>
&gt;&gt; &lt;<a href=3D"https://nam06.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull=
%2F131&amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7Ca782bea4842e45f15b7=
408da183d85b4%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6378489504117227=
93%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h=
aWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DxvW04nplXWAZ7jxsTnABR1JKY7Hc=
Hw80nPYJPPpD%2BrI%3D&amp;reserved=3D0">https://nam06.safelinks.protection.o=
utlook.com/?url=3Dhttps%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kerne=
l-Driver%2Fpull%2F131&amp;amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C=
93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0=
%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV=
2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3DqEeZR=
6R95jrjAaltd1MnpyFedOiVZaNQuCxcoNog90g%3D&amp;amp;reserved=3D0<br>
</a>&gt; &lt;<a href=3D"https://nam06.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull=
%2F131&amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7Ca782bea4842e45f15b7=
408da183d85b4%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6378489504117727=
85%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h=
aWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DEK5BHdupZ2UJsJXTAcYa5rAYoy3u=
CVvSrTH1uCOS1wQ%3D&amp;reserved=3D0">https://nam06.safelinks.protection.out=
look.com/?url=3Dhttps%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-=
Driver%2Fpull%2F131&amp;amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C93=
f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7=
C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l=
uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3DqEeZR6R=
95jrjAaltd1MnpyFedOiVZaNQuCxcoNog90g%3D&amp;amp;reserved=3D0</a>&gt;&gt;in<=
br>
&gt;&gt; ROCK-Kernel-Driver, which will enable PCIe hot-plug support for am=
dgpu.<br>
&gt;&gt;<br>
&gt;&gt; We believe the support of hot-plug of GPU devices can open doors f=
or<br>
&gt;&gt; many advanced applications in data center in the next few years, a=
nd we<br>
&gt;&gt; would like to have some reviewers on this PR so we can continue fu=
rther<br>
&gt;&gt; technical discussions around this feature.<br>
&gt;&gt;<br>
&gt;&gt; Would you please help review this PR?<br>
&gt;&gt;<br>
&gt;&gt; Thank you very much!<br>
&gt;&gt;<br>
&gt;&gt; Best regards,<br>
&gt;&gt;<br>
&gt;&gt; Shuotao Xu<br>
&gt;&gt;<br>
&gt;</span><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_PSAP153MB0517AFB4B9CF54A17CD5223EB7E69PSAP153MB0517APCP_--
