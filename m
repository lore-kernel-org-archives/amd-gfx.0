Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A017CA5FB1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 06:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4DA710E10A;
	Wed, 30 Sep 2026 06:28:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j/oG2Xqv";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 760D810E848
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 06:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEf4hl0238jYO/hMnZEAfMB+3+5P2lxVnFCiighDCPOGogJCtxOfxt9g5aBmv0IVEj3Ebd1X+VX6VfnlnZ7mNKluUucJ/bgAcy6khvIF5Cmk9AcbHl/ICrR8yo/UHXzvZw9zUUgyXMM+TcnJ30gD05bnlhbpefisDxsIaVVCjKlsntvNO9j0hldJu0cWXPyXpoOoLv0okqZvHN4WjssBx8emlNgcs1vB4wUZ8cjGxPU1X05srfVoNUp5dRLjQtM8PHSZE19mYj4rUlK9cu18n7DiaMmA4t0gvDRnocqoFuTrsUHxzjrMu6Kik/COr2DFj+S0NDyqRhbdduW2BbwVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8rl5sWtWvQGZHUiRBLhDrcRocrsZmnpMt0v1t0iPw8=;
 b=tu2CrPBDsUpQZsCEhWfmFrsFXchnxLjW7LZLI27qdtjAyHNCmtrGyE9AZFngNxEorcD4G8pQOlpWVpxHcNJGYEYZlg8+XHqQ2m3CPOVE9nbPPWyQHV7HlU5eYEOkRZ2/Iw0YLBXA0dMgpX+0/a0bOoFmL8Hl7EwMUQA+McYRwhoIqKAtyuCv3cFQAUPFSwoaw3HqwSm+na2rg4wSw+LSjogG3jNmH9OiBAPqtpZ6JmDvEW1uDVBTnRm5v2hS+pGlHXJr30UucvlkF8F8zuLmOgFqFgRl7LqXwVdidMwugRK6Gh4Y5Hp342uKB0STERpk3qIxJR6gnFm6tm0uxml1kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8rl5sWtWvQGZHUiRBLhDrcRocrsZmnpMt0v1t0iPw8=;
 b=j/oG2XqvUjycKd6021jendbQp0JRDO80QK1U3IV4w8Ga2+1VWnknFKKPPB0zBaZyXrNykIz8MIAYaegNhvUSoxw6aOtNrNIXk1XB5EzPXm8sPiPxvsi8xSSTBtejU/NJbSPbsQERip+A/xCPDdcip2az+wWMPIx2Y7tElci6fpk=
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 06:28:03 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 06:28:03 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Wang, Kevin" <Kevin.Wang@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset on
 gfx12
Thread-Topic: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset
 on gfx12
Thread-Index: AQHdT7nkajEGCzvlxkysHsiQKH+ICbblQ/QAgAAIdwCAAJ1rgIAAhO8AgAAC+ACAAATegIAAA8iAgAAe/QCAAAOnAIAAB+8AgAACZwCAAAKrLA==
Date: Wed, 30 Sep 2026 06:28:03 +0000
Message-ID: <SA0PR12MB70915BCDD0BE98B2F8B54A0E978B2@SA0PR12MB7091.namprd12.prod.outlook.com>
References: <20260929022540.122318-1-yifan1.zhang@amd.com>
 <f9db848b-da68-4acf-a0e3-41464b939817@amd.com>
 <CY5PR12MB6369B765E89F17858A5AB4A8C18C2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <BN9PR12MB5146D08AFE80E7E6EE34B614F78C2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <CY5PR12MB63694BE5CF3FB172F837CCBFC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <6b086b84-deed-47ec-ab7f-8cc016ab519d@amd.com>
 <CY5PR12MB63696540D11FBBD268D9B7ECC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <a2f8757d-1566-4b8e-a606-e363221db6a1@amd.com>
 <CY5PR12MB63693EB274BB3A16097332AAC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <fa59606b-0860-4aaa-b6ce-ac037f73eab4@amd.com>
 <BN9PR12MB5211C24FDF238C2A748378DC938B2@BN9PR12MB5211.namprd12.prod.outlook.com>
 <CY5PR12MB63693C7F0614B19DC5CD525FC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB63693C7F0614B19DC5CD525FC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-30T06:04:11.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-reactions: allow
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB7091:EE_|CH3PR12MB7524:EE_
x-ms-office365-filtering-correlation-id: 65d6c563-a32b-4433-13f6-08df1ebbfb46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003|8096899003|38070700021;
x-microsoft-antispam-message-info: PRGN1nlqHqJUIde6FlygfJwiQeC9umVh/xLyDfPWUFbp1+P7y9/ROiImKcmK8jUkzaTGXiUCl0AcHCdOGuNDUIcQs+Z/F3SWCQGJJY3PrcROkFAU4ubQV9MeoZxI790j4yrlgPi4U2p5N6lcgt6zilfnk0kVNDQR/oTwmMvfXYZhOrsGnDU1IStAVGlCFUux9+wBK9C/UV/DX9pbzmXDjy0ryYiX9iEATbJND2vr2O4u5X0OpY4ISQ31WgDPOZ22O9bQIs4QuTIqra7ONzCxDz/WHKKzHGXRtLY2yt2brZvsyVUqhkZSPWcsX8f7MvUGwnDrbeL+Pn6sxj7BAsA5252fMoT1KxeXgMc5gwG4Ta/O1hCoTDjwKVHpvUu6gRsVwvsafkmvi4ZVbvYR6ckZnjxstSBz35ksAwM0hhmn4YyCubcb3o8tOO14nD50vad/7wYEN3hjPohBrguc7aTJvBIewe0AnnzRGljFmPPuzy4TOAKStyUzhXNC2R2D/DebXCMtyiVPfTyD4VizG3GGryd0WYLAKCqXJcsTeOsODrswZJDtkh6VJlHiquKys/QxZ0Pcr/isxMeVoIrFKGZhrqeNI4pWjcH5ndMaVnlLTZAIb49pAqpEEl76MnKKRlIBaK7M3gnyy0GSwJCwxBtqdlYfuyncDOLa/MasdORHjOZ2X5IF7DfWcGE/PPNW4A8Uvt9aQpzT35smH5R0pClgPqskxVMHgLXeLRH1/KWFMd0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?I5XMkDd6Ub0x0TWxchyUe+/iwdNHK/0sg0alV8uB8a0iQG/nx36PZA0b?=
 =?Windows-1252?Q?VJb50Y/JOr9mIVxEjvdolya/h2NjqlNhOaBltNzZfWTQ2il9hH6gDLuW?=
 =?Windows-1252?Q?2I7phKFb/8geb0cQZBXIBa4uNTGXq9V5BO25la37VYTnL9JiZI/d/0Ti?=
 =?Windows-1252?Q?6IIxlhK1crEvz4uv0OceDMLYK7g+dhC4yhPXlBtAc2W8EDG2qVytFqdo?=
 =?Windows-1252?Q?f+geKnggEt/YtuMBPU7fNgyXAr7ceeK/wPwes8T4QbLFKFCJonBwD2/E?=
 =?Windows-1252?Q?0Md1w6PvgiIU3U6Ky1J9ZMDmBrkQ6v6dWr55ot2PdFNHF9n8w8u5MWa4?=
 =?Windows-1252?Q?tgfowCylHwdkWVaKws182oNBvTf+MpH2BDq7K0CEoYbFZl1A/+FoEd0O?=
 =?Windows-1252?Q?UrAUsGI3mpWgB6eQ8YCo07DaBhGOzFKYaQpM64c5i0etOBY6E+c0dp6S?=
 =?Windows-1252?Q?0ojhMzvop1zhWqhhB1fATi0Vef0+imtyM0TCpeDriSlrlQCjHkr9oUHJ?=
 =?Windows-1252?Q?QeOcDbXqt+LVBXa9vILIs1I7mo6PaS7r6Snq1AwnVCKo5AHwPVkb8iH6?=
 =?Windows-1252?Q?WZl3y8WUyOjN+0rtSyg2U4nQW4wwOIowp1I8DtRvGu58DT4aUFi9YQTf?=
 =?Windows-1252?Q?8z0t2vQY2NF/clrHNGTUub1H9/7UumC/O+IG2Rsazj5jqkoTMZQTb0GZ?=
 =?Windows-1252?Q?2pvF4MH1Fi498kwyS7SIeO/3kpiE+scWeNhQB29/2lHOlK9KX8udfOEa?=
 =?Windows-1252?Q?2Bez0ZP0Jv4O5Qm7BtVi/oITAnwRxTHv6iB9im4b7QyYk7zg41KwxT8/?=
 =?Windows-1252?Q?/hKJDTH4/ipp60MmvCzmpYWJdn3AU9oHXR90SjvIaZnZ1csDQjclXXik?=
 =?Windows-1252?Q?G2nV47SOVAfmnxAaM7k57centkuZSoOiwhPz07c95KkMSV9UBtt4TM4S?=
 =?Windows-1252?Q?ToB7yZFVaEVrmlBqmlJvzwe7oAyYJJgIy3nO0GqTeD5p5k0iy50sYM5c?=
 =?Windows-1252?Q?qzTA+m0O3XfHrX+VGwxl5fCCBaN4dhe/Cwx+uGue+BwhI21tqrxIkCSf?=
 =?Windows-1252?Q?ygORbJ3kCuHQ/hgLe/riH09MU7vPWzIDaoit4IjWuCLwp3iQxjkmNOW1?=
 =?Windows-1252?Q?suV8LEYPhW6jM8oWvyMa8vytrVzXng5nHRnfAYclGGQo8qxOuFLhlm1W?=
 =?Windows-1252?Q?KKxD5Q85lfnICvHsZJ6YmyUaqDMVH4i3j9GvdXAfwQWQ8tqkXnLyv0Kf?=
 =?Windows-1252?Q?guUhab3ZritbTzptkeAHyCTfvFjagkJeFVmjtFYUrANE7u705ja1ojTY?=
 =?Windows-1252?Q?/1QWI6tCMDStbCJ2xFDyc3Qsq+qGf0A1MDoR1SRhpu+ImRPxWE3Zrr9q?=
 =?Windows-1252?Q?xKGUFEYRhU23e9lrmjOyhOFEKNZoFVBAN2gAlr3aArgipVn1Ytvxfzod?=
 =?Windows-1252?Q?7/K8bfZWlo/e10Fwnlx33hXa/ZkdAd/4L2Mnw+TIHbm+gTaClc6eHyZC?=
 =?Windows-1252?Q?UCWGGQ173+Sw9vtopxu3fiex/DZ4RH4zrh7J1K7VoV11Vx5n20bh22Wj?=
 =?Windows-1252?Q?8JKYjj7caUomGTQaqnC5CMI99U/ysCbrlSfW7J1rBIYLbklDtKMktIkf?=
 =?Windows-1252?Q?RQ8JEbbtUqaORYblheN85K2mOkLFZCfzG7sTumkgTy+SFm0muwKHcA6K?=
 =?Windows-1252?Q?oMnqeGVNa58SrlKFNfFIVYpkRbLPYkaZLrR3ySgCiZHH3DNvQPmU+CKk?=
 =?Windows-1252?Q?ndEl67IFRj/H1qQx0VvnEwwyIyDMt3tZA6+it+nm+OTaLqLwPZKDfV2f?=
 =?Windows-1252?Q?VQeoBoPCgsgPk1Ksge9Mg4IW6Dq76MzSOY8QK1EfrSEJvy0g4iO7f9YW?=
 =?Windows-1252?Q?FwNf/cmMic2bgg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA0PR12MB70915BCDD0BE98B2F8B54A0E978B2SA0PR12MB7091namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d6c563-a32b-4433-13f6-08df1ebbfb46
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 06:28:03.3193 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JIryp7124iCfg+Tj/7BRoQuvVVZurahYpzde4tvOYiEyfnDqDvlrnhjv3VHaxWOC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524
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

--_000_SA0PR12MB70915BCDD0BE98B2F8B54A0E978B2SA0PR12MB7091namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

AMD General

The actual reset sequence is run by the FW while you are polling for the re=
sponse. This patch doesn't make any sense in that way.

Thanks,
Lijo
________________________________
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Wednesday, 30 September 2026 11:47:46
To: Wang, Kevin <Kevin.Wang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Deu=
cher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.K=
oenig@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.or=
g>
Cc: Yuan, Perry <Perry.Yuan@amd.com>
Subject: RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset=
 on gfx12

AMD General

Yes. In addition, the polling happens inside smu_cmn_send_smc_msg(), which =
runs before PCI_COMMAND_MEMORY is cleared. During the mode1 reset process t=
here should be no traffic to the PCIe BARs; otherwise, the PCI bus may hang=
.

Also, every PCI config write in the patch targets only the GPU device itsel=
f (pci_write_config_dword is per device), so no other PCI devices are affec=
ted.

-----Original Message-----
From: Wang, Kevin <Kevin.Wang@amd.com>
Sent: Wednesday, September 30, 2026 2:09 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; =
Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christia=
n.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Yuan, Perry <Perry.Yuan@amd.com>
Subject: RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset=
 on gfx12

AMD General

> On a second look, the patch doesn't seem right. Reset sequence is
> supposed to be complete by the time FW responds back to the mode-1 reset =
message.
> During reset sequence, we need Mem space to be enabled to poll success
> status of the message and that's most volatile window during the whole
> sequence.

That is not right. When the OS driver polls and sees the response register =
become "1", it does **NOT** mean the mode1 sequence is completed.
The PMFW will continue forward the message to PSP and wait for PMFW ucode r=
eload to finish at a 2nd-half stage.

Best Regards,
Kevin

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Lazar, Lijo
> Sent: Wednesday, September 30, 2026 1:41 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Yuan, Perry <Perry.Yuan@amd.com>
> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1
> reset on gfx12
>
> On a second look, the patch doesn't seem right. Reset sequence is
> supposed to be complete by the time FW responds back to the mode-1 reset =
message.
> During reset sequence, we need Mem space to be enabled to poll success
> status of the message and that's most volatile window during the whole
> sequence.
>
> Disabling the memory space after reset sequence is complete looks to
> be the wrong diagnosis of the issue. Access during reinit sequence
> after reset is safe and shouldn't cause any issue in general.
>
> That said, we should try to resolve the issue without touching any PCI
> config settings. PCI config space is open for others as well.
>
> Thanks,
> Lijo
>
> On 30-Sep-26 10:57 AM, Zhang, Yifan wrote:
> > AMD General
> >
> > How about disable UE during mode1 reset ? E.g.
> >
> > Before:
> >          pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &saved_devctl)=
;
> >          pcie_capability_write_word(pdev, PCI_EXP_DEVCTL,
> >                                     saved_devctl & ~PCI_EXP_DEVCTL_URRE=
);
> >          pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK,
> >                                        &saved_uemsk);
> >          pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK,
> >                                         saved_uemsk |
> > PCI_ERR_UNC_UNSUP);
> >
> >
> > After:
> >          pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK,
> >                                         saved_uemsk);
> >          pcie_capability_write_word(pdev, PCI_EXP_DEVCTL,
> > saved_devctl);
> >
> > -----Original Message-----
> > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > Sent: Wednesday, September 30, 2026 11:37 AM
> > To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Yuan, Perry <Perry.Yuan@amd.com>
> > Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
> > mode1 reset on gfx12
> >
> >
> > This is the behaviour of this bit -
> >
> >          Memory Space Enable - Controls a Function's response to
> > Memory  Space accesses. When this bit is Clear, all received Memory
> > Space
> accesses are caused to be handled as "Unsupported Requests"
> >
> > On AER enabled systems, depending on how the platform is configured
> > to
> classify the severity of UR errors, that could result in System error.
> >
> > On other hand, if you are sure that there is no such access during
> > mode-1 reset, we don't need this patch in the first place.
> >
> > Thanks,
> > Lijo
> >
> >
> > On 30-Sep-26 8:53 AM, Zhang, Yifan wrote:
> >> AMD General
> >>
> >> Hi Lijo,
> >>
> >> Why does clearing PCI_COMMAND_MEMORY cause AER errors on data
> center GPUs? Are their PCIe BARs still being accessed during a mode1 rese=
t?
> >>
> >> Best Regards,
> >> Yifan
> >>
> >> -----Original Message-----
> >> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> >> Sent: Wednesday, September 30, 2026 11:06 AM
> >> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Deucher, Alexander
> >> <Alexander.Deucher@amd.com>; Koenig, Christian
> >> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> >> Cc: Yuan, Perry <Perry.Yuan@amd.com>
> >> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
> >> mode1 reset on gfx12
> >>
> >> This doesn't work for all (at least on some datacenter GPUs). With
> >> AER
> enabled, this will result in AER errors. Depending on the platform
> config, some may classify this access as fatal.
> >>
> >> Thanks,
> >> Lijo
> >>
> >> On 30-Sep-26 8:25 AM, Zhang, Yifan wrote:
> >>> Public
> >>>
> >>>
> >>> Hi Alex,
> >>>
> >>> I think it is reasonable to apply the patch to all ASICs. I will
> >>> sync with the hardware team about this change; so far we have only
> >>> tested it on Navi31.
> >>>
> >>> How about adding a common helper and calling it from ASIC-specific
> >>> code, starting with Navi31? For example:
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> b/drivers/gpu/ drm/amd/amdgpu/amdgpu_device.c
> >>>
> >>> index b690a07e31ab..075de681ab86 100644
> >>>
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>
> >>> @@ -4931,6 +4931,28 @@ bool
> amdgpu_device_should_recover_gpu(struct
> >>> amdgpu_device *adev)
> >>>
> >>>                    return false;
> >>>
> >>> }
> >>>
> >>> +void amdgpu_device_mode1_reset_wait(struct amdgpu_device *adev,
> >>>
> >>> +                                   unsigned int delay_ms)
> >>>
> >>> +{
> >>>
> >>> +       u16 saved_cmd, cmd;
> >>>
> >>> +
> >>>
> >>> +       pci_read_config_word(adev->pdev, PCI_COMMAND, &saved_cmd);
> >>>
> >>> +       cmd =3D saved_cmd & ~PCI_COMMAND_MEMORY;
> >>>
> >>> +       pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
> >>>
> >>> +
> >>>
> >>> +       msleep(delay_ms);
> >>>
> >>> +
> >>>
> >>> +       pci_write_config_word(adev->pdev, PCI_COMMAND, saved_cmd);
> >>>
> >>> +}
> >>>
> >>> +
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> >>> b/drivers/ gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> >>>
> >>> index b250c5e41e45..356e09b7eef9 100644
> >>>
> >>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> >>>
> >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> >>>
> >>> @@ -2242,7 +2242,8 @@ int smu_v13_0_mode1_reset(struct
> smu_context
> >>> *smu)
> >>>
> >>>            ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset,
> >>> NULL);
> >>>
> >>>            if (!ret)
> >>>
> >>> -               msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
> >>>
> >>> +               amdgpu_device_mode1_reset_wait(smu->adev,
> >>>
> >>> +
> >>> SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
> >>>
> >>>            return ret;
> >>>
> >>> }
> >>>
> >>> Best Regards,
> >>>
> >>> Yifan
> >>>
> >>> *From:*Deucher, Alexander <Alexander.Deucher@amd.com>
> >>> *Sent:* Wednesday, September 30, 2026 2:59 AM
> >>> *To:* Zhang, Yifan <Yifan1.Zhang@amd.com>; Koenig, Christian
> >>> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> >>> *Cc:* Yuan, Perry <Perry.Yuan@amd.com>
> >>> *Subject:* Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
> >>> mode1 reset on gfx12
> >>>
> >>> Public
> >>>
> >>> I think this should be asic agnostic.  Any asic doing mode1 reset
> >>> should do this?
> >>>
> >>> Alex
> >>>
> >>> ------------------------------------------------------------------
> >>> --
> >>> -
> >>> -
> >>> --
> >>>
> >>> *From:*Zhang, Yifan <Yifan1.Zhang@amd.com
> >>> <mailto:Yifan1.Zhang@amd.com>>
> >>> *Sent:* Tuesday, September 29, 2026 5:36 AM
> >>> *To:* Koenig, Christian <Christian.Koenig@amd.com
> >>> <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org
> >>> <mailto:amd-gfx@lists.freedesktop.org>
> >>> <amd-gfx@lists.freedesktop.org
> >>> <mailto:amd-gfx@lists.freedesktop.org>>
> >>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com
> >>> <mailto:Alexander.Deucher@amd.com>>; Yuan, Perry
> <Perry.Yuan@amd.com
> >>> <mailto:Perry.Yuan@amd.com>>
> >>> *Subject:* RE: [PATCH] amdgpu/pm: block GPU PCI bar access during
> >>> mode1 reset on gfx12
> >>>
> >>> Public
> >>>
> >>> Hi Christian,
> >>>
> >>> The no_hw_access flag was first set in commit
> >>> 0de604d0357d0d22cbf03af1077d174b641707b6. This was intended to fix
> >>> the Mode 1 reset hang, but it proved insufficient.
> >>> I think the flag was set in the SMU code so that it would apply
> >>> only to
> >>> SMU13/14 ASICs, without affecting the Mode 1 reset process on
> >>> other
> ASICs.
> >>> I=92m not sure whether we can drop the no_hw_access flag after
> >>> disabling PCI_COMMAND_MEMORY. The PCI hang occurs intermittently,
> so
> >>> we may need another round of stress testing to confirm that the
> >>> flag is no longer needed. Should we remove no_hw_access in a
> >>> separate
> patch?
> >>>
> >>> Best Regards,
> >>> Yifan
> >>>
> >>> -----Original Message-----
> >>> From: Koenig, Christian <Christian.Koenig@amd.com
> >>> <mailto:Christian.Koenig@amd.com>>
> >>> Sent: Tuesday, September 29, 2026 5:06 PM
> >>> To: Zhang, Yifan <Yifan1.Zhang@amd.com
> >>> <mailto:Yifan1.Zhang@amd.com>>; amd-gfx@lists.freedesktop.org
> >>> <mailto:amd-gfx@lists.freedesktop.org>
> >>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com
> >>> <mailto:Alexander.Deucher@amd.com>>; Yuan, Perry
> <Perry.Yuan@amd.com
> >>> <mailto:Perry.Yuan@amd.com>>
> >>> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
> >>> mode1 reset on gfx12
> >>>
> >>> On 9/29/26 04:25, Yifan Zhang wrote:
> >>>> block GPU PCI bar access during mode1 reset on gfx12, to resolve
> >>>> the random mode1 reset hang issue.
> >>>
> >>> Interesting idea, that is much simpler than trying to mess with
> >>> CPU page tables in the GPU reset path.
> >>>
> >>> The only downside I can see is that we now drop VRAM and doorbell
> >>> writes, but I think that won't matter since VRAM is lost by a
> >>> mode1 reset anyway.
> >>>
> >>> MMIO writes are dropped as well which means that we can also drop
> >>> the no_hw_access flag.
> >>>
> >>> And BTW the SMU code should absolutely *NOT* touch that
> no_hw_access
> >>> flag in any way. Who added that there?
> >>>
> >>> Regards,
> >>> Christian.
> >>>
> >>>>
> >>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com
> >>>> <mailto:yifan1.zhang@amd.com>>
> >>>> ---
> >>>>    .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 29
> >>>> ++++++++++++-------
> >>>>    1 file changed, 19 insertions(+), 10 deletions(-)
> >>>>
> >>>> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> >>>> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> >>>> index 072d9c4e202d..25b9085ead71 100644
> >>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> >>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> >>>> @@ -2078,21 +2078,30 @@ static int
> >>>> smu_v14_0_2_set_df_cstate(struct smu_context *smu,
> >>>>
> >>>>    static int smu_v14_0_2_mode1_reset(struct smu_context *smu)  {
> >>>> +     struct amdgpu_device *adev =3D smu->adev;
> >>>> +     u16 saved_cmd, cmd;
> >>>>         int ret =3D 0;
> >>>>
> >>>>         ret =3D smu_cmn_send_debug_smc_msg(smu,
> DEBUGSMC_MSG_Mode1Reset);
> >>>> -     if (!ret) {
> >>>> -             if (amdgpu_emu_mode =3D=3D 1) {
> >>>> -                     msleep(50000);
> >>>> -             } else {
> >>>> -                     /* disable mmio access while doing mode 1
> >>>> reset*/
> >>>> -                     smu->adev->no_hw_access =3D true;
> >>>> -                     /* ensure no_hw_access is globally visible
> >>>> before any MMIO */
> >>>> -                     smp_mb();
> >>>> -                     msleep(1000);
> >>>> -             }
> >>>> +     if (ret)
> >>>> +             return ret;
> >>>> +
> >>>> +     pci_read_config_word(adev->pdev, PCI_COMMAND, &saved_cmd);
> >>>> +     cmd =3D saved_cmd & ~PCI_COMMAND_MEMORY;
> >>>> +     pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
> >>>> +
> >>>> +     if (amdgpu_emu_mode =3D=3D 1) {
> >>>> +             msleep(50000);
> >>>> +     } else {
> >>>> +             /* disable mmio access while doing mode 1 reset*/
> >>>> +             smu->adev->no_hw_access =3D true;
> >>>> +             /* ensure no_hw_access is globally visible before
> >>>> +any MMIO */
> >>>> +             smp_mb();
> >>>> +             msleep(1000);
> >>>>         }
> >>>>
> >>>> +     pci_write_config_word(adev->pdev, PCI_COMMAND, saved_cmd);
> >>>> +
> >>>>         return ret;
> >>>>    }
> >>>>
> >>>
> >>
> >



--_000_SA0PR12MB70915BCDD0BE98B2F8B54A0E978B2SA0PR12MB7091namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
The actual reset sequence is run by the FW while you are polling for the re=
sponse. This patch doesn't make any sense in that way.</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system=
, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(33, 33, 33);" =
id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Thanks,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Lijo</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Yifan &lt;Yifa=
n1.Zhang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, 30 September 2026 11:47:46<br>
<b>To:</b> Wang, Kevin &lt;Kevin.Wang@amd.com&gt;; Lazar, Lijo &lt;Lijo.Laz=
ar@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koeni=
g, Christian &lt;Christian.Koenig@amd.com&gt;; amd-gfx@lists.freedesktop.or=
g &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Yuan, Perry &lt;Perry.Yuan@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode=
1 reset on gfx12</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">AMD General<br>
<br>
Yes. In addition, the polling happens inside smu_cmn_send_smc_msg(), which =
runs before PCI_COMMAND_MEMORY is cleared. During the mode1 reset process t=
here should be no traffic to the PCIe BARs; otherwise, the PCI bus may hang=
.<br>
<br>
Also, every PCI config write in the patch targets only the GPU device itsel=
f (pci_write_config_dword is per device), so no other PCI devices are affec=
ted.<br>
<br>
-----Original Message-----<br>
From: Wang, Kevin &lt;Kevin.Wang@amd.com&gt;<br>
Sent: Wednesday, September 30, 2026 2:09 PM<br>
To: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Zhang, Yifan &lt;Yifan1.Zhang@a=
md.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, C=
hristian &lt;Christian.Koenig@amd.com&gt;; amd-gfx@lists.freedesktop.org<br=
>
Cc: Yuan, Perry &lt;Perry.Yuan@amd.com&gt;<br>
Subject: RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset=
 on gfx12<br>
<br>
AMD General<br>
<br>
&gt; On a second look, the patch doesn't seem right. Reset sequence is<br>
&gt; supposed to be complete by the time FW responds back to the mode-1 res=
et message.<br>
&gt; During reset sequence, we need Mem space to be enabled to poll success=
<br>
&gt; status of the message and that's most volatile window during the whole=
<br>
&gt; sequence.<br>
<br>
That is not right. When the OS driver polls and sees the response register =
become &quot;1&quot;, it does **NOT** mean the mode1 sequence is completed.=
<br>
The PMFW will continue forward the message to PSP and wait for PMFW ucode r=
eload to finish at a 2nd-half stage.<br>
<br>
Best Regards,<br>
Kevin<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf =
Of<br>
&gt; Lazar, Lijo<br>
&gt; Sent: Wednesday, September 30, 2026 1:41 PM<br>
&gt; To: Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; Deucher, Alexander<br>
&gt; &lt;Alexander.Deucher@amd.com&gt;; Koenig, Christian<br>
&gt; &lt;Christian.Koenig@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Yuan, Perry &lt;Perry.Yuan@amd.com&gt;<br>
&gt; Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1<=
br>
&gt; reset on gfx12<br>
&gt;<br>
&gt; On a second look, the patch doesn't seem right. Reset sequence is<br>
&gt; supposed to be complete by the time FW responds back to the mode-1 res=
et message.<br>
&gt; During reset sequence, we need Mem space to be enabled to poll success=
<br>
&gt; status of the message and that's most volatile window during the whole=
<br>
&gt; sequence.<br>
&gt;<br>
&gt; Disabling the memory space after reset sequence is complete looks to<b=
r>
&gt; be the wrong diagnosis of the issue. Access during reinit sequence<br>
&gt; after reset is safe and shouldn't cause any issue in general.<br>
&gt;<br>
&gt; That said, we should try to resolve the issue without touching any PCI=
<br>
&gt; config settings. PCI config space is open for others as well.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;<br>
&gt; On 30-Sep-26 10:57 AM, Zhang, Yifan wrote:<br>
&gt; &gt; AMD General<br>
&gt; &gt;<br>
&gt; &gt; How about disable UE during mode1 reset ? E.g.<br>
&gt; &gt;<br>
&gt; &gt; Before:<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcie_capabi=
lity_read_word(pdev, PCI_EXP_DEVCTL, &amp;saved_devctl);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcie_capabi=
lity_write_word(pdev, PCI_EXP_DEVCTL,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 saved_devctl &amp; ~PCI_EXP_DEVCTL_URRE);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_read_co=
nfig_dword(pdev, aer + PCI_ERR_UNCOR_MASK,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; &amp;saved_uemsk);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_write_c=
onfig_dword(pdev, aer + PCI_ERR_UNCOR_MASK,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; saved_uemsk |<br>
&gt; &gt; PCI_ERR_UNC_UNSUP);<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; After:<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_write_c=
onfig_dword(pdev, aer + PCI_ERR_UNCOR_MASK,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; saved_uemsk);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcie_capabi=
lity_write_word(pdev, PCI_EXP_DEVCTL,<br>
&gt; &gt; saved_devctl);<br>
&gt; &gt;<br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
&gt; &gt; Sent: Wednesday, September 30, 2026 11:37 AM<br>
&gt; &gt; To: Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; Deucher, Alexander=
<br>
&gt; &gt; &lt;Alexander.Deucher@amd.com&gt;; Koenig, Christian<br>
&gt; &gt; &lt;Christian.Koenig@amd.com&gt;; amd-gfx@lists.freedesktop.org<b=
r>
&gt; &gt; Cc: Yuan, Perry &lt;Perry.Yuan@amd.com&gt;<br>
&gt; &gt; Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during<b=
r>
&gt; &gt; mode1 reset on gfx12<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; This is the behaviour of this bit -<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory Spac=
e Enable - Controls a Function's response to<br>
&gt; &gt; Memory&nbsp; Space accesses. When this bit is Clear, all received=
 Memory<br>
&gt; &gt; Space<br>
&gt; accesses are caused to be handled as &quot;Unsupported Requests&quot;<=
br>
&gt; &gt;<br>
&gt; &gt; On AER enabled systems, depending on how the platform is configur=
ed<br>
&gt; &gt; to<br>
&gt; classify the severity of UR errors, that could result in System error.=
<br>
&gt; &gt;<br>
&gt; &gt; On other hand, if you are sure that there is no such access durin=
g<br>
&gt; &gt; mode-1 reset, we don't need this patch in the first place.<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt; Lijo<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On 30-Sep-26 8:53 AM, Zhang, Yifan wrote:<br>
&gt; &gt;&gt; AMD General<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Hi Lijo,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Why does clearing PCI_COMMAND_MEMORY cause AER errors on data=
<br>
&gt; center GPUs? Are their PCIe BARs still being accessed during a mode1 r=
eset?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Best Regards,<br>
&gt; &gt;&gt; Yifan<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
&gt; &gt;&gt; Sent: Wednesday, September 30, 2026 11:06 AM<br>
&gt; &gt;&gt; To: Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; Deucher, Alexa=
nder<br>
&gt; &gt;&gt; &lt;Alexander.Deucher@amd.com&gt;; Koenig, Christian<br>
&gt; &gt;&gt; &lt;Christian.Koenig@amd.com&gt;; amd-gfx@lists.freedesktop.o=
rg<br>
&gt; &gt;&gt; Cc: Yuan, Perry &lt;Perry.Yuan@amd.com&gt;<br>
&gt; &gt;&gt; Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access duri=
ng<br>
&gt; &gt;&gt; mode1 reset on gfx12<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This doesn't work for all (at least on some datacenter GPUs).=
 With<br>
&gt; &gt;&gt; AER<br>
&gt; enabled, this will result in AER errors. Depending on the platform<br>
&gt; config, some may classify this access as fatal.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt; Lijo<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 30-Sep-26 8:25 AM, Zhang, Yifan wrote:<br>
&gt; &gt;&gt;&gt; Public<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Hi Alex,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; I think it is reasonable to apply the patch to all ASICs.=
 I will<br>
&gt; &gt;&gt;&gt; sync with the hardware team about this change; so far we =
have only<br>
&gt; &gt;&gt;&gt; tested it on Navi31.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; How about adding a common helper and calling it from ASIC=
-specific<br>
&gt; &gt;&gt;&gt; code, starting with Navi31? For example:<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<b=
r>
&gt; &gt;&gt;&gt; b/drivers/gpu/ drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; index b690a07e31ab..075de681ab86 100644<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; @@ -4931,6 +4931,28 @@ bool<br>
&gt; amdgpu_device_should_recover_gpu(struct<br>
&gt; &gt;&gt;&gt; amdgpu_device *adev)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; }<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +void amdgpu_device_mode1_reset_wait(struct amdgpu_device=
 *adev,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
nsigned int delay_ms)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +{<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 saved_cmd, cmd;=
<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_read_config_wor=
d(adev-&gt;pdev, PCI_COMMAND, &amp;saved_cmd);<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd =3D saved_cmd &=
amp; ~PCI_COMMAND_MEMORY;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_write_config_wo=
rd(adev-&gt;pdev, PCI_COMMAND, cmd);<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(delay_ms);<b=
r>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_write_config_wo=
rd(adev-&gt;pdev, PCI_COMMAND, saved_cmd);<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +}<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0=
.c<br>
&gt; &gt;&gt;&gt; b/drivers/ gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; index b250c5e41e45..356e09b7eef9 100644<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; @@ -2242,7 +2242,8 @@ int smu_v13_0_mode1_reset(struct<br=
>
&gt; smu_context<br>
&gt; &gt;&gt;&gt; *smu)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset,<br>
&gt; &gt;&gt;&gt; NULL);<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; if (!ret)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_mode1_reset_wait(smu-&gt;adev,<b=
r>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; SMU13_MODE1_RESET_WAIT_TIME_IN_MS);<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; return ret;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; }<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Best Regards,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Yifan<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; *From:*Deucher, Alexander &lt;Alexander.Deucher@amd.com&g=
t;<br>
&gt; &gt;&gt;&gt; *Sent:* Wednesday, September 30, 2026 2:59 AM<br>
&gt; &gt;&gt;&gt; *To:* Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; Koenig, =
Christian<br>
&gt; &gt;&gt;&gt; &lt;Christian.Koenig@amd.com&gt;; amd-gfx@lists.freedeskt=
op.org<br>
&gt; &gt;&gt;&gt; *Cc:* Yuan, Perry &lt;Perry.Yuan@amd.com&gt;<br>
&gt; &gt;&gt;&gt; *Subject:* Re: [PATCH] amdgpu/pm: block GPU PCI bar acces=
s during<br>
&gt; &gt;&gt;&gt; mode1 reset on gfx12<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Public<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; I think this should be asic agnostic.&nbsp; Any asic doin=
g mode1 reset<br>
&gt; &gt;&gt;&gt; should do this?<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Alex<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; ---------------------------------------------------------=
---------<br>
&gt; &gt;&gt;&gt; --<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; --<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; *From:*Zhang, Yifan &lt;Yifan1.Zhang@amd.com<br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:Yifan1.Zhang@amd.com">mailto:Yifan1=
.Zhang@amd.com</a>&gt;&gt;<br>
&gt; &gt;&gt;&gt; *Sent:* Tuesday, September 29, 2026 5:36 AM<br>
&gt; &gt;&gt;&gt; *To:* Koenig, Christian &lt;Christian.Koenig@amd.com<br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:Christian.Koenig@amd.com">mailto:Ch=
ristian.Koenig@amd.com</a>&gt;&gt;; amd-gfx@lists.freedesktop.org<br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">mail=
to:amd-gfx@lists.freedesktop.org</a>&gt;<br>
&gt; &gt;&gt;&gt; &lt;amd-gfx@lists.freedesktop.org<br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">mail=
to:amd-gfx@lists.freedesktop.org</a>&gt;&gt;<br>
&gt; &gt;&gt;&gt; *Cc:* Deucher, Alexander &lt;Alexander.Deucher@amd.com<br=
>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">mailto:A=
lexander.Deucher@amd.com</a>&gt;&gt;; Yuan, Perry<br>
&gt; &lt;Perry.Yuan@amd.com<br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:Perry.Yuan@amd.com">mailto:Perry.Yu=
an@amd.com</a>&gt;&gt;<br>
&gt; &gt;&gt;&gt; *Subject:* RE: [PATCH] amdgpu/pm: block GPU PCI bar acces=
s during<br>
&gt; &gt;&gt;&gt; mode1 reset on gfx12<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Public<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Hi Christian,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; The no_hw_access flag was first set in commit<br>
&gt; &gt;&gt;&gt; 0de604d0357d0d22cbf03af1077d174b641707b6. This was intend=
ed to fix<br>
&gt; &gt;&gt;&gt; the Mode 1 reset hang, but it proved insufficient.<br>
&gt; &gt;&gt;&gt; I think the flag was set in the SMU code so that it would=
 apply<br>
&gt; &gt;&gt;&gt; only to<br>
&gt; &gt;&gt;&gt; SMU13/14 ASICs, without affecting the Mode 1 reset proces=
s on<br>
&gt; &gt;&gt;&gt; other<br>
&gt; ASICs.<br>
&gt; &gt;&gt;&gt; I=92m not sure whether we can drop the no_hw_access flag =
after<br>
&gt; &gt;&gt;&gt; disabling PCI_COMMAND_MEMORY. The PCI hang occurs intermi=
ttently,<br>
&gt; so<br>
&gt; &gt;&gt;&gt; we may need another round of stress testing to confirm th=
at the<br>
&gt; &gt;&gt;&gt; flag is no longer needed. Should we remove no_hw_access i=
n a<br>
&gt; &gt;&gt;&gt; separate<br>
&gt; patch?<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Best Regards,<br>
&gt; &gt;&gt;&gt; Yifan<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt;&gt; From: Koenig, Christian &lt;Christian.Koenig@amd.com<br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:Christian.Koenig@amd.com">mailto:Ch=
ristian.Koenig@amd.com</a>&gt;&gt;<br>
&gt; &gt;&gt;&gt; Sent: Tuesday, September 29, 2026 5:06 PM<br>
&gt; &gt;&gt;&gt; To: Zhang, Yifan &lt;Yifan1.Zhang@amd.com<br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:Yifan1.Zhang@amd.com">mailto:Yifan1=
.Zhang@amd.com</a>&gt;&gt;; amd-gfx@lists.freedesktop.org<br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">mail=
to:amd-gfx@lists.freedesktop.org</a>&gt;<br>
&gt; &gt;&gt;&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com<br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">mailto:A=
lexander.Deucher@amd.com</a>&gt;&gt;; Yuan, Perry<br>
&gt; &lt;Perry.Yuan@amd.com<br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:Perry.Yuan@amd.com">mailto:Perry.Yu=
an@amd.com</a>&gt;&gt;<br>
&gt; &gt;&gt;&gt; Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access =
during<br>
&gt; &gt;&gt;&gt; mode1 reset on gfx12<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; On 9/29/26 04:25, Yifan Zhang wrote:<br>
&gt; &gt;&gt;&gt;&gt; block GPU PCI bar access during mode1 reset on gfx12,=
 to resolve<br>
&gt; &gt;&gt;&gt;&gt; the random mode1 reset hang issue.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Interesting idea, that is much simpler than trying to mes=
s with<br>
&gt; &gt;&gt;&gt; CPU page tables in the GPU reset path.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; The only downside I can see is that we now drop VRAM and =
doorbell<br>
&gt; &gt;&gt;&gt; writes, but I think that won't matter since VRAM is lost =
by a<br>
&gt; &gt;&gt;&gt; mode1 reset anyway.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; MMIO writes are dropped as well which means that we can a=
lso drop<br>
&gt; &gt;&gt;&gt; the no_hw_access flag.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; And BTW the SMU code should absolutely *NOT* touch that<b=
r>
&gt; no_hw_access<br>
&gt; &gt;&gt;&gt; flag in any way. Who added that there?<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Regards,<br>
&gt; &gt;&gt;&gt; Christian.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com<b=
r>
&gt; &gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:yifan1.zhang@amd.com">mailto:yi=
fan1.zhang@amd.com</a>&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; .../drm/amd/pm/swsmu/smu14/smu_v14_=
0_2_ppt.c&nbsp; | 29<br>
&gt; &gt;&gt;&gt;&gt; ++++++++++++-------<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 19 insertions(+), 1=
0 deletions(-)<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; diff --git<br>
&gt; a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c<br>
&gt; &gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.=
c<br>
&gt; &gt;&gt;&gt;&gt; index 072d9c4e202d..25b9085ead71 100644<br>
&gt; &gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_=
ppt.c<br>
&gt; &gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_=
ppt.c<br>
&gt; &gt;&gt;&gt;&gt; @@ -2078,21 +2078,30 @@ static int<br>
&gt; &gt;&gt;&gt;&gt; smu_v14_0_2_set_df_cstate(struct smu_context *smu,<br=
>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; static int smu_v14_0_2_mode1_reset(=
struct smu_context *smu)&nbsp; {<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D smu-&gt;adev;<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u16 saved_cmd, cmd;<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r=
et =3D 0;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D smu_cmn_send_debug_smc_msg(smu,<br>
&gt; DEBUGSMC_MSG_Mode1Reset);<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!ret) {<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (amdgpu_emu_mode =3D=3D 1) {<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep=
(50000);<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* dis=
able mmio access while doing mode 1<br>
&gt; &gt;&gt;&gt;&gt; reset*/<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&g=
t;adev-&gt;no_hw_access =3D true;<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ens=
ure no_hw_access is globally visible<br>
&gt; &gt;&gt;&gt;&gt; before any MMIO */<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smp_mb=
();<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep=
(1000);<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; pci_read_config_word(adev-&=
gt;pdev, PCI_COMMAND, &amp;saved_cmd);<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; cmd =3D saved_cmd &amp; ~PC=
I_COMMAND_MEMORY;<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; pci_write_config_word(adev-=
&gt;pdev, PCI_COMMAND, cmd);<br>
&gt; &gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_emu_mode =3D=3D =
1) {<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; msleep(50000);<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; /* disable mmio access while doing mode 1 reset*/<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; smu-&gt;adev-&gt;no_hw_access =3D true;<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; /* ensure no_hw_access is globally visible before<br>
&gt; &gt;&gt;&gt;&gt; +any MMIO */<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; smp_mb();<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; msleep(1000);<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; pci_write_config_word(adev-=
&gt;pdev, PCI_COMMAND, saved_cmd);<br>
&gt; &gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_SA0PR12MB70915BCDD0BE98B2F8B54A0E978B2SA0PR12MB7091namp_--
