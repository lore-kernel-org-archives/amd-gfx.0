Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9553EC28CF5
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 15:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 006C310E6F9;
	Wed, 26 Jan 2022 15:17:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC5EF10E6F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 15:17:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=midYhTzpMlYW3dPoLXibdRy5J2z5ysMWLbswCfMClzBN+iryhhrxxs536PnYDEiZwYVMjomm5SuwexY/+y9LdGrSY4qrYLrSEuEN/o6Taxpi3MXWabskT6ih1O30KaBkB+7iYnH67bGtyvNgUXd8LjYK6Ssvtw6Z13lTW6j/6NP0tuy3BuTm3wNy6T9bvhl77thkUx6ytgcgmSO4f11azef9Gej+tEvwXkU6DPBQC49s5r7tdFxwdGQHbFXhgD4gDiC9CneJi5YaQIregsFKFWbwtsZoLmFugVV3zYlj7yUKycU4ofMk1SvUhgk+ixVZSPJNDl7vWRwWMUpyaXA/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNeyRbRJmpEvql4PpHXhypO0foz2CmYp4IVgQFRCBXg=;
 b=Qvhbrl5wC6lvX8DA0UgVzvzuWYlvvcjgvn08BnbPQdmEzaw62sgS8dfEQR8Q3HObgCrie6xT1guoII7Ufgep3FyIHnQUI5gcxjNfynGSrp0yBQe7JKhz5kP30vPOQdklHY6l9otOflRYNhqF3fsqUtkMLLLn77MV62vicjAf5onKSM2XfYyP9lii/WZk715stdAHIaY76QLEhSYfLb/iosJJC9b2ok1I23wpH8WImvY7nZB+ZAZh1ZHB3u7g1pqNsQSVaogpZ0y6AGcXMzjUbLn6TBoub/GepS/qwYaZeINEW8cPvJktg9EUW2rAsobBp98mLkr1h/3xV/KWFdDz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNeyRbRJmpEvql4PpHXhypO0foz2CmYp4IVgQFRCBXg=;
 b=tinM53LsHFGkytXd3GewKofI9g4+ULw3eTD65SqcLTT63GxXWXjmM9CNRKyrD4urzhEWKZRctUKGrs3FRRJjlSY0ImYwGo8cWO6TO2nY04JnyszIj/KQ/Do3u1ODJpVgUl3MHzdP6M9P/E8Wz7dqER8EpzGrdVBGS+j571g2Erk=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Wed, 26 Jan
 2022 15:17:05 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 15:17:05 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5 2/4] drm/amd: add support to check whether the system
 is set to s3
Thread-Topic: [PATCH v5 2/4] drm/amd: add support to check whether the system
 is set to s3
Thread-Index: AQHYEmqNfmkF82KHjk6WjLq0eEjUOax1Z7aAgAAAF+CAAAFNAIAAALAA
Date: Wed, 26 Jan 2022 15:17:05 +0000
Message-ID: <BL1PR12MB515774822861EC1850C31F98E2209@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220126040944.4324-1-mario.limonciello@amd.com>
 <20220126040944.4324-2-mario.limonciello@amd.com>
 <BYAPR12MB46142C4338D620EE1F7977FB97209@BYAPR12MB4614.namprd12.prod.outlook.com>
 <BL1PR12MB5157001FFC7CC78C6AA12DF4E2209@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BYAPR12MB46143045A2226B863E1CCB2997209@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB46143045A2226B863E1CCB2997209@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-26T15:07:26.0000000Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0; MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-26T15:17:04Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Standard
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: bc3d732e-bbc5-49f9-bb09-af8d33d2e453
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 916245c4-e1b2-4d78-fec2-08d9e0dee9a4
x-ms-traffictypediagnostic: MW4PR12MB5627:EE_
x-microsoft-antispam-prvs: <MW4PR12MB5627D19A01F63CAC3B0482A1E2209@MW4PR12MB5627.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fkp8hPEcjrdcKfNjMbso29NuvGBwo5ZZG/GJANh7o12Yg202PNTG64nEOsSQgEF7dfsHQa2Uo7nznT9EJbQG0G+m6iJyFUiSemuPERa6yzSgWVeLNPQUdBF4ZgCaLFPjcr8S2ZLmdZ9Kcx/6rE5wfnmq0oQhY/SdhIE75XZqyaTrT+9O4qpqBYOSnF5ICBSo4WCMB0F/HUjiBerIL2Bnqy7FpjsATLo9XTYOC2msL30P2yvUWN/U9SZMD1P+LGJtTsCX+62SI67izZHPD7Q1+4MUNO/dzY36Y9ldQ5SU5u2kCGtpFe5HwiEKmgzjc4Y2o/YWmISu6wxHKFey6abg42ZAVs3oPvTyotXc1ETQ02KrJWxu29ULSxrBvO6QPEpjVGfFWjoKuZGtIB8Qnrd3ar88/uQ54vmrA88yw1jwe17gpt8ruaPyjm9jwF0TISrzwvzh+Fc9XEDpSyaF01+xfk0ggSzxGcj5WzKX+og4Y7ODR4DNS+tTJrrlbgRvg9/ofBPz6nTtyzFlv6CEbBQji/bJG3ITVCLZKmCmKgH/V1IeiWKrMkUYEbzKLjM1y8mMMYk7Ka1qRfUi1keu0HWldFpE1YCklndQNy02q++hGEeEupvlZ6zXU40/sGnKrOUWiNK6ZTDRInrYo2HtjJpdSwvD9SIGFOLSVrYzwRd7bcAZZfgThqIBi9KQRydZclDMPGw8Sk7LSeG6cwyCYqMd1A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(4326008)(64756008)(66446008)(66556008)(8936002)(66476007)(5660300002)(86362001)(110136005)(66946007)(55016003)(71200400001)(33656002)(186003)(53546011)(52536014)(122000001)(8676002)(83380400001)(38100700002)(2906002)(38070700005)(6506007)(508600001)(76116006)(7696005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7cqM8gxxsn+AjuVnH+E3FhJIWpl6xjH2hnB0R0KkVPsGPzRhg9XULmoiFGRP?=
 =?us-ascii?Q?zEQRciT9gBqcRHGiSKrbOsy0elmduO4PbmAMGw3PXq2jia9kK67347IHG5/n?=
 =?us-ascii?Q?FA3WIj1pp7Xk7nOHKacNa5z2KADY1YHLlfLfsvfQ3WSJ5hwnBBMNoSP6ZdEX?=
 =?us-ascii?Q?Yw0Ar/2x7a6fyc6tYkpLlG8WvOs/1mD72AiVyMqoEnmz4Cbi7nCwibrVoCd/?=
 =?us-ascii?Q?t3ZR6kmkEcLZcjfTd6cpCg7qRQba2cOC4ecnK0uw3VCqpQntM/aqh9W3/XlQ?=
 =?us-ascii?Q?NXCwxYPcgTubKKdb+6fdpDdH1e4XVeNXaiq7/deeqawOtdKKGLcQkF5sgYO0?=
 =?us-ascii?Q?s0P8x6m/NVrk/x3keaK7KZF0KR4VumkQygKDt5bLu7C7qXkapUZ7r6oLLmQu?=
 =?us-ascii?Q?JpLW9coj6Qw5GMyV9KqQmmVTvNj/dDaLT/ASi5S/DeH5YqDg9M1CAbu4DEu7?=
 =?us-ascii?Q?TuofD8J8/ghm4upjRJCxnQdiEBIhUpCcnbQZwcYNK2bK8wk4p+oYqFgPwFp9?=
 =?us-ascii?Q?0x5/tVPuc2EOfZfr1oVIrw4ea8Ed6fzAy2GqopzHqS7k5HW0kH3YmHwL8jN1?=
 =?us-ascii?Q?aTuYtQOQ96Og4Lb5HLaxh8ezJhyTs6N5W+qo3LwTxAzcwan3mppcdE4pzGBG?=
 =?us-ascii?Q?0jJYrngOP9XflCF1ZcAOLTIw2u8gKeaVxfWJixKxKLBbFidLueGoXnus0En/?=
 =?us-ascii?Q?TDIwm8CMKKZpuXP3luYrRoEGQKzKdA8lRlz9JVQgDGLX0ohdLsA7JDcHikkV?=
 =?us-ascii?Q?YNZhVpA2yrXrssx9sXGJNyQJOomXJvKutu9ZLGqCa/2OpRFrBUMOYVajnbsw?=
 =?us-ascii?Q?gLqXk/AVpeLuCrIitlJJxkrviPAmKLxni+lK81/A5gWkWQrvxnbLre3lHTcZ?=
 =?us-ascii?Q?UGLZe7kQej/Jg7t3D7UHtkgw/zVCzULhIt0Kbpceg6PfS1vsNyLZIHVKmU5s?=
 =?us-ascii?Q?nMbT38qPv4mHF5q2tOewD11oNIahBDB/zWH5KOahyuCVVd1qhm2Q56e1YOTU?=
 =?us-ascii?Q?4mtMSthoFNLZT0v9OxiP3j5AEK73oidEyCHzSa5oaBaTD2xuEQ+fjpUTIFLV?=
 =?us-ascii?Q?NGRcJqjs4l9cPyq8w75ujiUQfIjiyd0yeTswFKWNWanToEom/T+l0zvu3TLZ?=
 =?us-ascii?Q?Lss8Es+x+2V/0fVuMSZWjbx3Jj65KyhWENaquw98oRjAaLg4B8BBITNbQPEb?=
 =?us-ascii?Q?LbptkvLmJjIueAFB6hL+VIwIcfQPdHe6f3d9EbQcoBRgfIQJzQgEs12KE0CI?=
 =?us-ascii?Q?RiiACufNCAW4gX0teLkWPFyq7YhnjJIqoXPaUrMlX4ijKxgzmYRMHO0c77Un?=
 =?us-ascii?Q?3OJ06xM98Yb1ec0pgQz4hrDWW0/N0ezE2c2y5Ipxcu/mnnLYrNWKssyGRCs2?=
 =?us-ascii?Q?Wpu7/cdWS4xarZmErki6e8vUiBGH+phlvT+3eSEib7IwcjLF/T+HF6L9j9zz?=
 =?us-ascii?Q?/SCh9p6zvsSa5dP84fu4rDmvels/TrryrI5TR+V9dhUAN51mef2PU+1p+jOC?=
 =?us-ascii?Q?cMYsO++KpJxDOklT0aDKVZYbYnsIs8P5wKfqgIJbaFeA+wbgq8MEDcIndot+?=
 =?us-ascii?Q?+RQMVC7ywy51le9PIwQpTYv0aY+uGaj1htTPNQcqllA/I8dDgVqaPzJoaFdN?=
 =?us-ascii?Q?xuOhKL1V5A+MLNHtDactMSs/nolryW9qeK2Dac9yjIEZcQEpAjqosCsXw3+R?=
 =?us-ascii?Q?o5FzIT7oqhPrjz6DAl7XUR7Mq5I=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB515774822861EC1850C31F98E2209BL1PR12MB5157namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916245c4-e1b2-4d78-fec2-08d9e0dee9a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 15:17:05.5494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b4XevKYUqwD+nFevU5AcZMVX5cpu0UAklMie+zyckmTW3iHum3W7SaacGMwsezFFLq3zMGexKZD956HWEzsAnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
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
Cc: "Liang, Prike" <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB515774822861EC1850C31F98E2209BL1PR12MB5157namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Right -from an API perspective both amdgpu_acpi_is_s0ix_active and amdgpu_a=
cpi_is_s3_active are only in suspend ops.

But so coming back to the 4th patch (and the associated bug), what is suppo=
sed to happen with a dGPU on an Intel system that does s2i?
For AMD APU w/ dGPU in the system doing s2i I would expect that power rails=
 have been cut off for the dGPU so putting it into S3 and doing a reset mak=
es sense, but I don't know about on an Intel system if that is logical.
It seems like Intel expects more that the card is going to be in runtime pm=
 and putting it into S3 and doing reset might not be the right move.

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, January 26, 2022 09:11
To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Liang, Prike <Prike.Liang@amd.com>
Subject: Re: [PATCH v5 2/4] drm/amd: add support to check whether the syste=
m is set to s3

Talking from generic API perspective - S3 is considered active for dGPU onl=
y if it's going to non-S0 state. If called from anywhere else than suspend =
op, this should return false.

Thanks,
Lijo
________________________________
From: Limonciello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciell=
o@amd.com>>
Sent: Wednesday, January 26, 2022 8:37:28 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.fr=
eedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Liang, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>
Subject: RE: [PATCH v5 2/4] drm/amd: add support to check whether the syste=
m is set to s3


[Public]



That was intentional - shouldn't dGPU always be going through S3 path curre=
ntly?



From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: Wednesday, January 26, 2022 09:06
To: Limonciello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciello@=
amd.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.o=
rg>
Cc: Liang, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>; Limonci=
ello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciello@amd.com>>
Subject: Re: [PATCH v5 2/4] drm/amd: add support to check whether the syste=
m is set to s3



[Public]



Returns true for dGPU always. Better to keep the whole check under somethin=
g like this.



if (pm_suspend_target_state !=3D PM_SUSPEND_ON)



Thanks,
Lijo

________________________________

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Mario Limonciello <mario.limonciello@=
amd.com<mailto:mario.limonciello@amd.com>>
Sent: Wednesday, January 26, 2022 9:39:42 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Liang, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>; Limonci=
ello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciello@amd.com>>
Subject: [PATCH v5 2/4] drm/amd: add support to check whether the system is=
 set to s3



This will be used to help make decisions on what to do in
misconfigured systems.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com<mailto:mario.li=
monciello@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 3bc76759c143..f184c88d3d4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1409,11 +1409,13 @@ int amdgpu_acpi_smart_shift_update(struct drm_devic=
e *dev, enum amdgpu_ss ss_sta
 int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);

 void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps)=
;
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
 void amdgpu_acpi_detect(void);
 #else
 static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0;=
 }
 static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
+static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { =
return false };
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) =
{ return false; }
 static inline void amdgpu_acpi_detect(void) { }
 static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { re=
turn false; }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c
index 2531da6cbec3..df673062bc03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1031,6 +1031,23 @@ void amdgpu_acpi_detect(void)
         }
 }

+/**
+ * amdgpu_acpi_is_s3_active
+ *
+ * @adev: amdgpu_device_pointer
+ *
+ * returns true if supported, false if not.
+ */
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
+{
+#if IS_ENABLED(CONFIG_SUSPEND)
+       return !(adev->flags & AMD_IS_APU) ||
+               pm_suspend_target_state =3D=3D PM_SUSPEND_MEM;
+#else
+       return false;
+#endif
+}
+
 /**
  * amdgpu_acpi_is_s0ix_active
  *
--
2.25.1

--_000_BL1PR12MB515774822861EC1850C31F98E2209BL1PR12MB5157namp_
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
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsipheaderc10f11a2, li.xmsipheaderc10f11a2, div.xmsipheaderc10f11a2
	{mso-style-name:x_msipheaderc10f11a2;
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
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"purple" style=3D"word-wrap:b=
reak-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Right -from an API perspective both amdgpu_acpi_is_s=
0ix_active and amdgpu_acpi_is_s3_active are only in suspend ops.<o:p></o:p>=
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">But so coming back to the 4<sup>th</sup> patch (and =
the associated bug), what is
<i>supposed</i> to happen with a dGPU on an Intel system that does s2i?&nbs=
p; <o:p></o:p></p>
<p class=3D"MsoNormal">For AMD APU w/ dGPU in the system doing s2i I would =
expect that power rails have been cut off for the dGPU so putting it into S=
3 and doing a reset makes sense, but I don&#8217;t know about on an Intel s=
ystem if that is logical.<o:p></o:p></p>
<p class=3D"MsoNormal">It seems like Intel expects more that the card is go=
ing to be in runtime pm and putting it into S3 and doing reset might not be=
 the right move.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Wednesday, January 26, 2022 09:11<br>
<b>To:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org<br>
<b>Cc:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v5 2/4] drm/amd: add support to check whether th=
e system is set to s3<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">Talking from generic API perspective - S3 is considered active for dGP=
U only if it's going to non-S0 state. If called from anywhere else than sus=
pend op, this should return false.<o:p></o:p></span></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p class=3D"MsoNormal">Thanks,<br>
Lijo<o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limo=
nciello@amd.com">Mario.Limonciello@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, January 26, 2022 8:37:28 PM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Liang, Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Li=
ang@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH v5 2/4] drm/amd: add support to check whether th=
e system is set to s3</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<p class=3D"xmsipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</=
span><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">That was intentional &#8211; shouldn&#8217;t dGPU a=
lways be going through S3 path currently?<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal"><b>From:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo=
.Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;
<br>
<b>Sent:</b> Wednesday, January 26, 2022 09:06<br>
<b>To:</b> Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limonciello@amd.c=
om">Mario.Limonciello@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Cc:</b> Liang, Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Li=
ang@amd.com</a>&gt;; Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limonci=
ello@amd.com">Mario.Limonciello@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH v5 2/4] drm/amd: add support to check whether th=
e system is set to s3<o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]</span><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"color:#21=
2121">Returns true for dGPU always. Better to keep the whole check under so=
mething like this.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"color:#21=
2121">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"color:#21=
2121">if (pm_suspend_target_state !=3D PM_SUSPEND_ON)</span><o:p></o:p></p>
</div>
<div id=3D"x_ms-outlook-mobile-signature">
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
</div>
<p class=3D"xmsonormal">Thanks,<br>
Lijo<o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"xmsonormal"><b><span style=3D"color:black">From:</span></b><spa=
n style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@list=
s.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf =
of Mario Limonciello &lt;<a href=3D"mailto:mario.limonciello@amd.com">mario=
.limonciello@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, January 26, 2022 9:39:42 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Liang, Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Li=
ang@amd.com</a>&gt;; Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limonci=
ello@amd.com">Mario.Limonciello@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH v5 2/4] drm/amd: add support to check whether the sy=
stem is set to s3</span>
<o:p></o:p></p>
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal" style=3D"margin-bottom:12.0pt">This will be used to=
 help make decisions on what to do in<br>
misconfigured systems.<br>
<br>
Signed-off-by: Mario Limonciello &lt;<a href=3D"mailto:mario.limonciello@am=
d.com">mario.limonciello@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 2 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 17 +++++++++++++++++<br>
&nbsp;2 files changed, 19 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 3bc76759c143..f184c88d3d4f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -1409,11 +1409,13 @@ int amdgpu_acpi_smart_shift_update(struct drm_devic=
e *dev, enum amdgpu_ss ss_sta<br>
&nbsp;int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);=
<br>
&nbsp;<br>
&nbsp;void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *=
caps);<br>
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);<br>
&nbsp;bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);<br>
&nbsp;void amdgpu_acpi_detect(void);<br>
&nbsp;#else<br>
&nbsp;static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { retu=
rn 0; }<br>
&nbsp;static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }<b=
r>
+static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { =
return false };<br>
&nbsp;static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *a=
dev) { return false; }<br>
&nbsp;static inline void amdgpu_acpi_detect(void) { }<br>
&nbsp;static inline bool amdgpu_acpi_is_power_shift_control_supported(void)=
 { return false; }<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c<br>
index 2531da6cbec3..df673062bc03 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
@@ -1031,6 +1031,23 @@ void amdgpu_acpi_detect(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
+/**<br>
+ * amdgpu_acpi_is_s3_active<br>
+ *<br>
+ * @adev: amdgpu_device_pointer<br>
+ *<br>
+ * returns true if supported, false if not.<br>
+ */<br>
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)<br>
+{<br>
+#if IS_ENABLED(CONFIG_SUSPEND)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return !(adev-&gt;flags &amp; AMD_IS_=
APU) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm_suspend_target_state =3D=3D PM_SUSPEND_MEM;<br>
+#else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
+#endif<br>
+}<br>
+<br>
&nbsp;/**<br>
&nbsp; * amdgpu_acpi_is_s0ix_active<br>
&nbsp; *<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</body>
</html>

--_000_BL1PR12MB515774822861EC1850C31F98E2209BL1PR12MB5157namp_--
