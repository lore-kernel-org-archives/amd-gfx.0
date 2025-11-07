Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DB8CCF9E3
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 13:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC0EA10EAC7;
	Fri,  7 Nov 2025 13:45:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SftURurX";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012024.outbound.protection.outlook.com
 [40.107.200.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E73D910EAC7
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 13:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1NFUOaCya8BFk4Eu6p9U0/DixtZlPOocHbVWU3sz8S3hD850D80QX0ZRkM18JwOpNq+qdY25njXvHuCvvAOFnWHoCrJC3G3lgLOruUfQHLMq+3KGMsExC9gZ3GiUsHI0E59S8bKZUt+mRiUPLD3ChgolQRW+CpIjnpU1qJdBrdTQMCTTvob1fzg6GkHjvN/zzggUeuAUmqZXeOgUmaYXnTKnyR5IHgHml2+0ZsaF+YiuGcUQelcHpCHfljVqu2/KWWDLCVSxTgZ2BQyO2i/eQvXL4g9YtmT7R8VrADmizJquFOkWrNuHa7pDB0CXcPmqanHIhgfIsmjm8YkzLUDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iV7RGqh8TfZFFfCHuPmyv46IKZVNmGPWFDQbCXNTJtE=;
 b=sDkLWR3TSnAeqFg8IkI9I2oL67JmX/YsBozcqmnads6oaNxCGGAtXB3Wp5FVhsc5mDhocGEO7GJGMOg4ozxoAR0lNfNBl9MtUzK7oyHI7wxpzAJTxImUbO7bPgaHKw6Gcsp8MMG71vB/uU3FPRI2Nnrk1aAxlPUPwTzp9BRSAj41qRvlpeAur9mMRHq0JBREIOkw2k+8pK5bYzmOTzyDmCL0MNG8Vi/M1mVxDtqJFfVJ1MIn18VX3h2YT3zS40hW2eYxqDd0EMIQJ8vqv2Aoa1iMmr2bngNc0ZKrsFOJptlyO7jCGjGAix3aF8kCE9+53BjQUwRXjwU/46ddkNztvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iV7RGqh8TfZFFfCHuPmyv46IKZVNmGPWFDQbCXNTJtE=;
 b=SftURurX45E4FJmp0royPZNxQivorb3DsX1uQ8gMx5hZpj3lzQFwFi+PW5Mv0zH8khF3zNI2z+/eLzVYCJed7PoN+yCHzFHOP7E7ChUJ4xtqpDur9R13bgtVV4pLPhc2gSPunn3yCO4LZB3QjbFGT8A9TfnYstqwMuz+Ow07ObA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPF6375781D1.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::995) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 13:45:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 13:45:29 +0000
Message-ID: <d0f83b5a-31af-4914-b649-24b0139f7ec0@amd.com>
Date: Fri, 7 Nov 2025 14:45:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] drm/amdgpu/vce: Save/restore and pin VCPU BO for
 all VCE (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>,
 "Dong, Ruijing" <Ruijing.Dong@amd.com>
References: <20251106184448.8099-1-timur.kristof@gmail.com>
 <20251106184448.8099-7-timur.kristof@gmail.com>
 <991f6d36-81e4-42d2-b301-0755fa00ffde@amd.com>
 <b7eb6efea5606c6d9b6d1bcdea6552b3602517bf.camel@gmail.com>
 <f0bbffa2-3b34-4f36-9fb2-44bcbcb5b8a3@amd.com>
 <a1f6e8e49d4f3d3a90afa8d3232b15626c34d991.camel@gmail.com>
 <180c651a-1711-4618-96d4-692d0c9c8996@amd.com>
 <9363414739e3053e04d971424a38293552c51348.camel@gmail.com>
 <425e9d98-73ea-4799-b4b0-7fde38927080@amd.com>
 <0e885d6bb1d1c6b179b122d6fa1598e148f2da5b.camel@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <0e885d6bb1d1c6b179b122d6fa1598e148f2da5b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0415.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPF6375781D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d34bbc9-0c57-4c54-5348-08de1e03ea24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTk4Rk1Uc0x1SS9BQktRUjFsWStCdjlrODI0dzgvMUJld3cyWW15YW5SK0Jn?=
 =?utf-8?B?bVNxSXRmQ0RzSWpNVWlKb29ndDlhTDYvbkxaSVYwbUUwRGQ1UVNkejhmSmFr?=
 =?utf-8?B?bTBsbTJ2eWFuVmU4ZjJLSVB4RnkwNHVDT0Z6SHhCNzdXeFdZd1pkWWtUa1Qy?=
 =?utf-8?B?Ukp0VFJ3WWs5Z1V2Sm5VZW1oNFdxM3BDM2gwdnlsYlZVUUtYUXE1M0Npd2xu?=
 =?utf-8?B?QVM2TVJBTS9MNnh4NUF5M0Nuc3JHTEJmKzErMU9DVmtiYkFxb1g1eWNveEly?=
 =?utf-8?B?eUVramRGcTVlNzFTb044VFhNZW5nY2hpWU5YaVhMSTV4SFlmV3BpVXhBekxD?=
 =?utf-8?B?ZEpkYVIrYWNFZDAraDRZY0QrV2tOdUJRQUVTZjFhZmpBRnpoWSt3WGRseUpl?=
 =?utf-8?B?Wkg1NUpUZzNKNnBxeWtNbk5qQUs0VFl1OG4vRHlHdnhWV0Y4L2dSVUVQV1FU?=
 =?utf-8?B?NjNjZThCRzg5cEFabXZSQ3RZcTBad1lYcjlnbldMbEYxOUZWQ2d1anZRbEVT?=
 =?utf-8?B?cFhNSHIraXlrdUhRNGhUeW1WOG1PN2xxU0N3VVBlc3JMbGZkeTZtNVFhOFVX?=
 =?utf-8?B?ZzcxUkpkbXJtUFZqTUF5YzZYSG9JcnMwb2hiUTB4WHRYUFhqOEFENzQ3VlF6?=
 =?utf-8?B?SWEwYyszVVBwSk5DMUhuenJiVmZPVEQvM2p1WStUcmQxQ1pIYlJQWUtRWnJI?=
 =?utf-8?B?Y2VJcGg2d3pNQ0QwS0Y2Y1BzOWZqL2lXY2MyNE9wQnBCYmRRSnlOZnJIQ3BJ?=
 =?utf-8?B?WnBHcTZPTnFlaEVFYlRqS1BHUVZSMWRkK3dDemczTlc2T0VMdE5WWFZmT2dX?=
 =?utf-8?B?dDhFaEI0NjU0NXQ4YTZKV05KeHN4YTlNdXpZamdweHZRU25GbnRPR29UZzYw?=
 =?utf-8?B?TStoRTFZb2hTbjFwNzRXcm9uKzZ6VkdwZUFMWlFFeXBKZ3ZIenpMM2VvV1lv?=
 =?utf-8?B?Y0JxMkN6eDBzY3JaR2NiTk5xK1pEeDBUVlRDU0xxOUVyaVhlbXJVaHQ4cWc2?=
 =?utf-8?B?STBjSlRSYWNudUFibmV6NFlBNzZRSFVwK1RKTmc5S3g1Ty9xejlFUlBoMDZL?=
 =?utf-8?B?bXl3aXBCc3RoRUFwQ0dBQTVLaVpTVzRYQUVsRGxGVUE0dHhKT3JvVStsUklj?=
 =?utf-8?B?dno0OTFYTVd0ckVIZy9laFlqcHZuQkZ1QW1neXlVOGc5K2dzekI1Y1V6RXRC?=
 =?utf-8?B?V0xaajJNNE1hRkZHWWgraVlXTit0dVhqUEdtWUJZa0lId3hRbExNeC8zOU9r?=
 =?utf-8?B?V09zTUpQb3dpUFVYRFQwQkFBUUhFeXg4bEdQdngzbnFIbTNLRDBjNlgyTnNl?=
 =?utf-8?B?VjJzT0N0dEx3RnpmYUc2VXJPVlN0Y2RMOGRSTUsxdFFSRWJnbjkwQ2hOT01X?=
 =?utf-8?B?M2hlaTVOcnEvSHowQkdQNndnRFJvY0F0djQ0NkgzSVZxcFBiWmlORUhlZmRL?=
 =?utf-8?B?ajl1R0VIa1Ivd0N0OWZwQXhhUm8rVzZOS2VFN3B2OU4xWmNQR3ZjVlRSeEhZ?=
 =?utf-8?B?ZzhyNk1maFhQamM1ODlkWks5NWVOdGRaVjFLc3BSKzUyRERLN3ZveElZZUZx?=
 =?utf-8?B?UXE4dnpER2VHaEJSUThrdHo5Q2hxcEVxZVhFcWI0ZkN5WUNQMzBQazRubUE3?=
 =?utf-8?B?R3N0NWhDQlFiZDVUUHAyOVB6TlZsR1JjUW1xZ2JhNTB3bWZZWU9MSDBMWDl4?=
 =?utf-8?B?cDlvSXJzeWlpYnpkWlNnVStJRHZzZWxvMFBnK29ITXRYbGMxY2VNaURxTzFF?=
 =?utf-8?B?dUpBRjhnWktwTSt0akRXSnZvTytEQ0ZxVGNldWVqNnpmOFRJay9reVBYTjZ4?=
 =?utf-8?B?ZjZJVDMrdHFEOEg0U0NIb3Z4dy9qS3ZMTld5YlNvenJiWGRWaDJTa25LVHp4?=
 =?utf-8?B?azFXYnJWTFpHa2UrQkZRV0JRRVJEcHlZai9icmRRak01SmFBZks0dmNUY0k3?=
 =?utf-8?Q?ZaEi/0Y/8ybPBks1rtDcMpAcA7U+97uC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk1STXRqVjhuZm9OOGNQOS83Z0ZvSTZlR0kwYnFmSzZJUU1TZllvRHRIZzhY?=
 =?utf-8?B?eXBNNlBxdTY4MDVYNDB0bERqOGZjRkFsd25VcWhpb2hPSVBFaFhlVEJsUnk0?=
 =?utf-8?B?ZkJLeWc4NTZuaTFuOFd1dU4vY2N6TXBDdU9XWWJ5dG81SFpOeC94VEJjZ2NX?=
 =?utf-8?B?U2YyODdlYmtPdTFPZ2phVEJMZ1hCUmt3VnpWNjBuU0R6UzhoMENiVG01UHdD?=
 =?utf-8?B?TjJRK2tuUVdyT0FEVlhka2NOMnk0TVVqOHQrb2ZNQmZadGxnN0w0c1FhUWxk?=
 =?utf-8?B?eW1xRlEwMVZITXVKb0NQTW5sNlJCQ3VmQnZBM2hULzVETlcxOVZjUTNmMzF6?=
 =?utf-8?B?SVMxbk5hLzhmcElmaVdQOW1nU05lOUl4U29vWk14TG5KNmdIdzBtY3pMRFBN?=
 =?utf-8?B?Rkk1WnFXZk9jSmpyRnpYcEhsMk04WkUzeTN6cytqZ3NNVitOSVpCZENDZUhP?=
 =?utf-8?B?cEJjMXZPeHF0RnlSM0pNZkV3a3VmWjVmR2hMWVM5T0phMFNsUkZGQWNvYVlF?=
 =?utf-8?B?eDFHY05yQTY3WlkxRXQwSHFIbkFEdmtyb1U3NmhVRldLMDBFM3RBdm5UdEJC?=
 =?utf-8?B?aXp3eFQyZUlocG96NEh1bHJCN3RMS00zeHh3Uml1aDloT0dBNnFMODVLcnpF?=
 =?utf-8?B?UmhaaE14eTgrVWlpcEFpWHJpQ0txQzNIRU5XZG1McXdIUW5xWXNsMWUxNCtW?=
 =?utf-8?B?aUVBYXlHVi9wMXgwMHZMSC9YdS8yMGUwbUdKdzhyRDdGeWt5N01VejF6aHQr?=
 =?utf-8?B?TnViejhpdktILzRlMEpkZUoyVGFGOEp4QmpYUThkWjgyNzZXVTU2RGtubGRq?=
 =?utf-8?B?dE9sbXdwYXpGS2pJQ2s2VzRQRmVlcXFLRVVEbTN6eXMvSnorL2ZpYjh4dCs2?=
 =?utf-8?B?cCsyQ1dWaXhxdExjVUt5NGhHU2tUa2Q2Z3loRjFMNXFKQUF6Q1E1WDMyb2M3?=
 =?utf-8?B?c09UbmJhMGJDYlhRSE9YRVBXZmozQmZwUTNGSk03dGRnSTRjcGEweXQvclI1?=
 =?utf-8?B?OWsxVVFzMlZqWDdyMkJaWnYvbWRwQ1Z4RjNtU3ZaMGIreEF1cmhUeHpUQ0xE?=
 =?utf-8?B?U1l0cDJLYXpCWFhsbDdEVGZoTm9hb2V3dmdxQkp6TnBRcG5Gc21DdllEVHF3?=
 =?utf-8?B?Mzc4SWJ1bWdTalBBaERET2xvYWM2b3FLWGNrOGlKbDlTTlIva1NLMXpzOSt4?=
 =?utf-8?B?QTdQSnBLczhPS1U4ZFprTGN1ZmhYU3RDMlZZbU80cWtIaG55Qlg5NlZoa0h2?=
 =?utf-8?B?WGR1WFhabVQ4MWJBZnFyZ1BRcm45bUs4UWRORWV3T1JqeGkvc1ZTZnF4VEE5?=
 =?utf-8?B?Tm5wRjgxL1YwTnlwMjJ5YWM0OEh5eXdBelNaNVlFUVdCYXYzNU51MHVIM0cr?=
 =?utf-8?B?c2REK2hxODNtSjlsWlJkSjFBYjBMTXhEeThxRnQ1cmRDb2NpM3o0UGU0dHpO?=
 =?utf-8?B?dWxkWHg2WEFtTzJ5K2F6QnJQNkxIZlU2U2FoOWVzdTZFM2ZDc0dDS00rTWhY?=
 =?utf-8?B?QnhhMzR1U2pZTU9CMzQ3cjZ5RkNtSFk3TUU3MU5RaFNsZlNMai9DVUR6WUVO?=
 =?utf-8?B?WFZBcXg0eVUyS1NXTDZubmpwdTJuSk81RENFSEVVTkhVdHRJbm5odUE2VXIy?=
 =?utf-8?B?Q3ZCSTBNQzU4MjRFMWdSOXo1SEZIMnRQNnRJL0VnYWpDbG1kd1ZrZzRKV2hx?=
 =?utf-8?B?d2RXK0o0RWpuQlJndlFGOGlNdldvd3ovaVVnY3M3Yjkwa0J6OEpNcUQyYlFW?=
 =?utf-8?B?bVgyL1dIakNLRFVhV2p4VDZTNVpJVW5CK0dQa1dXV2llV29zYWFENWpzbGN2?=
 =?utf-8?B?ZzVwM1lrY1lTL1FtQVpNUEtGbnBLZk9laTBwMTBoLzhXcGgyRkh4dUtVemxT?=
 =?utf-8?B?V2N3aTRKM3VXZWtQQy96bThxZk1kRnMrekhqd0hVMERZa3J1YjNuc2xmQzlw?=
 =?utf-8?B?aXQwdnJEUlEycEdnVVZTNmEvZklab291ZHpLcVF4UTlwTkt5MFp2MUI2c0lD?=
 =?utf-8?B?UnpUdG1VMDc2VE1jZkNpM2FKM2NvbDF0NnZjT2dUbGVaN3BQZ0Z6Q21OUjdX?=
 =?utf-8?B?WWhOdWEzbzRubnozZ3FuR1NPUkd3TTdlSEtnSGFiYktPR244WXU3VWVxNFNv?=
 =?utf-8?Q?w/XZgv2dCbQCujEl3Cx5u7hEM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d34bbc9-0c57-4c54-5348-08de1e03ea24
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 13:45:29.6903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDvXd6t3Oc2S5MzviU5Qi4qpNyHq2+fT/irYIHRnpJwS+st1RVZdJqvJiFPQChvI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6375781D1
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

On 11/7/25 14:39, Timur Kristóf wrote:
> On Fri, 2025-11-07 at 14:33 +0100, Christian König wrote:
>> On 11/7/25 14:31, Timur Kristóf wrote:
>>> On Fri, 2025-11-07 at 14:14 +0100, Christian König wrote:
>>>> On 11/7/25 11:47, Timur Kristóf wrote:
>>>>> On Fri, 2025-11-07 at 11:01 +0100, Christian König wrote:
>>>>>> On 11/7/25 10:53, Timur Kristóf wrote:
>>>>>>> On Fri, 2025-11-07 at 10:49 +0100, Christian König wrote:
>>>>>>>> On 11/6/25 19:44, Timur Kristóf wrote:
>>>>>>>>> VCE uses the VCPU BO to keep track of currently active
>>>>>>>>> encoding sessions. To make sure the VCE functions
>>>>>>>>> correctly
>>>>>>>>> after suspend/resume, save the VCPU BO to system RAM on
>>>>>>>>> suspend and restore it on resume.
>>>>>>>>>
>>>>>>>>> Additionally, make sure to keep the VCPU BO pinned.
>>>>>>>>> The VCPU BO needs to stay at the same location before
>>>>>>>>> and
>>>>>>>>> after
>>>>>>>>> sleep/resume because the FW code is not relocatable
>>>>>>>>> once
>>>>>>>>> it's
>>>>>>>>> started.
>>>>>>>>>
>>>>>>>>> Unfortunately this is not enough to make VCE suspend
>>>>>>>>> work
>>>>>>>>> when
>>>>>>>>> there are encoding sessions active, so don't allow that
>>>>>>>>> yet.
>>>>>>>>
>>>>>>>> The question if this is the right approach or not can
>>>>>>>> only
>>>>>>>> Leo
>>>>>>>> and
>>>>>>>> Ruijing answer.
>>>>>>>>
>>>>>>>> If we can get VCE1-3 to keep session working after
>>>>>>>> suspend/resume
>>>>>>>> we
>>>>>>>> should make this change otherwise we should rather make
>>>>>>>> all
>>>>>>>> old
>>>>>>>> sessions invalid after suspend/resume and only re-load
>>>>>>>> the
>>>>>>>> FW.
>>>>>>>>
>>>>>>>> Anyway I think you should make the removal of
>>>>>>>> "amdgpu_bo_kmap(adev-
>>>>>>>>> vce.vcpu_bo, &cpu_addr);" a separate patch, cause that
>>>>>>>>> seems to
>>>>>>>>> be a
>>>>>>>> good cleanup no matter what.
>>>>>>>>
>>>>>>>
>>>>>>> This change is necessary for the VCE1 code when it loads
>>>>>>> the
>>>>>>> firmware
>>>>>>> signature. Without this patch, we would need to call
>>>>>>> reserve(),
>>>>>>> kmap(),
>>>>>>> kunmap(), kunreserve() in vce_v1_0_load_fw_signature().
>>>>>>>
>>>>>>> Let me know which approach you prefer.
>>>>>>
>>>>>> In this case definately make removal of amdgpu_bo_kmap(adev-
>>>>>>> vce.vcpu_bo, &cpu_addr) a separate patch.
>>>>>
>>>>> Sorry, can you clarify what you mean?
>>>>> Should I just go back to the way things were on the first
>>>>> version
>>>>> of
>>>>> the series, and then clean it up later?
>>>>
>>>> Just add a patch (early in the series, probably as first patch)
>>>> to
>>>> remove amdgpu_bo_kmap(adev-> vce.vcpu_bo, &cpu_addr).
>>>
>>> Is it allowed to keep a BO mapped when it is unreserved?
>>
>> Yes, as long as it is also pinned.
>>
>> IIRC the VCE BO is allocated by amdgpu_bo_create_kernel() and that
>> both pins and maps the BO.
> 
> I am asking because amdgpu_vce_resume calls amdgpu_bo_unreserve on the
> BO, but then vce_v1_0_load_fw_signature needs to access it. So I wonder
> if the CPU address of the BO will be still correct when it's
> unreserved. Also wonder, do I have to call amdgpu_bo_reserve before
> accessing the BO? Or is it enough that it's mapped?

It should be enough when it is mapped.

That reserve/unreserve code is most likely just a leftover from radeon. On radeon we pinned/unpinned the BO on suspend/resume because we didn't know that the FW is not relocateable once started. Well that was a long long time ago :)

So that reserve/unreserve can be removed as well.

Regards,
Christian.

> 
>>
>> Regards,
>> Christian.
>>
>>>
>>>>
>>>> Then put the memset_io() into amdgpu_vce_resume() like you had in
>>>> the
>>>> first series of the patch so that VCE1 behaves the same as VCE2-
>>>> 3.
>>>
>>> Ok
>>>
>>>>
>>>> And when the series has landed we can clean everything up
>>>> depending
>>>> on what Leo/Ruijing has decided to do with suspend/resume on
>>>> VCE1-3.
>>>
>>> Sounds good.
>>>
>>>
>>>
>>>>
>>>>
>>>>>
>>>>>>
>>>>>> I want to get initial VCE1 working and landed independent of
>>>>>> what
>>>>>> Leo/Ruijing say to suspend/resume.
>>>>>
>>>>> Agreed.
>>>>>
>>>>>>
>>>>>> Can be that suspend/resume is then still broken, but that is
>>>>>> also
>>>>>> the
>>>>>> case for VCE2-3 then.
>>>>>
>>>>> Yes, some extra work is going to be needed on top of this patch
>>>>> to
>>>>> make
>>>>> suspend/resume work (if it's possible at all).
>>>>>
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>>>>>>>> ---
>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 44 ++++++++-
>>>>>>>>> ----
>>>>>>>>> ----
>>>>>>>>> ----
>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c   | 52 ++++-----
>>>>>>>>> ----
>>>>>>>>> ----
>>>>>>>>> ----
>>>>>>>>> ----
>>>>>>>>>  2 files changed, 24 insertions(+), 72 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>>>>>>> index 2297608c5191..4beec5b56c4f 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>>>>>>> @@ -206,6 +206,10 @@ int amdgpu_vce_sw_init(struct
>>>>>>>>> amdgpu_device
>>>>>>>>> *adev, unsigned long size)
>>>>>>>>>  	if (!adev->vce.fw)
>>>>>>>>>  		return -ENOENT;
>>>>>>>>>  
>>>>>>>>> +	adev->vce.saved_bo = kvmalloc(size,
>>>>>>>>> GFP_KERNEL);
>>>>>>>>> +	if (!adev->vce.saved_bo)
>>>>>>>>> +		return -ENOMEM;
>>>>>>>>> +
>>>>>>>>>  	r = amdgpu_bo_create_kernel(adev, size,
>>>>>>>>> PAGE_SIZE,
>>>>>>>>>  				   
>>>>>>>>> AMDGPU_GEM_DOMAIN_VRAM
>>>>>>>>>>
>>>>>>>>>  				   
>>>>>>>>> AMDGPU_GEM_DOMAIN_GTT,
>>>>>>>>> @@ -254,6 +258,9 @@ int amdgpu_vce_sw_fini(struct
>>>>>>>>> amdgpu_device
>>>>>>>>> *adev)
>>>>>>>>>  	amdgpu_bo_free_kernel(&adev->vce.vcpu_bo,
>>>>>>>>> &adev-
>>>>>>>>>> vce.gpu_addr,
>>>>>>>>>  		(void **)&adev->vce.cpu_addr);
>>>>>>>>>  
>>>>>>>>> +	kvfree(adev->vce.saved_bo);
>>>>>>>>> +	adev->vce.saved_bo = NULL;
>>>>>>>>> +
>>>>>>>>>  	return 0;
>>>>>>>>>  }
>>>>>>>>>  
>>>>>>>>> @@ -290,13 +297,19 @@ int amdgpu_vce_entity_init(struct
>>>>>>>>> amdgpu_device *adev, struct amdgpu_ring *ring)
>>>>>>>>>   */
>>>>>>>>>  int amdgpu_vce_suspend(struct amdgpu_device *adev)
>>>>>>>>>  {
>>>>>>>>> -	int i;
>>>>>>>>> +	int i, idx;
>>>>>>>>>  
>>>>>>>>>  	cancel_delayed_work_sync(&adev-
>>>>>>>>>> vce.idle_work);
>>>>>>>>>  
>>>>>>>>>  	if (adev->vce.vcpu_bo == NULL)
>>>>>>>>>  		return 0;
>>>>>>>>>  
>>>>>>>>> +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>>>>>>>> +		memcpy_fromio(adev->vce.saved_bo,
>>>>>>>>> adev-
>>>>>>>>>> vce.cpu_addr,
>>>>>>>>> +			      amdgpu_bo_size(adev-
>>>>>>>>>> vce.vcpu_bo));
>>>>>>>>> +		drm_dev_exit(idx);
>>>>>>>>> +	}
>>>>>>>>> +
>>>>>>>>>  	for (i = 0; i < AMDGPU_MAX_VCE_HANDLES; ++i)
>>>>>>>>>  		if (atomic_read(&adev-
>>>>>>>>>> vce.handles[i]))
>>>>>>>>>  			break;
>>>>>>>>> @@ -316,40 +329,17 @@ int amdgpu_vce_suspend(struct
>>>>>>>>> amdgpu_device
>>>>>>>>> *adev)
>>>>>>>>>   */
>>>>>>>>>  int amdgpu_vce_resume(struct amdgpu_device *adev)
>>>>>>>>>  {
>>>>>>>>> -	void *cpu_addr;
>>>>>>>>> -	const struct common_firmware_header *hdr;
>>>>>>>>> -	unsigned int offset;
>>>>>>>>> -	int r, idx;
>>>>>>>>> +	int idx;
>>>>>>>>>  
>>>>>>>>>  	if (adev->vce.vcpu_bo == NULL)
>>>>>>>>>  		return -EINVAL;
>>>>>>>>>  
>>>>>>>>> -	r = amdgpu_bo_reserve(adev->vce.vcpu_bo,
>>>>>>>>> false);
>>>>>>>>> -	if (r) {
>>>>>>>>> -		dev_err(adev->dev, "(%d) failed to
>>>>>>>>> reserve
>>>>>>>>> VCE
>>>>>>>>> bo\n", r);
>>>>>>>>> -		return r;
>>>>>>>>> -	}
>>>>>>>>> -
>>>>>>>>> -	r = amdgpu_bo_kmap(adev->vce.vcpu_bo,
>>>>>>>>> &cpu_addr);
>>>>>>>>> -	if (r) {
>>>>>>>>> -		amdgpu_bo_unreserve(adev-
>>>>>>>>>> vce.vcpu_bo);
>>>>>>>>> -		dev_err(adev->dev, "(%d) VCE map
>>>>>>>>> failed\n",
>>>>>>>>> r);
>>>>>>>>> -		return r;
>>>>>>>>> -	}
>>>>>>>>> -
>>>>>>>>> -	hdr = (const struct common_firmware_header
>>>>>>>>> *)adev-
>>>>>>>>>> vce.fw-
>>>>>>>>>> data;
>>>>>>>>> -	offset = le32_to_cpu(hdr-
>>>>>>>>>> ucode_array_offset_bytes);
>>>>>>>>> -
>>>>>>>>>  	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>>>>>>>> -		memcpy_toio(cpu_addr, adev->vce.fw-
>>>>>>>>>> data +
>>>>>>>>> offset,
>>>>>>>>> -			    adev->vce.fw->size -
>>>>>>>>> offset);
>>>>>>>>> +		memcpy_toio(adev->vce.cpu_addr, adev-
>>>>>>>>>> vce.saved_bo,
>>>>>>>>> +			    amdgpu_bo_size(adev-
>>>>>>>>>> vce.vcpu_bo));
>>>>>>>>>  		drm_dev_exit(idx);
>>>>>>>>>  	}
>>>>>>>>>  
>>>>>>>>> -	amdgpu_bo_kunmap(adev->vce.vcpu_bo);
>>>>>>>>> -
>>>>>>>>> -	amdgpu_bo_unreserve(adev->vce.vcpu_bo);
>>>>>>>>> -
>>>>>>>>>  	return 0;
>>>>>>>>>  }
>>>>>>>>>  
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>>>>>>> index 2d64002bed61..21b6656b2f41 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>>>>>>> @@ -448,14 +448,8 @@ static int vce_v4_0_sw_init(struct
>>>>>>>>> amdgpu_ip_block *ip_block)
>>>>>>>>>  		return r;
>>>>>>>>>  
>>>>>>>>>  	if (adev->firmware.load_type ==
>>>>>>>>> AMDGPU_FW_LOAD_PSP) {
>>>>>>>>> -		const struct common_firmware_header
>>>>>>>>> *hdr;
>>>>>>>>> -		unsigned size = amdgpu_bo_size(adev-
>>>>>>>>>> vce.vcpu_bo);
>>>>>>>>> -
>>>>>>>>> -		adev->vce.saved_bo = kvmalloc(size,
>>>>>>>>> GFP_KERNEL);
>>>>>>>>> -		if (!adev->vce.saved_bo)
>>>>>>>>> -			return -ENOMEM;
>>>>>>>>> -
>>>>>>>>> -		hdr = (const struct
>>>>>>>>> common_firmware_header
>>>>>>>>> *)adev-
>>>>>>>>>> vce.fw->data;
>>>>>>>>> +		const struct common_firmware_header
>>>>>>>>> *hdr =
>>>>>>>>> +			(const struct
>>>>>>>>> common_firmware_header
>>>>>>>>> *)adev->vce.fw->data;
>>>>>>>>>  		adev-
>>>>>>>>>> firmware.ucode[AMDGPU_UCODE_ID_VCE].ucode_id
>>>>>>>>> = AMDGPU_UCODE_ID_VCE;
>>>>>>>>>  		adev-
>>>>>>>>>> firmware.ucode[AMDGPU_UCODE_ID_VCE].fw =
>>>>>>>>> adev->vce.fw;
>>>>>>>>>  		adev->firmware.fw_size +=
>>>>>>>>> @@ -506,11 +500,6 @@ static int vce_v4_0_sw_fini(struct
>>>>>>>>> amdgpu_ip_block *ip_block)
>>>>>>>>>  	/* free MM table */
>>>>>>>>>  	amdgpu_virt_free_mm_table(adev);
>>>>>>>>>  
>>>>>>>>> -	if (adev->firmware.load_type ==
>>>>>>>>> AMDGPU_FW_LOAD_PSP) {
>>>>>>>>> -		kvfree(adev->vce.saved_bo);
>>>>>>>>> -		adev->vce.saved_bo = NULL;
>>>>>>>>> -	}
>>>>>>>>> -
>>>>>>>>>  	r = amdgpu_vce_suspend(adev);
>>>>>>>>>  	if (r)
>>>>>>>>>  		return r;
>>>>>>>>> @@ -561,20 +550,7 @@ static int vce_v4_0_hw_fini(struct
>>>>>>>>> amdgpu_ip_block *ip_block)
>>>>>>>>>  static int vce_v4_0_suspend(struct amdgpu_ip_block
>>>>>>>>> *ip_block)
>>>>>>>>>  {
>>>>>>>>>  	struct amdgpu_device *adev = ip_block->adev;
>>>>>>>>> -	int r, idx;
>>>>>>>>> -
>>>>>>>>> -	if (adev->vce.vcpu_bo == NULL)
>>>>>>>>> -		return 0;
>>>>>>>>> -
>>>>>>>>> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>>>>>>>> -		if (adev->firmware.load_type ==
>>>>>>>>> AMDGPU_FW_LOAD_PSP) {
>>>>>>>>> -			unsigned size =
>>>>>>>>> amdgpu_bo_size(adev-
>>>>>>>>>> vce.vcpu_bo);
>>>>>>>>> -			void *ptr = adev-
>>>>>>>>>> vce.cpu_addr;
>>>>>>>>> -
>>>>>>>>> -			memcpy_fromio(adev-
>>>>>>>>>> vce.saved_bo,
>>>>>>>>> ptr,
>>>>>>>>> size);
>>>>>>>>> -		}
>>>>>>>>> -		drm_dev_exit(idx);
>>>>>>>>> -	}
>>>>>>>>> +	int r;
>>>>>>>>>  
>>>>>>>>>  	/*
>>>>>>>>>  	 * Proper cleanups before halting the HW
>>>>>>>>> engine:
>>>>>>>>> @@ -609,25 +585,11 @@ static int
>>>>>>>>> vce_v4_0_suspend(struct
>>>>>>>>> amdgpu_ip_block *ip_block)
>>>>>>>>>  static int vce_v4_0_resume(struct amdgpu_ip_block
>>>>>>>>> *ip_block)
>>>>>>>>>  {
>>>>>>>>>  	struct amdgpu_device *adev = ip_block->adev;
>>>>>>>>> -	int r, idx;
>>>>>>>>> -
>>>>>>>>> -	if (adev->vce.vcpu_bo == NULL)
>>>>>>>>> -		return -EINVAL;
>>>>>>>>> -
>>>>>>>>> -	if (adev->firmware.load_type ==
>>>>>>>>> AMDGPU_FW_LOAD_PSP) {
>>>>>>>>> -
>>>>>>>>> -		if (drm_dev_enter(adev_to_drm(adev),
>>>>>>>>> &idx)) {
>>>>>>>>> -			unsigned size =
>>>>>>>>> amdgpu_bo_size(adev-
>>>>>>>>>> vce.vcpu_bo);
>>>>>>>>> -			void *ptr = adev-
>>>>>>>>>> vce.cpu_addr;
>>>>>>>>> +	int r;
>>>>>>>>>  
>>>>>>>>> -			memcpy_toio(ptr, adev-
>>>>>>>>>> vce.saved_bo,
>>>>>>>>> size);
>>>>>>>>> -			drm_dev_exit(idx);
>>>>>>>>> -		}
>>>>>>>>> -	} else {
>>>>>>>>> -		r = amdgpu_vce_resume(adev);
>>>>>>>>> -		if (r)
>>>>>>>>> -			return r;
>>>>>>>>> -	}
>>>>>>>>> +	r = amdgpu_vce_resume(adev);
>>>>>>>>> +	if (r)
>>>>>>>>> +		return r;
>>>>>>>>>  
>>>>>>>>>  	return vce_v4_0_hw_init(ip_block);
>>>>>>>>>  }

