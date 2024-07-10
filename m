Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F81C3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C94010E8D9;
	Wed, 10 Jul 2024 19:47:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tKhCiSwf";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA6610E8D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+iIDumkrw972yfcL1LSX6GBTlR00k65OyyV4JhuVPQH4nKXMuUMcYBSyIv3MbamdkLLun6Gvip5sJRwwfLy27n6Xd9GQM1mj46N8vYFEJzjQOHdTtOEy7cvSiMPypZzW0j+9ww6ivT1DVYLqDtyLTBo+Ir6vPZS+Cwv2Y6OXCQhzcJNeO5lZCzxI3cyUyiQoVwLctRDCYbNNrvQz80Bo7BVMGLIFw1gs4TUESpRtb6T9P9LOtMghx1qG05ftBKe/ITcDnf6ZhwmKIdACE4K67kIeCc07lxrget6Gg7cgwKAFPVG7lV/3x8QxA1ZpTfYGGV0THoRFA9dpLZFdOYOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9eTZqknSCQGziPcNGaVrltrddIqgeW4R+gQyTnqecg=;
 b=jw2NLifCAdJeLZru1UrSheRALWA4wHCA18b9UIZsT7+XuHlUfPODvRkmstiUZQ6Qw/tXmxMlMet3U0zPCUnO5BfePqkvWISHu/cTgX0i7n3BTT4UlMNFdcJ49/dpl0nI0xXJTG5eWF6eNo8tsSjPQG3dIkhzhag8BU6HytLR0adHK3TLUTGuZONyTYXUhFMrLJ42XhiGm655UExlpbjaWKw2AYFogFP01Sk/L+Zljq7yhESGSsZo3QAUQM3cgcT609YGa4eyhBvp6swjl2ysOA9dDAM3WiujF5lanHECZi241GxPs/TzNXGXVWNwPOIBXwkIPz1GWHBTN9LdzlzjOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9eTZqknSCQGziPcNGaVrltrddIqgeW4R+gQyTnqecg=;
 b=tKhCiSwfseReRRu4v7OiSgfKg3HJ/U3h8RUErocHkGr/notN4061ysv6vgFj79REKqu8u1/cLj15SJMCQDRz1CmoH/veqVZ+SrLdiCfKk7Tb8qJalGahZLk8sMZnI0MdFT94mTyF6YY0SQC0DQBpUuMntzSn/Ydkc3/o4Qys7/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Wed, 10 Jul
 2024 19:47:48 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%5]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 19:47:48 +0000
Message-ID: <90570011-55f1-4607-a4ea-dfd167f66315@amd.com>
Date: Wed, 10 Jul 2024 15:47:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Allow display DCC for DCN401
To: amd-gfx@lists.freedesktop.org
References: <20240708160610.1354015-1-aurabindo.pillai@amd.com>
 <CAAxE2A4gOcABsskv2e3Dwc_XVaXs-CmfK_D34nZgFjY3H_qY2w@mail.gmail.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <CAAxE2A4gOcABsskv2e3Dwc_XVaXs-CmfK_D34nZgFjY3H_qY2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::26) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a8c0da-40ef-4288-60bb-08dca1192cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aStjSDgyWTN0VHdVQ1h4bTFDcGxSVUs1clY3NXl3TWE0aEVpcVFoR0Zxb1la?=
 =?utf-8?B?WCtnRW9JUURGNm9pTWlIN1hHQVZQdStqRnRrRk03MzFiU3F0WVozVU5BZFNN?=
 =?utf-8?B?ZzNOcnB0cHFMeWt3bzY2dUIvRjByeXhuYTFTRUVhQmhnd0o4WkF5SERQZ01R?=
 =?utf-8?B?c2tiVzdMZTZ6bFNLV3NwcnphaDJ4eXZBa0RqOVZVRFFDVFJkSWFsaHFaSTZu?=
 =?utf-8?B?WXpheUdCZ3ROT1FoR0laaE5pK3RFUHZCYTB6aUtNcE9sRWtOdi9FR091U1hX?=
 =?utf-8?B?a0xVYUZqYUFMWXlNV0xGMXFDZE5HdWRJL0MzNDgyOTh2c0pNemhRTlRQcnVM?=
 =?utf-8?B?MnIvQ0JucGZKRlJTanhQVnF5bDJVeWxCbFA0NjFrZmdQT29GUmFOZW94Ky9o?=
 =?utf-8?B?ZXg2ek50c2xPM3BSNkxqT20wZnY4UFBYdFljVk9HeTdUKzNuVURtUC9TVzJ2?=
 =?utf-8?B?QlhFRGl5MVhUR2ZuenVIQzVoWGkrSVVwMW1QYWk1Nm42NXRMTWp6NkdubzVO?=
 =?utf-8?B?OExKQjNnSXVYSFZ3Q2M1TGt4RFROSFhaZG9BT0s5eUQwM0I2cWdNY0lha3hx?=
 =?utf-8?B?eTBSc242NGdNNm11NWNyV0dwQzFBN0lDUjUwbTFsd3RxZ1lPNVQ1SU54U1hU?=
 =?utf-8?B?ZmNMZ1Bzc3dyaUFraFQ3Q1pyQkdXMHU2cExqVktSK01uVjFreWNtNG9YclhC?=
 =?utf-8?B?NUx1S3pSMzhuVVpTZEk5YldvWGFMaTUwOVRhT1lpT2JXZnJZSDVrOUREZXdX?=
 =?utf-8?B?Um1oVXAxY0lEcFlvRis0QWhNUk44cUxrVG10M1NVUjQyYVNiNXY1cDNOMVJN?=
 =?utf-8?B?K1E3NUllZExWaUJPaXpTNE40anJoYmtPVnNrNjcrVEYzMWZweVdCYTdIQnV4?=
 =?utf-8?B?c0s4c3I0VUthdWRMTGJObkxYbThlZEMyUXhaOUUyREFvbWtZaHpQZU5NL1Mw?=
 =?utf-8?B?bGJUUGdleVlqUHV2MnlvNk51eWNvNEhzdEVlM0MzOHp0V0xTMFBQTjU1bWVS?=
 =?utf-8?B?dVpwem1XaEY4R1NaVC9ZQ0s3TU1sSmcwOEVaVUlGZ3FYVG5IMDFzRktneDN4?=
 =?utf-8?B?QUZETWVOM3FkZGNrRG5mK3ZaMSsvcEg2c2orRDMrdUVWSkcwdTRzWDlhd3ZT?=
 =?utf-8?B?cFo2NEtsdWJyWEJLRGJ0WXh2Z1hYa3BEU2FSd2NOdUpHTGYwQkIzaWcrYjNE?=
 =?utf-8?B?UmJxcFN2NTN6NVIwRitQZi9mMTMyV0pMQ2ZYU2diL0NlQWhYQU5QaHl5MkEz?=
 =?utf-8?B?UVNUaFBuNkcwOFNpS0FYcXp5NmYwcjd6Uy9EMWJSOXkrTk96QlBjZXBNZlNN?=
 =?utf-8?B?V3dNcTN1eWVCZ203b3lsaEVJZ1NnNXJxT29TQllnS3puMTF0UXNURmpjRXBQ?=
 =?utf-8?B?Uy9yRzE1SGdPVThNdWZuNytBaEtMUzlBdEk3TmZlaW5ZWEc0OW1wU01iUldW?=
 =?utf-8?B?VytXUEZWOHo5VWJSRzlUMWZoekY0a1RxWWl3aU14c25ocEJRUUVxM2NHZ1V1?=
 =?utf-8?B?QW5BNHZKOWhaL1ljLzlVSjBBNGVDYjZnSTRZazFVNHM4UWN0R2VwcXJLcWVW?=
 =?utf-8?B?cE1MTFJxVWprY00rRFNvOFBoRnltcmJxdlBjMkN3UVNzRHgzOEJXdWtWemhx?=
 =?utf-8?B?R1BLaGJybWI2VDdabDFhbnJPa3dNY1JoZ1pwK2JJaUFYcnU5V004OWdnaUhh?=
 =?utf-8?B?a1huNGpaZzJHSXF5S0Fxb3ZQbHpvQ1JFak4vWmNhbmJuWHpzbEl2WElGK2Nu?=
 =?utf-8?B?aVA1bFMxVmRwbDBSTVZXRytFWXdsLzJQS2oweXFGdHRkU3ZtckZSRExFRlR3?=
 =?utf-8?B?UWdtY24yei9ndDI0d1BuUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2crUW9RMnA1M0NvSFUza29JR3NkYnlMZVpDL0E3VVIrQ25rZ09LWVJyeVlF?=
 =?utf-8?B?RXJVb0x0WGVRV3ZQbzlWamVER1JQZEhTRW9qZzJ0WVc3Qjk5Z2NCWFcvNjEv?=
 =?utf-8?B?dmpNS0JSemUxd2ZiblJmVUV1MFNRdHcveDYwZFRGUjFOVHJvZUsvQmJkMFFU?=
 =?utf-8?B?cXRIbndJclhIMlBsM3liL25jMUlZdUhPSTVKTzdqY3B2OHhpK1JzQS91M2JR?=
 =?utf-8?B?eGpCdi9ianZDdnpqejMrSXFXMlJwblZmcm16dTRFNEFNd1YwRmYyTTRqdyto?=
 =?utf-8?B?MUNrc1RsUHhuWEhSb3h5cGF2VTFPR1AyUFNpSXptTEZ6YWU1SEJZU3Q1T0tl?=
 =?utf-8?B?eVVNMTRrbWxhUVUyNXcrYi8weUhKYUQ2eHNCdkdYRjUrVVpCc01oUGdyVWFx?=
 =?utf-8?B?S2JNaHZ6M0hoODBkTG1DaWdlR2J2QXNQbk1MRE1WcFRXd2Y4MWRGVGUraGVT?=
 =?utf-8?B?R0FsSUkxNW9SMUF3OUhneHdTck9lNWNMTVpKajBYbXJrcTBTNXQ5Yk9ZWkNL?=
 =?utf-8?B?NHJtN3k5dU4zK2RVNkZtRW44WG1kblBSWlI4d2dxajdEbDFHMWF1aS9YNGUw?=
 =?utf-8?B?c3pBOUdwVmhDSlZmZzRPazY3RGdHL1RwL052WC82aTV3RWtvWHZ6RUdBWUlT?=
 =?utf-8?B?dFFJN0JXaXozWDMrMWVkNjQvNFRJQlRUQndqTElDbkNoeXY5bG5VMmhXZURr?=
 =?utf-8?B?azBuSWU1ZytDaFMyNUt3L0NNQnVlMFk0bFhucmdqRTM1K1JPRUw3TGg4NFIw?=
 =?utf-8?B?bCttdnRHblNlN2JSM0RNOWlGUm9icFByazlrK2liSys0MFNnZURzZWFLemJ3?=
 =?utf-8?B?dlZtTjhPVG56cGRzTG9vTjdwSUx6Y1JyUk1ORS9VZmFBS3lockFlcmhrb1Qw?=
 =?utf-8?B?MDJpRzlPQTRZM1RFaFhubmx4VXZtZTJVU29tOGg5WVRDSmpwWERpKzNXc2l1?=
 =?utf-8?B?QjZCeTc1dTIrNHZ5ZGVmbXZldUZvb0dPMHpFVTA2anJmNm91N2JxaXM2b0VF?=
 =?utf-8?B?bGZqa0ErU2VBd2RWQ1o4WFlIbFJBcytjUmpwWXpxMVNSNUVxVnJZaitmSXRO?=
 =?utf-8?B?UnlYMkNvQTg0RURQK1BkNXc4em9FdC9yaVQ1RzQrdyt3UlVJVUp4K21FNC9S?=
 =?utf-8?B?alR2bENXanBwVHZDVDNaZEpwbXFxeXpGQWRYb01SOE9mWTBmQm1wMENZOUg2?=
 =?utf-8?B?b3JOd3FYWjBiVHRtL0NrUUxtWXF4NHFBVXRQUzNNWEhVaEk5SkNFaWZLWTgy?=
 =?utf-8?B?eGx1ZXlSUDBDWnVNa1kwbGFYeGlzc1ZMNFFRM0xOdEV6c3pDa0ZUbWhYMHhu?=
 =?utf-8?B?bHlUWE02Z3FTOEVYQUFkLzhDaDJkMWFKdFJ1VE1KRVdmbTdJKzZnK2RVYk9Y?=
 =?utf-8?B?ZmU3S2RzOEZtVmtHWHBMZlhqeHFwNWY1RlVlNXNVakxZT1dSUHkyRTcyLzlK?=
 =?utf-8?B?WlZCZUhUQ09ITzNmdVU1VXRoNCsyL1dwdmh5Z1BZN2xpb0pNSjBkK0pXbFJI?=
 =?utf-8?B?dW9IZ2hVUzRpQ0dydlpnbHVyaDl5dGg2bXU0MFF1aXVwcEhNWU9OdWw2ZlRu?=
 =?utf-8?B?OTh0R1ByZk9CekZuTlpPdkZsa1JsL0EzLzlRK2NHamlBaC9JSXVIUDdEbW9G?=
 =?utf-8?B?c2piM3lDQU1wWkVhYzFnN0xGWTEwUERhd2t5ZGFyV3BuTUNjSlk3UDlZL1ZE?=
 =?utf-8?B?c1Y1REJYZ0F6b2U1MkgzeUd3dlNxWXVTdXhudXAwZWdjZ2RvZmIvWEUrMXZP?=
 =?utf-8?B?NUNpdHdXM3lXZ090azlLdEZCVWlNQ1dnMUlJU2krSXorcExka2p3U0JKeFVU?=
 =?utf-8?B?WVl6QTZZeHZoKzNnWHVZZ1lVNnZGeWRBcnRIZXRRUlM0SkFkbjVSWVBFZjV2?=
 =?utf-8?B?WTh1Y2svVGU0dkhZMUZoZTJQSURuNXQ2cmNpeWdTaDc3bVQxYUdxb1EyYmVr?=
 =?utf-8?B?WkdTSEQrempGMml5K2NJZWVrRmhQRUVpUUVlNVJyTUNwekhLTjZodmJ3OVp6?=
 =?utf-8?B?MCtMMGU2RnM0cm12QUNZYk1tQnFKa0JoRkMxelg5c29wS25oR1VlalQwNVdJ?=
 =?utf-8?B?RG04SUYvR0ZzVDdmOVZqOW5qR0lNd1BORDR6cFlkbVFCVDZKZTgzUUR1K3Zp?=
 =?utf-8?Q?k0dCAcRmQYdsMcdiOIyYw5slu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a8c0da-40ef-4288-60bb-08dca1192cf1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:47:48.2066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sRnbs1chFdYA63B5r8bv1GaPYJP97VQzZEsdvj2fNeS7/zEKZ4zvEyUP4nt6z0jwwTYLaEPus1yGiGDLkjZ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870
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



On 7/10/24 10:49 AM, Marek Olšák wrote:
> This will enable display DCC for Wayland because Mesa already exposes
> modifiers with DCC. Has it been tested?

Yes, its working for most resolutions. Investigating issue with certain 
modes.
> 
> Marek

--

Thanks & Regards,
Aurabindo Pillai
