Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553B1EE20A6
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E980110E7CE;
	Fri,  6 Feb 2026 14:20:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C7/9UIOI";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D5D610E7CE
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 14:20:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8mOZhSA7NcJ2Fa66EBZuLR0QEiQ4Jqmd9E+e7+7gkXx0585bYPJHt7k0e8PMMEWqH1dywFZIhcCOTY7Z933dEVqjKerjtVeB3YwtpFA3Ds/lnLCqAsUvPK9E1Ud9pNAnEwqv9AT/4PMcsBXmls0CrqRt8swkdhUDvBP/5GLKtJhYPNaDjJ3agiTcN5kL3I/EpJ5hU5hSX7EoJ+jrY08Xjmv0FnypgJhXRVObDbwiaXzOpjC/auUrJlkkke3WJQZorRB2X3ivGc7qoTVKJRsgUB+qaeAT1bWknWG0EJsME/5GuqxXxyutUKbuPwjxSmZT0Vd7ZDnxP5eIhJc6RF3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUhMQu7tK+Gq7m8R+nxj8saVy07PGKDL47RZIB1Qx1U=;
 b=Jv7GYH176jCFfAe45lVLKrQmBjJms+HR1dWn9ENET57xWi6yYetzDp2V0mLZMEZcN0F1d/+LATEw9Vu7V34balK16esyWMdfuUwEZ6hiOgVuh4cNQOhYQlmf67JJrwYRD+K+9NeONdTZo8ZYIdYGNx5tz2m1wRPfNe8tBQFvNran6BYsEBSS0EJvRZgu8FnEqqI8Yw/612W9KJNGGolaToKFKTgXOWdu+JB46RDDJsftj1WgeppbvPVvlPEBnyvqtDMNUnT47C84wLvv3uHvfMGFUTeVHsrTyr4JPaISpd93Hh4SWC93YLIJAtiNazGyINUHKyiSflCHKusctkmT/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUhMQu7tK+Gq7m8R+nxj8saVy07PGKDL47RZIB1Qx1U=;
 b=C7/9UIOIZ5wyTxibeajE75j+LFLVeclLEfBnwHtxV6dhRWutY+i+OOOX50pCPHrnu/tPvvRmwZnDP4CivYLQahKWWuEP8/o7xNgrPufU6IxKZp7lVqdiFHteQgr5orSV5R8WidWwDn4YbtZ9HbAHrXW0LB7Ygl7orUzI4pDiCXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA3PR12MB8439.namprd12.prod.outlook.com (2603:10b6:806:2f7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 14:20:07 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 14:20:07 +0000
Message-ID: <c50857c6-a7bb-4543-9d8f-36d6c1623f3c@amd.com>
Date: Fri, 6 Feb 2026 19:50:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/11] drm/amdgpu: Add support for update_table for
 SMU15
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
 <20260206140049.105294-3-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260206140049.105294-3-Pratik.Vishwakarma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA3PR12MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: cef39b8e-8982-4a3a-6c21-08de658ad41c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REFGT0ZzMUY1RnArUTJUYnJvTE5PUUxBdXFFY2t2bHJXc05icEErTVdtKzFG?=
 =?utf-8?B?KzFieVdMN1JaWVVtWnRJTXVLYlNSNzMzS29pZXNDVllsYjIxL3BCYWlhWU1l?=
 =?utf-8?B?WFZqdi8yRUx6TzJsMmcvU1d6czB3bXBRVzNvQUZPY2dUbGo3aUFkcDJTNjVL?=
 =?utf-8?B?UDJzUjZEZE5jbmJXTi9FNnI4Rk53a1lSOUVwOFMxY1QwcElmemVKZ2ZyN3p0?=
 =?utf-8?B?NzBQTlB2Zi9PU3lvTWlSQk1YMEZNY2NjQ1l0dVYyT2VYK1lWUzBVV000NGRp?=
 =?utf-8?B?YWVtUEoxOTkzNVU2WC8xZGRTRlB4aTFsMUVmaHFRVmJGZGpKTUlYdmV2ZlJ2?=
 =?utf-8?B?a2JUNUdsWll5bnlHdXRxNG9PaC9peWE5eFl1aDdrMk43clZyYU1RL1piWXlx?=
 =?utf-8?B?TVc5RnV1UDBXUUdLTHB0cFkwQXo4OGNGVmkrWTRtM3ZmeTIyRERROWFPZytw?=
 =?utf-8?B?RTNZRS9SVlN5aXRXcDlDVWRGakNGU2JoN2luVW9aTHc3RUJpNXQrSUFHRVpK?=
 =?utf-8?B?VTRYZTVYYzEvMVArZmVEYm51UnVoM0syckgycVVjUUhaTVRxNzhCUmhjK1hm?=
 =?utf-8?B?Q1lZRnpiamt3R2JjamFHTzZ1a0dQSmNsOUZjdERDMDA2U0taTTkvWVdsVXFM?=
 =?utf-8?B?UXV3b2RvWE5LMlVud0JEWnlPRURRa295ZjFGMkRMUHE4eG0yUTFwNEpVSDdF?=
 =?utf-8?B?WEttbndUYS84eFNoQjJ6L2dXZk5WSVpkSUF2MHVqS1pSb2J5VExac3p3cXFT?=
 =?utf-8?B?dytXanVrUEFFRm0zbmVIMDYrcGZjaUZkc1VZMXA5VktOSHRvUUJhMU1rVHFj?=
 =?utf-8?B?VFJLVFpoNVBITklIUUxKbzJDV3pVVThmOEZRT2VTU0JyMExrRWdTdkdyWXJ2?=
 =?utf-8?B?V2JRbisvQldxejNndURuOVR2SmdZVFNIZUJLTDFsR1lqdHpMcHBjUEROTUVS?=
 =?utf-8?B?TUlNaWRWN2trRVdEeXdLU0J6dkhDYUdBUkpsNkI2SVpWUHhzR3RlSFRSc05s?=
 =?utf-8?B?UndFOFRHRHQwemhnZnoxQWJuSmxXamRobTVTeWZHMjJoNEZEa0h6bEFRamht?=
 =?utf-8?B?QkoyakhHSVNvMEloZ1QrdXBRTXFzUGpVM0JtQlJGaU9RcGxHU1dOTStQMmdG?=
 =?utf-8?B?ckh6Z2VkNFREMkhiNU1JcEV5NFJkRlM4WVNiMmc3U3QyV1BWU1hBaTRtMVRV?=
 =?utf-8?B?Z1ZTeTFmOW1jSXB2NFJza3pjSUtZa1NNako2VDM1bVZsQ1M1L1hvQXRENnBz?=
 =?utf-8?B?bkp0T3kvMlFvbXFHY1NjeWQ0REhyRGJQT3JKZ2p2OTd4aU15OUJpVmI5UlI0?=
 =?utf-8?B?a3JzM080SG5haXZZcEF5TE1raWZXQXg3aWc4dmRnWDIvcEFmZ3M4bDZqUTJL?=
 =?utf-8?B?YmNwamc2N2VwNGxxd0hmRWFDVkRUQlpiS2lEZW53ZmpOR3huOWRweElab0dQ?=
 =?utf-8?B?VFY0TE1OMndaZE8wcUliUEdTNWU2TnJmVmwxSzAvQUEycGI4dnN5TCtrbURK?=
 =?utf-8?B?eElucW9Od0l3djJtaGFabFp2UUt6SVpDUHJrWGs0QURheFNBdmFRTjJpU2Vr?=
 =?utf-8?B?YUp1NWlUdWlpcmdGSUVZQmFBZHNuZDRvaTJoTlhtbDg3UzJsOEE2NytnM1VM?=
 =?utf-8?B?ZUdIZUdsYmtGc3ZDNE9ZMUd2eHNsQVVaOXgzWTA2bDhDYUowaFVFdTlFbzdE?=
 =?utf-8?B?UmxKbjN5azV3WUh3VWdaVExEdUdRd0VPQ05XL285aTNnU29xa2xZM1pjMWI5?=
 =?utf-8?B?dklTSzdMWEVKQnRDVWlQV0dYUEZMM3h2RWgwS3hzSTBRTnkyRWhXSjI0MDNq?=
 =?utf-8?B?K2l2bzJnOWtUclB5S251eEgwbEZ3N2MyQ2s5aytLTXVNYkRrYWJra2FuSklm?=
 =?utf-8?B?ZmZ1cHNBWlVkUVAyT1VYb2xxeDIrWk5Kcy9oTG13QkNtUGtIRUtEMFEzdW1u?=
 =?utf-8?B?Q29jNjh1SStSWGNzOUNib0tGQnc1K2VyeFdwaVlyNEFhWGZPTzZidi9xTUEv?=
 =?utf-8?B?M3RXR293N3RDSENUMWpBSklRVzNFemE4QWl6TStKY0QvVCs1NkVCdDVaRzRj?=
 =?utf-8?B?NzdOc2xpSlBNdXA0QnNha2pFdTJMNGtpYS9wZTd2RVJOM3ZtTVNtMUplL1JN?=
 =?utf-8?Q?su7qA6fu/DHI+evV/WDRAMFO3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2pPaGVvck5iL1ZWZVE2dm9PQUdMbjFLazBMY29KcU54a1hibEdzVUxlaHpx?=
 =?utf-8?B?WlI1dXFwcXlZUmgxZnV1bDVnM2VGNFV4UGdNbDVWenZrNDkwbGRiOXBxOVJW?=
 =?utf-8?B?a0F6WTNBRGhlSmFHSlBaaCtzdGl4ZzdNaTE3VnQ0WmRTRmgvYUtGTTMxVy9E?=
 =?utf-8?B?Sy9jTW1PSTZPaXFSdi96T1pHYmNmeWVkaThuc1BrZWtwSnhJUDYzQnpWK0Vo?=
 =?utf-8?B?RlR2TFVaeE9EakM4NmlxeXdWRDZnK1VkejlWZXh2RXF2d01TVHB2WU83SDR6?=
 =?utf-8?B?aGo5bzk1MUlFMGZMbitiS29JbmJZbS8zbTh4cS80UWJFeTJFajFJSUpyeXJG?=
 =?utf-8?B?anRwL1dOL2tJclBoZlR6L0lxQjAxTERlRnZseDlHRk1yVzZDQ2tlU1Jpclcy?=
 =?utf-8?B?bmxMNmRZcG12NHZZVis2L2ozMm9NR09zd2xzc1BZdnFHMVlvdDA4QzRXditN?=
 =?utf-8?B?czhLYnV1STNubWU2OVVFNU12dUp2WDgzeWgrUGdOYzBRTDZNczdMR0x6U0Fk?=
 =?utf-8?B?cjZ1QkcyV1BsUFZXVHo4cUczMG91V0EwcHpLWUMvUURsODQyOC9iZ1BMUmVE?=
 =?utf-8?B?a0NjVWovblBRNzNIOGNLUUhJb2F4U2gyZEJYMWJmSG1VaVJZR0wwbFpKVTFQ?=
 =?utf-8?B?Y2t5MnVTZkFUTGlTS1BvY2FJVGE4c2J5eVZQdG9iellzbkFCRERibTlBTmlu?=
 =?utf-8?B?Mko5VVdVaW1kZko0UVJJTEk5bGpTakNhcmZMSUpsR1FDakRsTk5HNHRiV3FE?=
 =?utf-8?B?clh0UWNRL2dndGtuU1FnYmx2VHlwNmFDYVVpZTE0T1FrRHF1WXFkNk1LVnFB?=
 =?utf-8?B?cXZsM2tja3NqdU5DbGw3MVNWQUJ0S3FYcTVwTWc4S29QZkZaaXNSYWtUTm1M?=
 =?utf-8?B?d0lMYzZIMktka3B4eEtPcU1VSWxRSU9XRVJJaWRaeVBGVjVJRWd4R0x4c3J4?=
 =?utf-8?B?eWJqL1RadEg2NitMZFliL2tKRkVzRElaZlIvdEtJejJuRWRsaGxURWxiS3Bp?=
 =?utf-8?B?aXNzTGF1WHFHM2ZhY0Zha29jaEJxVjRxTjJqZCtsTUk2NFh4R0tsY09QWjAw?=
 =?utf-8?B?a2htdC9wL2xsZGprZWlVNStkSkZzTzdvc1F6T0M0dkhJMFpHV1Z2ZURjZXRq?=
 =?utf-8?B?NUJBODZmVFdJUVI1OHFoeDV0ZjFXVjJBQitKOUk1SWovM2NIcFQ1NC9OVWN5?=
 =?utf-8?B?M3FJSVhhc3dKSUpQZm44YUl3YVZhdzF2MTBwY3hQb0xBT0p2eEVhS3ZEN0hR?=
 =?utf-8?B?amdjY2twUXhoYzVGZTdrdG1WcDVmMkphaStoTTRTOVl0dm5reHlGUG53eXBR?=
 =?utf-8?B?OUpvZGhLNS92bjBCUU8vZjFPTUtlNFJscGJ4djJSS2tBRWRwT213eG9pOWNm?=
 =?utf-8?B?ZkF6d1IvSDNNS3lxQ29EM3g5dmpwSllBQVVYWWx6dlJxTzhOS3NPM3MzNDJq?=
 =?utf-8?B?dWhyb212aVZiSDh2T3NSdHRHOVpRL2x2Y21oUzdUUXRFVkJDR1FBaEw2R1RG?=
 =?utf-8?B?cDNYWnEzdnNtVFJxaTJtcUdrS1lFcnpYcWU4a2VoWFQ2MVB6WXpGVlZ0cmxy?=
 =?utf-8?B?ZE96MDVBOGFBMWkyNEZ3Y3dOaW9GM25GR2xJaDlqL3ltb3RGb3RiWG5ndHpa?=
 =?utf-8?B?dDVaMlBwc2NONzkxRFAyajFkcEFkRk4vOGFRei9SS0svVWU4RmZlVEIvaFk3?=
 =?utf-8?B?emZFeU91cmQyY2dJTU1ZQTF3ZXVSVmcyMTBReFcvSlNBc0ZQYlhqcVdaZS9x?=
 =?utf-8?B?V2duS1hWakN0M3IvSUhoWXlaNC92aExEdlVzNVVOTVJZVmsyL2c3bjlOai9N?=
 =?utf-8?B?emNaMWpDdFNkWVF0K2tGWC9MV3N3VTYxV1lyU3ZFTEhqTWZrbEhleXlNQnpL?=
 =?utf-8?B?MVJnK2Y5ckxpeVdtNzhIYlRVVkltOXlKMk5CQ3VVN0tiQWR5aTlvZlFDeFZG?=
 =?utf-8?B?Q1FDOWRNbHFLeXRwd2F0cDFLMkhEMFRhaCtRYVJxZEJpTEliaGNKRzgveHV0?=
 =?utf-8?B?VVIxY3g1MGpCeEhTeXRWcnJVYjJxV3ZnNlRZRmN1R1U0eDdMdWNseW9LU3ZY?=
 =?utf-8?B?cmh3b3p3L1I2dE5BY1pWUjlJMGdiUmtSRlRBT0xoNFhFT2xvbUI4cU9oOVB2?=
 =?utf-8?B?QS81S1p4cFB5TUpsSGMxT1BucUVOYjg1OEYvZ0FGejJwdmowTjJVbU1qSnJo?=
 =?utf-8?B?VjYzWTJud2czR2ZFM2hzN3Zvb1NqSkRKMEdqQU1oa3NwSnpTMmRWRzBDd0Ro?=
 =?utf-8?B?N3FPbzJHTGxLbytPWFg4MkdpT21scnJLM3FNbUNaWFNoOWtXYWlscXAwTjJC?=
 =?utf-8?B?eEs3RFNUWXVQaXBiQndvVHIwemY2N0dJUldsNUsyUVdKN3ZVSUtRdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef39b8e-8982-4a3a-6c21-08de658ad41c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:20:07.5864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zwkpJ7PYW4nwa45xo0ZNkOJGpPW5swIQfzYD3Oflpi1zuA0b6nYheFiV29QEg4T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8439
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



On 06-Feb-26 7:30 PM, Pratik Vishwakarma wrote:
> Add update_table for SMU 15_0_0
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |  5 ++
>   .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 60 +++++++++++++++++++
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 38 ++++++++++++
>   3 files changed, 103 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> index 14e8d8c7a80a..af87c31ca9a4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> @@ -241,5 +241,10 @@ int smu_v15_0_enable_thermal_alert(struct smu_context *smu);
>   
>   int smu_v15_0_disable_thermal_alert(struct smu_context *smu);
>   
> +int smu_v15_0_0_update_table(struct smu_context *smu,
> +			 enum smu_table_id table_index,
> +			 int argument, void *table_data,
> +			 bool drv2smu);
> +
>   #endif
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> index a2854d528bab..70dd5586c53e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> @@ -1726,6 +1726,66 @@ int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu)
>   	return ret;
>   }
>   
> +int smu_v15_0_0_update_table(struct smu_context *smu,
> +			 enum smu_table_id table_index,
> +			 int argument,
> +			 void *table_data,
> +			 bool drv2smu)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	struct amdgpu_device *adev = smu->adev;
> +	struct smu_table *table = &smu_table->driver_table;
> +	int table_id = smu_cmn_to_asic_specific_index(smu,
> +						      CMN2ASIC_MAPPING_TABLE,
> +						      table_index);
> +	uint64_t address;
> +	uint32_t table_size;
> +	int ret;
> +	struct smu_msg_ctl *ctl = &smu->msg_ctl;
> +
> +	if (!table_data || table_index >= SMU_TABLE_COUNT || table_id < 0)
> +		return -EINVAL;
> +
> +	table_size = smu_table->tables[table_index].size;
> +
> +	if (drv2smu) {
> +		memcpy(table->cpu_addr, table_data, table_size);
> +		/*
> +		 * Flush hdp cache: to guard the content seen by
> +		 * GPU is consitent with CPU.
> +		 */
> +		amdgpu_hdp_flush(adev, NULL);
> +	}
> +
> +	address = smu_table->tables[table_index].mc_address;
> +
> +	struct smu_msg_args args = {
> +		.msg = drv2smu ?
> +				SMU_MSG_TransferTableDram2Smu :
> +				SMU_MSG_TransferTableSmu2Dram,
> +		.num_args = 3,
> +		.num_out_args = 0,
> +		.flags = SMU_MSG_FLAG_ASYNC | SMU_MSG_FLAG_LOCK_HELD,
> +		.timeout = 0,
> +	};
> +
> +	args.args[0] = table_id;
> +	args.args[1] = (uint32_t)lower_32_bits(address);
> +	args.args[2] = (uint32_t)upper_32_bits(address);
> +
> +	ret = ctl->ops->send_msg(ctl, &args);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (!drv2smu) {
> +		amdgpu_hdp_invalidate(adev, NULL);
> +		memcpy(table_data, table->cpu_addr, table_size);
> +	}
> +
> +	return 0;
> +}
> +
>   int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> index d58b0bc2bf78..9a2e2c2f4e06 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> @@ -190,11 +190,38 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
>   	if (!smu_table->metrics_table)
>   		goto err0_out;
>   	smu_table->metrics_time = 0;
> +	if (tables[SMU_TABLE_SMU_METRICS].size) {
> +		ret = amdgpu_bo_create_kernel(smu->adev,
> +					      tables[SMU_TABLE_SMU_METRICS].size,
> +					      tables[SMU_TABLE_SMU_METRICS].align,
> +					      tables[SMU_TABLE_SMU_METRICS].domain,
> +					      &tables[SMU_TABLE_SMU_METRICS].bo,
> +					      &tables[SMU_TABLE_SMU_METRICS].mc_address,
> +					      &tables[SMU_TABLE_SMU_METRICS].cpu_addr);
> +		if (ret) {
> +			dev_err(smu->adev->dev, "VRAM allocation for Metrics table failed!\n");
> +			goto err0_out;
> +		}
> +	}
>   

Should have clarified better with my previous comment.

In general, what is done is to allocate big buffer that is sufficient to 
hold all other tables. That one is called driver table. That buffer is 
the one typically used for all table transfers.

https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c#L998

FW messaging/transfer is also one at a time. So you don't need these 
allocations, you could use driver table mc address in 
smu_v15_0_0_update_table.

Thanks,
Lijo


>   	smu_table->clocks_table = kzalloc(sizeof(DpmClocks_t), GFP_KERNEL);
>   	if (!smu_table->clocks_table)
>   		goto err1_out;
>   
> +	if (tables[SMU_TABLE_DPMCLOCKS].size) {
> +		ret = amdgpu_bo_create_kernel(smu->adev,
> +					      tables[SMU_TABLE_DPMCLOCKS].size,
> +					      tables[SMU_TABLE_DPMCLOCKS].align,
> +					      tables[SMU_TABLE_DPMCLOCKS].domain,
> +					      &tables[SMU_TABLE_DPMCLOCKS].bo,
> +					      &tables[SMU_TABLE_DPMCLOCKS].mc_address,
> +					      &tables[SMU_TABLE_DPMCLOCKS].cpu_addr);
> +		if (ret) {
> +			dev_err(smu->adev->dev, "VRAM allocation for DPM table failed!\n");
> +			goto err1_out;
> +		}
> +	}
> +
>   	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
>   	if (!smu_table->watermarks_table)
>   		goto err2_out;
> @@ -220,6 +247,7 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
>   static int smu_v15_0_0_fini_smc_tables(struct smu_context *smu)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> +	struct smu_table *tables = smu_table->tables;
>   
>   	kfree(smu_table->clocks_table);
>   	smu_table->clocks_table = NULL;
> @@ -232,6 +260,16 @@ static int smu_v15_0_0_fini_smc_tables(struct smu_context *smu)
>   
>   	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
>   
> +	if (tables[SMU_TABLE_DPMCLOCKS].mc_address)
> +		amdgpu_bo_free_kernel(&tables[SMU_TABLE_DPMCLOCKS].bo,
> +					&tables[SMU_TABLE_DPMCLOCKS].mc_address,
> +					&tables[SMU_TABLE_DPMCLOCKS].cpu_addr);
> +	if (tables[SMU_TABLE_SMU_METRICS].mc_address)
> +		amdgpu_bo_free_kernel(&tables[SMU_TABLE_SMU_METRICS].bo,
> +					&tables[SMU_TABLE_SMU_METRICS].mc_address,
> +					&tables[SMU_TABLE_SMU_METRICS].cpu_addr);
> +
> +
>   	return 0;
>   }
>   

