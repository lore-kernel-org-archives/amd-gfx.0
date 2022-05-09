Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9A0C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 10:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC26410E3B0;
	Mon,  9 May 2022 10:03:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8770610E3B0
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 10:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeXBIRQBXqqfUlm1POk710L8swc4TOjcNewYb7RBnv/JGOhCx/Y2ICL/dSSrBCuqQoD7kNj+6f2muIDUo+Rybre+WPNjRE/oYN5Ht47vGjOm9uNauszrc0V5XgeuWu3ybbFoDZ4/RQytICIRGyF7cRe8qz1q1VhYoLct2lPZveHmHA8OKOUQKKIltyjl8MMTX6heW3hFpR1eYn4jGvGckT9uebGq0jLqVRjAJY8XJPLvHdXCQ/7gBBXFiPH5uWxM5Oj3rcRHmJeiQfB0JYyfUPyeI1Y2gzvjdsAKcvIbkdCvqA8l/bA8TmlABWReuIgD8b5z4UMRYVGh1E+KG3IPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6KDI844M/T0WdpaOFD9JkehRpMjpRhW76mONWOHxMg=;
 b=QZbofb/n8y/Ri5UkDobr7w73lZ5m83R/jjzfg4ktRMSKtDo10f2rLlJKY6bhd1xyztTgmKdoh1WXJHlI9bLcmLL4oqq4iyN/sSuEg/mrY6PY1h7zR1gh9wsst2zjggQOasmaGWs7J1cag2zM7AhAqsCjuTFeTcIgY8Yjvz2T/taCzwua3cm9kaASQV3bH0XqaOWJppPSOu58rBGja/PNGU5TkJjO0p91aHxCS868LZbk90WE65d51ZQ81GnkkEYVKkX8pmgtAlDiHJb/Cn6Sj/lRJq4HuPHYxu+jtssqe1HaA8Ule9ech7krkYWMtpAPVBcWmHC/7kXmtD/ERJ2GZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6KDI844M/T0WdpaOFD9JkehRpMjpRhW76mONWOHxMg=;
 b=V4ncaHy9nqggGaiZUlkddT3TYzziJ05hay0o3P3yw1vQEJubHteBKaCwggqlMVz1/l64uAwuElrPCGCvb/TvMwIdNnRRSNxKQqQ2upFfjemToZacPa0sZDNreXOtHB57+cm91Mna/5PXoA7RREukEh4TKgHImxcH2tow2cucv/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN2PR12MB3408.namprd12.prod.outlook.com (2603:10b6:208:cd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 10:03:50 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f%5]) with mapi id 15.20.5227.021; Mon, 9 May 2022
 10:03:50 +0000
Message-ID: <45ae8180-ff4b-232f-e548-e6d0235763f3@amd.com>
Date: Mon, 9 May 2022 15:33:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [Question/Bug?] Why does the sysfs current_link_speed report a
 different value than pp_dpm_pcie
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 Maxime Schmitt <maxime.schmitt91@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, mike.zhou@amd.com
References: <CAPdf_3mLX49uBfyJwpMbcyumYQCqjqXB+S3gzWjdS9TCfbEVRw@mail.gmail.com>
 <DM6PR12MB2619BFF30502D3EE717A0422E4C69@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619BFF30502D3EE717A0422E4C69@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::12) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33d3d09a-b82d-4a5f-87d8-08da31a336ed
X-MS-TrafficTypeDiagnostic: MN2PR12MB3408:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB340873BBEDB79A61BA5D312F97C69@MN2PR12MB3408.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Go9PUEmRtrpmLrFiA0ERC0RVD+vsJ8yY/GwsgKSP138dotFnD273qQyKxTSaQtSMZwpzTudlVDYVQz6TYLq4Hbwqol678EoK/WRZzglSJnXFbxsogEUVud/CzfPspeIsZ2cbHuHuNZMq37VL3Gi+D8SfBvG62qrP0B3zjXJdob+LS9NtuyPmljN/OWRwl4pFyskuCSHv7m1LX6ay3wqGAOnO6WVT9Qr9ZcHtCo0v8X6uFTGGDnzIo6DvluKA1k83uwJfN0pPM3e02NzrA1t/LtKhDt43c8JwLQEJZMfCCciJMQkCcjVt6pJTtuyWBJc93+Z5yhnKPXLk5Zp1Qe3E6ntO6In28VAV49yoo6AvRbgFx1wkr2Apsog4/FlF1m/M5s1om6xX6AtpeKAirkxiLKEOH0fh1kmMGz1eLYDM3UT2NKmoSpgOWBUXUWhKTU28kUQbalJ3ro8Kk2Smo5ilhKhXJTSlvtG2VudHWwnB4QZ21XGvhzVn7RJ92eGb0CcEOfgiFpGf0qoq2lFUFeqOfVQ4J+RTTqxvYgIp42XrWdbO+oP/xhIX28bjQ3KFvdUWKXTtG73QRthbYVPqSuAMdJFgzRQAb/fJMC1EY7crFmHhOCdyoVn/yeqV5N26L83v9JxP2JFdWKzbkg01+d6DfsncuPvFIgf3thpsWbeSjju65o/AeCJ7ggbwRiSfn6XZqLQdeK+7T2Y4wDWUfLi7A6GZkRJsxt5mPUFVbpL/wxO4Cz3L7QNOu5gPfQE3V+2W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(36756003)(31686004)(5660300002)(8676002)(66556008)(66946007)(66476007)(110136005)(86362001)(8936002)(38100700002)(6486002)(31696002)(186003)(83380400001)(2616005)(6636002)(6506007)(53546011)(26005)(6666004)(316002)(6512007)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1VGSWJkNGtKbDg2U1BwcUZYNHZJdTN1VHBwYmNTdE9RVDdUdGowci9MT2F2?=
 =?utf-8?B?eVhMSS92NHgrcVo5WjJ2K2hBQjFHSjk1OEtyRFhrUk1Nb0VRS3RpVnEyNFg4?=
 =?utf-8?B?VG1nTU80OVZhU2xBNXVYODhHTk5NdEFZUzlvQXVIMmZMeHZaRUpsQXo4R1hX?=
 =?utf-8?B?OU5ndnlJd1h4N1diZlJkS3dpVGE3aWJ1amd0Y1BlSmdOUWFPTjYxd0pRMmly?=
 =?utf-8?B?SGQySHJwVUdFMnVNcHpOdWVMU1ZMN2g2TEcxZEpVSnN0UTVadUlwcFdKS2RW?=
 =?utf-8?B?OERFS2o4YlZyRlZjZ3p6N09NMzhDeHJYaCt5RTFReEZUOVh4UHF5WGZrZ09o?=
 =?utf-8?B?cjIxL1Yva2hjZEQyR3pHaEpmUXdXVXhTU3NaNDFwYTQxSkhFZkI4QVpBNUlW?=
 =?utf-8?B?TFBCVFR4Zm9DMGV4V0cyblBoNUNtQWJncXNNVnlOcVBod1k2d0dJQWpCM3M2?=
 =?utf-8?B?Q01SUXlOQUdQYlNNVC82WmFDT05JNHhMM3VQQVdhcC9DNUZFck1aRnpoLytD?=
 =?utf-8?B?WUVjd2cyUDdIRXNiZW1aOGcxYmVIWEVHZkU1SGdZSDRNNDNZTUEwQUpsTzNl?=
 =?utf-8?B?WUdHNXhmLzk2MHhkeGhDUnRNTmkwSUZoRnlsU2lMWXowSWFmN3VqbXR6U1Qw?=
 =?utf-8?B?M0ZUVVpRTEwyYkVaZFVhN2NQa2JXdmNRUzRTa2Q0MkZNZDJQVGhYVXgrWjlk?=
 =?utf-8?B?em9qa3lXSDhSVU05elc5Y0tMSlVJY2ZiVS9aU3V1YjBCNlI5cXgxa21pUndp?=
 =?utf-8?B?ZTJwT2dqdi9uL0NuMVFxMjQ0bnUzdFNnTGxrWWkxOHVka3FFQms1eXAxWWx3?=
 =?utf-8?B?WGIyTWt1MWNURGw2NElDWTRSV1gzZnk0Z3NlZGZzMi9TdzlRK2xFclFLTTdm?=
 =?utf-8?B?TkYrSDRMZU4zNzZmTTBLUWlpbGZtZjAvSmJIOU5WMTF5dzduZTAwanU0VFVX?=
 =?utf-8?B?dEJWak5JT2ROVHVwT2pJcHd2akx6YWJSZDMwRzh4UmdhVndqcmQxdzFaSDJU?=
 =?utf-8?B?UFpscExidmxTMlY0WFRGLzkwUHJxempkQjA4NTVWTkJLaVVOeCs5aXJWQ29z?=
 =?utf-8?B?S1N3VUN2WndZcDJ3QTE5UHppLzNSbStjTU9JcXVrTDJoZFIxV09VTnNGVUFC?=
 =?utf-8?B?dU5DS0RmUytRQ1VTL0V0QnBYSno2Y3YxV1dkOW50cG15R2pvY0JaTldPVzh1?=
 =?utf-8?B?OVJaaTUxMjgyUm9CemVQd0tlR0IwRlZpMmxhZzNMMnppdHJkVTdUUVMzSWNw?=
 =?utf-8?B?b0VBMkcraFZIR2VXbDJZVXZKb3FSV1hOUlI5Wi9IYUFBdTdwdUdLN091Ymkw?=
 =?utf-8?B?WEE1elpUTm1zbk1kTWFhb1JhaitobC80NXVaUi95bmM3S3krYWZYd2JKb0tN?=
 =?utf-8?B?MlVZUlg2SUdQTFp0N21Ed0xvQW9ORWhtaVpJOVl3Y2E3dVJJKzlOOUVjZU9C?=
 =?utf-8?B?MGlkREVXOXUxT21LUk8xT08rTGFmWHVGd0VYWkFLRkg5VG9IcllNWDZCOU5j?=
 =?utf-8?B?Ti9qZFdaN2x3WHRCZnhNWUJBanRRTkZkdmhlcDhHZm9Jbk1GMXg1VWpDRTBV?=
 =?utf-8?B?V3NMWEF5Mk9CdXBacWJDK2JFRjdPVWlqcWdkM3JrZ0dSQWxuNm04NG5rV2Ni?=
 =?utf-8?B?MFZBSXNmSHcxY0ZTR20yM2tVV2p6bE11cDRKelFBand0LzUxQjEzNHdsTmk1?=
 =?utf-8?B?azdYbWl1MVBxVlYvRUVsMFRpUnVSQ0lsYmkxQnN1WUVacHFta0V1T0Z2OHph?=
 =?utf-8?B?ZUMzY0FTcHlPOVM4U0wraDRrOVM1SERmU1hpQzlHVVJaZm5JMFdwYkFybm1R?=
 =?utf-8?B?L0tCSVBzaWM1SFlmcnl3Nzh1R1J4dnRkRWRHT3dPbnMrWkJPdEF6Z2xISjJz?=
 =?utf-8?B?Q0FKZldkeFlvMkJ3SHczaUNjd3FWT1I5bFJOUS9JdElmbEtjdW1oQ2F3VElI?=
 =?utf-8?B?aWxrczhPTXgzVDZzQjJFM0hIcUcvanFVTktFdFlQeEhla3Q3OXNlNjFQSklj?=
 =?utf-8?B?am13MkhEVVFIb0xHMWthZEhNWlAzcGtsNW5idDRBSEhLaXRGMGZwQk1lQTI3?=
 =?utf-8?B?TUczWmlPSXJ4aGRPUTZZc0E4YkNCNVpsbTRmMHl3dDVOcERBTEhXVHQxNkhy?=
 =?utf-8?B?bDlkY1NWR2E4cVpkdkJSR3dJMHF4NjdvZzdhRUJlcXgrT3dSTWFQWGxvQTJL?=
 =?utf-8?B?RkZPeGtkSThsVU5ISmIrOGNob1VqNjlXTEV5ZzZNMS8zeG0yS1F5aVNGdndI?=
 =?utf-8?B?VU1ES0I4dG44d240ekRpdFJwWWZaZHpVL2QxWng3VEFSQU92UER5ekJrTUM1?=
 =?utf-8?B?bUpTcEN5ZmdPNUJaT1hMV0FHakk5Z0RBL3dTcDZVbzJZUFJhcXpVQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d3d09a-b82d-4a5f-87d8-08da31a336ed
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 10:03:50.2156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnA1gB7xfCFqMfQWH+5qf1bsgqATYngki3GQJX+i1c2gPIkZ3TIgfUYrvfpSb/+X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3408
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

+Mike

On 5/9/2022 8:17 AM, Quan, Evan wrote:
> [AMD Official Use Only - General]
> 
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of 
> *Maxime Schmitt
> *Sent:* Wednesday, April 6, 2022 1:40 AM
> *To:* amd-gfx@lists.freedesktop.org
> *Subject:* [Question/Bug?] Why does the sysfs current_link_speed report 
> a different value than pp_dpm_pcie
> 
> Hello,
> 
> On my system the sysfs file "current_link_speed" is reporting "16.0 GT/s 
> PCIe".
> 
> The GPU has support for PCIe gen 4 (AMD Radeon RX 6800 XT).
> 
> However neither the CPU (AMD Ryzen 7 1700X) nor the motherboard have 
> support for PCIe gen 4.
> 
> The file "pp_dpm_pcie" returns the following:
> 
> 0: 2.5GT/s, x1 310Mhz
> 1: 8.0GT/s, x16 619Mhz *
> 
> Which is correct.
> 
> Is this the expected behavior?
> 
> */[Quan, Evan] “pp_dpm_pcie” is reporting the correct link speed. You 
> can trust that./*
> 
> */While “current_link_speed” seems reporting the link speed the card is 
> capable of. Not sure whether that fits design./*
> 
> */@Deucher, Alexander <mailto:Alexander.Deucher@amd.com> Any comments 
> for the output of sysfs file “current_link_speed”?/*
> 


In our architecture, GFX endpoint is not directly connected to 
CPU/Chipset PCIE. We have upstream/downstream bridges in between

CPU/Chipset <-> || US Port <-> DS Port <-> GFX EP||

The actual speed will be reflected in the US port connected to the 
CPU/chipset port or pp_dpm_pcie node as it shows the speed reported by 
power management firmware.

Thanks,
Lijo

> *//*
> 
> */BR/*
> 
> */Evan/*
> 
> I am asking because I recently added AMDGPU support to a monitoring tool 
> I maintain (nvtop) and I don't know where to get the information from.
> 
> Cheers,
> 
> Maxime
> 
