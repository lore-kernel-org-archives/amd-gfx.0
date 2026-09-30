Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FF4CA5FC1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 07:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE7810F1FD;
	Wed, 30 Sep 2026 07:12:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jEFRarPD";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 981A510F1FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 07:12:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9ZPlvxwFAtQ42bmnn1Tf1fmuIGbW9oE+VRNos0fVXNWNvXk8+RTIlarC15k1u+bgePr35JWnwzofjneIKqpvpOQg+bx939f3WC0qZuXzzOWGDfhzoxEDdxeU0iTdZ26NY63hZt4uLomCtgBYk0P7xRI7bWvASyLE2KHUvt+j+IlV/SughH23vZVvSoWGjZx15vJgYbR/pgkt2MgkeCod8qZgW/s4obPvKhLKgS6AAkZz1nAIocOsPwWOTe+unKawvUH9sfC57aXLyrY6h0ZrRDnaD990uQ4VzXwkToMe0XER4m0IilWg4JFjSTtIOH2o8nupFToxYQa6WGbTla83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZsOBaxA7tAW31bRdRxku4wUA0V+ExO4dBTkjiuddvw=;
 b=mi4vX+OsDnNqHbb5zAmDDlWasV+DJ22YNdA6HZEjdDKHVHmMlXa+UbU7slCMgryAXcFSXlwj4/H7fwLUHqiNweAhlDRi6rhRBWYAH98r28uGE8dRBH3u7T8AmH0xaRJ5cxp/at3TscKMzyOYoaXtGvCsF+YDTt9hf1jO3ovvRhxIlPNmuQfWVIYn/G0NsFUpB3hFWZ9y4yMXO+FCqv/8p1XLwrVOLbWeoy5Rp7rjha7mgQZJR/Y8L2lVCy0AI/+YKnaILm3KoIUaSAaiut45H8ZLODncFXLSuYn6SjSaRhegfdEF8VbApE9XOXIceY+oHLP+cMnl348Xax2VIx27Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZsOBaxA7tAW31bRdRxku4wUA0V+ExO4dBTkjiuddvw=;
 b=jEFRarPDwMOz7c2KDquRDZbEuoL2lUGfG3oK3dIlXpoHZ6wq5uz8nWkwxFHsbPhbxb5ldNxh9e1yYRw4AMmI6TU3g4NExz2Fw796dW38W4vW8vuX86rk1NktKzt9+ISqdlyglPJ9fzCJtXPNazdcpukFT7Od4+0dPXwDdCPNJlU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB7457.namprd12.prod.outlook.com (2603:10b6:a03:48d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 07:12:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 07:12:20 +0000
Message-ID: <0b83688d-d517-457e-b9f1-c62baa5d9087@amd.com>
Date: Wed, 30 Sep 2026 09:12:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset on
 gfx12
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Wang, Kevin" <Kevin.Wang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Yuan, Perry" <Perry.Yuan@amd.com>
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
 <SA0PR12MB70915BCDD0BE98B2F8B54A0E978B2@SA0PR12MB7091.namprd12.prod.outlook.com>
 <CY5PR12MB63692E6BAC9D9589354ED1B5C18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CY5PR12MB63692E6BAC9D9589354ED1B5C18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c95ae3-32ba-4921-64b7-08df1ec22ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|11063799006|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: UNAA+z3dA/xsbX4O8BhPysyhW0t/yz8Ich+p371mC09ifx0hUTUSS9/qDXskP8fY/OaNpldzgi13/Q2psbhPu8wDeVotOEoTFGEBNnzhWmt1xLnynYiWgG9/pUvx0hc6s8SRP9ezlAUcqZhvSlPJxO/yCliZyOMep++2nL6G+uQJRFcfT2Da6/zn2T5ZuAA0a7z0qj1FQq2oh7cddOnMMUhiU6aW8WhCmGCDLHJ1M9s0j46vqiujAk9l92SaD9Ze0nJ4mCWJpy2WQSfqTIajYzc6UqTmMAyaGDFOYEhvbe0BSJQPE281LRBv3z2YxfUL3pglPuQKJr861m9D9VCqVa7EcgxHgsHu4b2eFordN6xD0mz27Q0Ib+9lTCB46273BcWoG19nQClGzP0sNlTVkEPP5eU0rgycS7j//jF2OPGo5jDszb1gWwJimRsdsQx+RwCaUP9PfaVwlmgyf+9YoRzTOad5+1BLRt1/ESkZX+5r93U9V0GebWmwvoWuR/dkwPIuyIRab3iqNZrQUdLHQLCIMjbx1wK92tNgQ+VT2NTiEopDpUP146N+mYGrd/M67Dw6Kg1kQrsaPg8NRawhKjxhXDsqPi/Nvwf+lzdulOvUlmsmyIiAzXZm13TcYqtIRnnRb1pns4QFjy2ueUQjI9vzFi78DXfkfHNzgSdAbS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDM5RUxabGlXZzJTcXN2Wk04QkE1Vzd6dEVoVkladWNTWndwOVRjYlc1QUo3?=
 =?utf-8?B?a2R4TUZxUk9oZTRJNVhjR2dTQXBLbjFkWGpoOUhObzBBKy83Z05VMklVbGha?=
 =?utf-8?B?di9XTlc2MjIybWt6aW5ZU1RqVkczTTZvbFdaWlNuZW45d0RUYmNJZXpOUDQ5?=
 =?utf-8?B?VGUvQkhlMzZNcTdwcE5PRDVHSGpIemtGaFRHNDdDbmkvV2gvUno4aC9oQWZy?=
 =?utf-8?B?VWYxWW5KSDdIMENxR3Z4MG1tcUREK2hGZWQ5NG5ydEtZTEdlb1g4M3hpRzFz?=
 =?utf-8?B?WFgwV2s5UERGU3g2S24yZnl3ZkdNekdPUGRNUTlQQVU3TGc3NFN4NmdUaXE5?=
 =?utf-8?B?SC8xRnhqZmlFUXIzN2tkc2dRQTlzQ3pXWUlyNzVqaTZkeE9MeEhmdUZhQ3dB?=
 =?utf-8?B?NVVmWWZONWM4bDdJT1REOWU2OEZtM0lQQWlVMUliMlp1UlRlc1BsRVVWUDVE?=
 =?utf-8?B?aUZGdTQ3a3VGb0w4cjJyVkFOM0p3YXBTaHBYT1NmcXAzTlgreGNXVEx5TmFW?=
 =?utf-8?B?SEZxbmNWOTRDL1N3b2NObkhaRVhMNnl6d3pRSDd1a0EzSkpEZ1NGekZhSzFm?=
 =?utf-8?B?dFA3R0J1engwZng3MFJCQ3A4Z1J6bEM5RzlqbzRQNUJ3dHhKRmV3VWtjL2Ey?=
 =?utf-8?B?T2F6YlkwcGF6UUpvVExBYVlueCtkYzluMWtPNXl0d2dEcXNYUkMrNVk4OWJP?=
 =?utf-8?B?K3FCeWVvbXdrUmViZ3lDeWs5Q0RWZVVIZEVvWSs3WU9jTytZQ05YdFJqT0JG?=
 =?utf-8?B?OTZ6ZHBoOWF4bXhYcFZNa0IrNG9RV1NXUEpxSjFFU3RwQ25hTFoxaVRHY3N6?=
 =?utf-8?B?OEZxL1pNMnA4NG9GZ2JiaW9ycnFVYXk1eS9zVldEWjZma1NNQ0J0THRvVHVz?=
 =?utf-8?B?WFcrNEtodFJibkxrZW5Ea3lSTklhYXZlZS9SY1RNbDdCdmFoYXdCejhaNzVJ?=
 =?utf-8?B?bVdZVkNNbnM1cFFJdmk3WXZTVzdxVDFIT1lrNHNSekVpOU9tSkt1NGNRMnVQ?=
 =?utf-8?B?cGhpMHJJK25maDZLMFNlNDJ2eXZIL2tPaGlSaWladStmSGZJSnc4eHhzL0hJ?=
 =?utf-8?B?Mm5EYWp1QXhIdG96ZS84UHNwY3VuU1RZWHNESGpSNTBUK1lTYXhRK01YYnJF?=
 =?utf-8?B?U29BcmpXYS9hMGVSa004Rjh3SzJRS05LcnRYUGljRlU5WXV6SlQyRGs4Y2JL?=
 =?utf-8?B?eldObHZIbmo0OHB5THZWelZlMDhTRUJLelZiREcvL3JSeFZ5NWk3c25INkJj?=
 =?utf-8?B?bWF4K01TdmluSnVUaFFiQ1VoTnltWkZFeEZuUG9BdmZuM0M4WnZrUGhSNWlD?=
 =?utf-8?B?WVlEekFEK05TMzA0ZUNYd0hLTE9ObyszclZOMVNHRW9rSnIyZUp0dk10V0Zq?=
 =?utf-8?B?bzZiMENKSlF1VFYzTzdqekNwWHBYMW1tQ0IwZ2xoSHpBeXY3dlRidHVMMDQ4?=
 =?utf-8?B?TytoYkhaL05WQ1dZdFF0Z0hiSi9ZeHVrTXNZeVRhWUJkUlhsOHcwNDdaeHhS?=
 =?utf-8?B?ays5WnhQUldUallGOEJoaG15OTFoWHU1NEFtZUo1aWFxV09zOUF5MzBucFQ4?=
 =?utf-8?B?TTVnQ1FhaVNGSW0rQVJQajlaWFV6dGR1SUo0dnFNNkI4OE9ySml6NGdDMTZC?=
 =?utf-8?B?L3daS2FrNVZ2eUpPVzVIMWsxQjhMMldzZFVkT0l2Zm5DRE5xMkpmczBJL2l6?=
 =?utf-8?B?SlVXR0tuZ2YwTjhWc0xRSktoZDdpOTRSSldneUEya2l2dlAzYjczQ2xscmVK?=
 =?utf-8?B?R3hCM2g4NzRBdVZqQ3puV3RRTysxTlgxK05xNStuUXlTOWNsVHc1T1BocHdD?=
 =?utf-8?B?d0dYSDkzMGpLbXFxa3c1ZXZ6TVFZVG1OenU0TFM4enRCeEZzeWpRdTZDWWtV?=
 =?utf-8?B?NkRFS0FPMlJBWWhYb3JoQ3Fmc2VwQnlPbkRqdEVhaGRJTTNwKzY1T3RETmhq?=
 =?utf-8?B?NlpwaEM4V2NCeFFTT29uMzd1S2R3S3FKZjQ2RUJXUUNtVWhCMTh1ajI5elFs?=
 =?utf-8?B?RFpCd2M2RUF3MkFMdlN1ODF5byt5Mjc1TkdwYjJJOHJVTEhKVmFpd1c3WWRK?=
 =?utf-8?B?VU1hUnFNbkF5L0xNcW85MithMU5QUDdGR01pQlBTUnpRRmtrbW8yU04xdTVJ?=
 =?utf-8?B?Y3ZhMUFyR0pMN0JUY0ZRcExXS3c4Zm1LQ3hHOEppZkRXVU5pWGVDOHcvdU1i?=
 =?utf-8?B?ZkpSUDR6ejdwelRkcDE1amZuTzRkZXVDS0gvTWg5NHdVdVdpOUxkS3RHRnhS?=
 =?utf-8?B?S1hGalIxMVF4ZytjMXlhekljcUZId3lhRnc4QnFMcitzd2xRdGVqekRaZHp6?=
 =?utf-8?Q?DeTl3sCvL7OFmunbzT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c95ae3-32ba-4921-64b7-08df1ec22ae5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 07:12:20.3595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC1obMwfd/clfXQhdgeNYz5EqaFkCTb2VZONCzMLpgRBBHjEUrO6pnGXalojpyIb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7457
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

Well it doesn't matter who gets the request and what do we pool.

The real question is if that goes over the MMIO BAR or the PCIe config spac=
e.

If the SMU debug mailbox registers or PSP bootloader status is accessed ove=
r the MMIO BAR space then I agree with Lijo that the approach of disabling =
all MMIO BAR accesses won't work.

Regards,
Christian.

On 9/30/26 08:35, Zhang, Yifan wrote:
> AMD General
>=20
>=20
> On Navi3x/Navi4x, the driver doesn't poll for a response. It sends the mo=
de1 reset request through the SMU debug mailbox and waits a fixed interval =
(SMU13_MODE1_RESET_WAIT_TIME_IN_MS) for the reset to proceed. After that, i=
t polls the PSP bootloader status and the memsize register to confirm the A=
SIC is out of reset. On ASICs where the regular SMU message path is used, t=
he polled response only acknowledges the message; it doesn't indicate that =
the reset has completed.
>=20
> =C2=A0
>=20
> *From:*Lazar, Lijo <Lijo.Lazar@amd.com>
> *Sent:* Wednesday, September 30, 2026 2:28 PM
> *To:* Zhang, Yifan <Yifan1.Zhang@amd.com>; Wang, Kevin <Kevin.Wang@amd.co=
m>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> *Cc:* Yuan, Perry <Perry.Yuan@amd.com>
> *Subject:* Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 r=
eset on gfx12
>=20
> =C2=A0
>=20
> AMD General
>=20
> =C2=A0
>=20
> The actual reset sequence is run by the FW while you are polling for the =
response. This patch doesn't make any sense in that way.
>=20
> =C2=A0
>=20
> Thanks,
>=20
> Lijo
>=20
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------
>=20
> *From:*Zhang, Yifan <Yifan1.Zhang@amd.com <mailto:Yifan1.Zhang@amd.com>>
> *Sent:* Wednesday, 30 September 2026 11:47:46
> *To:* Wang, Kevin <Kevin.Wang@amd.com <mailto:Kevin.Wang@amd.com>>; Lazar=
, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>; Deucher, Alexander=
 <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>; Koenig, Ch=
ristian <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>; amd-g=
fx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@li=
sts.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>>
> *Cc:* Yuan, Perry <Perry.Yuan@amd.com <mailto:Perry.Yuan@amd.com>>
> *Subject:* RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 r=
eset on gfx12
>=20
> =C2=A0
>=20
> AMD General
>=20
> Yes. In addition, the polling happens inside smu_cmn_send_smc_msg(), whic=
h runs before PCI_COMMAND_MEMORY is cleared. During the mode1 reset process=
 there should be no traffic to the PCIe BARs; otherwise, the PCI bus may ha=
ng.
>=20
> Also, every PCI config write in the patch targets only the GPU device its=
elf (pci_write_config_dword is per device), so no other PCI devices are aff=
ected.
>=20
> -----Original Message-----
> From: Wang, Kevin <Kevin.Wang@amd.com <mailto:Kevin.Wang@amd.com>>
> Sent: Wednesday, September 30, 2026 2:09 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>; Zhang, =
Yifan <Yifan1.Zhang@amd.com <mailto:Yifan1.Zhang@amd.com>>; Deucher, Alexan=
der <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>; Koenig,=
 Christian <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>; am=
d-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
> Cc: Yuan, Perry <Perry.Yuan@amd.com <mailto:Perry.Yuan@amd.com>>
> Subject: RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 res=
et on gfx12
>=20
> AMD General
>=20
>> On a second look, the patch doesn't seem right. Reset sequence is
>> supposed to be complete by the time FW responds back to the mode-1 reset=
 message.
>> During reset sequence, we need Mem space to be enabled to poll success
>> status of the message and that's most volatile window during the whole
>> sequence.
>=20
> That is not right. When the OS driver polls and sees the response registe=
r become "1", it does **NOT** mean the mode1 sequence is completed.
> The PMFW will continue forward the message to PSP and wait for PMFW ucode=
 reload to finish at a 2nd-half stage.
>=20
> Best Regards,
> Kevin
>=20
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org <mailto:amd-gfx-bou=
nces@lists.freedesktop.org>> On Behalf Of
>> Lazar, Lijo
>> Sent: Wednesday, September 30, 2026 1:41 PM
>> To: Zhang, Yifan <Yifan1.Zhang@amd.com <mailto:Yifan1.Zhang@amd.com>>; D=
eucher, Alexander
>> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>; Koenig, =
Christian
>> <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>; amd-gfx@li=
sts.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> Cc: Yuan, Perry <Perry.Yuan@amd.com <mailto:Perry.Yuan@amd.com>>
>> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1
>> reset on gfx12
>>
>> On a second look, the patch doesn't seem right. Reset sequence is
>> supposed to be complete by the time FW responds back to the mode-1 reset=
 message.
>> During reset sequence, we need Mem space to be enabled to poll success
>> status of the message and that's most volatile window during the whole
>> sequence.
>>
>> Disabling the memory space after reset sequence is complete looks to
>> be the wrong diagnosis of the issue. Access during reinit sequence
>> after reset is safe and shouldn't cause any issue in general.
>>
>> That said, we should try to resolve the issue without touching any PCI
>> config settings. PCI config space is open for others as well.
>>
>> Thanks,
>> Lijo
>>
>> On 30-Sep-26 10:57 AM, Zhang, Yifan wrote:
>> > AMD General
>> >
>> > How about disable UE during mode1 reset ? E.g.
>> >
>> > Before:
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcie_capability_=
read_word(pdev, PCI_EXP_DEVCTL, &saved_devctl);
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcie_capability_=
write_word(pdev, PCI_EXP_DEVCTL,
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sa=
ved_devctl & ~PCI_EXP_DEVCTL_URRE);
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_read_config_=
dword(pdev, aer + PCI_ERR_UNCOR_MASK,
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 &saved_uemsk);
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_write_config=
_dword(pdev, aer + PCI_ERR_UNCOR_MASK,
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 saved_uemsk |
>> > PCI_ERR_UNC_UNSUP);
>> >
>> >
>> > After:
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_write_config=
_dword(pdev, aer + PCI_ERR_UNCOR_MASK,
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 saved_uemsk);
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcie_capability_=
write_word(pdev, PCI_EXP_DEVCTL,
>> > saved_devctl);
>> >
>> > -----Original Message-----
>> > From: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>
>> > Sent: Wednesday, September 30, 2026 11:37 AM
>> > To: Zhang, Yifan <Yifan1.Zhang@amd.com <mailto:Yifan1.Zhang@amd.com>>;=
 Deucher, Alexander
>> > <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>; Koenig=
, Christian
>> > <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>; amd-gfx@=
lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> > Cc: Yuan, Perry <Perry.Yuan@amd.com <mailto:Perry.Yuan@amd.com>>
>> > Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
>> > mode1 reset on gfx12
>> >
>> >
>> > This is the behaviour of this bit -
>> >
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory Space Ena=
ble - Controls a Function's response to
>> > Memory=C2=A0 Space accesses. When this bit is Clear, all received Memo=
ry
>> > Space
>> accesses are caused to be handled as "Unsupported Requests"
>> >
>> > On AER enabled systems, depending on how the platform is configured
>> > to
>> classify the severity of UR errors, that could result in System error.
>> >
>> > On other hand, if you are sure that there is no such access during
>> > mode-1 reset, we don't need this patch in the first place.
>> >
>> > Thanks,
>> > Lijo
>> >
>> >
>> > On 30-Sep-26 8:53 AM, Zhang, Yifan wrote:
>> >> AMD General
>> >>
>> >> Hi Lijo,
>> >>
>> >> Why does clearing PCI_COMMAND_MEMORY cause AER errors on data
>> center GPUs? Are their PCIe BARs still being accessed during a mode1 res=
et?
>> >>
>> >> Best Regards,
>> >> Yifan
>> >>
>> >> -----Original Message-----
>> >> From: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>
>> >> Sent: Wednesday, September 30, 2026 11:06 AM
>> >> To: Zhang, Yifan <Yifan1.Zhang@amd.com <mailto:Yifan1.Zhang@amd.com>>=
; Deucher, Alexander
>> >> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>; Koeni=
g, Christian
>> >> <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>; amd-gfx=
@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> >> Cc: Yuan, Perry <Perry.Yuan@amd.com <mailto:Perry.Yuan@amd.com>>
>> >> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
>> >> mode1 reset on gfx12
>> >>
>> >> This doesn't work for all (at least on some datacenter GPUs). With
>> >> AER
>> enabled, this will result in AER errors. Depending on the platform
>> config, some may classify this access as fatal.
>> >>
>> >> Thanks,
>> >> Lijo
>> >>
>> >> On 30-Sep-26 8:25 AM, Zhang, Yifan wrote:
>> >>> Public
>> >>>
>> >>>
>> >>> Hi Alex,
>> >>>
>> >>> I think it is reasonable to apply the patch to all ASICs. I will
>> >>> sync with the hardware team about this change; so far we have only
>> >>> tested it on Navi31.
>> >>>
>> >>> How about adding a common helper and calling it from ASIC-specific
>> >>> code, starting with Navi31? For example:
>> >>>
>> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> >>> b/drivers/gpu/ drm/amd/amdgpu/amdgpu_device.c
>> >>>
>> >>> index b690a07e31ab..075de681ab86 100644
>> >>>
>> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> >>>
>> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> >>>
>> >>> @@ -4931,6 +4931,28 @@ bool
>> amdgpu_device_should_recover_gpu(struct
>> >>> amdgpu_device *adev)
>> >>>
>> >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>> >>>
>> >>> }
>> >>>
>> >>> +void amdgpu_device_mode1_reset_wait(struct amdgpu_device *adev,
>> >>>
>> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned in=
t delay_ms)
>> >>>
>> >>> +{
>> >>>
>> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 saved_cmd, cmd;
>> >>>
>> >>> +
>> >>>
>> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_read_config_word(adev->pde=
v, PCI_COMMAND, &saved_cmd);
>> >>>
>> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd =3D saved_cmd & ~PCI_COMMA=
ND_MEMORY;
>> >>>
>> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_write_config_word(adev->pd=
ev, PCI_COMMAND, cmd);
>> >>>
>> >>> +
>> >>>
>> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msleep(delay_ms);
>> >>>
>> >>> +
>> >>>
>> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_write_config_word(adev->pd=
ev, PCI_COMMAND, saved_cmd);
>> >>>
>> >>> +}
>> >>>
>> >>> +
>> >>>
>> >>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> >>> b/drivers/ gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> >>>
>> >>> index b250c5e41e45..356e09b7eef9 100644
>> >>>
>> >>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> >>>
>> >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> >>>
>> >>> @@ -2242,7 +2242,8 @@ int smu_v13_0_mode1_reset(struct
>> smu_context
>> >>> *smu)
>> >>>
>> >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset,
>> >>> NULL);
>> >>>
>> >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (!ret)
>> >>>
>> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
>> >>>
>> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 amdgpu_device_mode1_reset_wait(smu->adev,
>> >>>
>> >>> +
>> >>> SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
>> >>>
>> >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ret;
>> >>>
>> >>> }
>> >>>
>> >>> Best Regards,
>> >>>
>> >>> Yifan
>> >>>
>> >>> *From:*Deucher, Alexander <Alexander.Deucher@amd.com <mailto:Alexand=
er.Deucher@amd.com>>
>> >>> *Sent:* Wednesday, September 30, 2026 2:59 AM
>> >>> *To:* Zhang, Yifan <Yifan1.Zhang@amd.com <mailto:Yifan1.Zhang@amd.co=
m>>; Koenig, Christian
>> >>> <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>; amd-gf=
x@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> >>> *Cc:* Yuan, Perry <Perry.Yuan@amd.com <mailto:Perry.Yuan@amd.com>>
>> >>> *Subject:* Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
>> >>> mode1 reset on gfx12
>> >>>
>> >>> Public
>> >>>
>> >>> I think this should be asic agnostic.=C2=A0 Any asic doing mode1 res=
et
>> >>> should do this?
>> >>>
>> >>> Alex
>> >>>
>> >>> ------------------------------------------------------------------
>> >>> --
>> >>> -
>> >>> -
>> >>> --
>> >>>
>> >>> *From:*Zhang, Yifan <Yifan1.Zhang@amd.com
> <mailto:Yifan1.Zhang@amd.com%0b>> >>> <mailto:Yifan1.Zhang@amd.com <mailt=
o:Yifan1.Zhang@amd.com>>>
>> >>> *Sent:* Tuesday, September 29, 2026 5:36 AM
>> >>> *To:* Koenig, Christian <Christian.Koenig@amd.com
> <mailto:Christian.Koenig@amd.com%0b>> >>> <mailto:Christian.Koenig@amd.co=
m <mailto:Christian.Koenig@amd.com>>>; amd-gfx@lists.freedesktop.org <mailt=
o:amd-gfx@lists.freedesktop.org>
>> >>> <mailto:amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesk=
top.org>>
>> >>> <amd-gfx@lists.freedesktop.org
> <mailto:amd-gfx@lists.freedesktop.org%0b>> >>> <mailto:amd-gfx@lists.free=
desktop.org <mailto:amd-gfx@lists.freedesktop.org>>>
>> >>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com
> <mailto:Alexander.Deucher@amd.com%0b>> >>> <mailto:Alexander.Deucher@amd.=
com <mailto:Alexander.Deucher@amd.com>>>; Yuan, Perry
>> <Perry.Yuan@amd.com
> <mailto:Perry.Yuan@amd.com%0b>> >>> <mailto:Perry.Yuan@amd.com <mailto:Pe=
rry.Yuan@amd.com>>>
>> >>> *Subject:* RE: [PATCH] amdgpu/pm: block GPU PCI bar access during
>> >>> mode1 reset on gfx12
>> >>>
>> >>> Public
>> >>>
>> >>> Hi Christian,
>> >>>
>> >>> The no_hw_access flag was first set in commit
>> >>> 0de604d0357d0d22cbf03af1077d174b641707b6. This was intended to fix
>> >>> the Mode 1 reset hang, but it proved insufficient.
>> >>> I think the flag was set in the SMU code so that it would apply
>> >>> only to
>> >>> SMU13/14 ASICs, without affecting the Mode 1 reset process on
>> >>> other
>> ASICs.
>> >>> I=E2=80=99m not sure whether we can drop the no_hw_access flag after
>> >>> disabling PCI_COMMAND_MEMORY. The PCI hang occurs intermittently,
>> so
>> >>> we may need another round of stress testing to confirm that the
>> >>> flag is no longer needed. Should we remove no_hw_access in a
>> >>> separate
>> patch?
>> >>>
>> >>> Best Regards,
>> >>> Yifan
>> >>>
>> >>> -----Original Message-----
>> >>> From: Koenig, Christian <Christian.Koenig@amd.com
> <mailto:Christian.Koenig@amd.com%0b>> >>> <mailto:Christian.Koenig@amd.co=
m <mailto:Christian.Koenig@amd.com>>>
>> >>> Sent: Tuesday, September 29, 2026 5:06 PM
>> >>> To: Zhang, Yifan <Yifan1.Zhang@amd.com
> <mailto:Yifan1.Zhang@amd.com%0b>> >>> <mailto:Yifan1.Zhang@amd.com <mailt=
o:Yifan1.Zhang@amd.com>>>; amd-gfx@lists.freedesktop.org <mailto:amd-gfx@li=
sts.freedesktop.org>
>> >>> <mailto:amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesk=
top.org>>
>> >>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com
> <mailto:Alexander.Deucher@amd.com%0b>> >>> <mailto:Alexander.Deucher@amd.=
com <mailto:Alexander.Deucher@amd.com>>>; Yuan, Perry
>> <Perry.Yuan@amd.com
> <mailto:Perry.Yuan@amd.com%0b>> >>> <mailto:Perry.Yuan@amd.com <mailto:Pe=
rry.Yuan@amd.com>>>
>> >>> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
>> >>> mode1 reset on gfx12
>> >>>
>> >>> On 9/29/26 04:25, Yifan Zhang wrote:
>> >>>> block GPU PCI bar access during mode1 reset on gfx12, to resolve
>> >>>> the random mode1 reset hang issue.
>> >>>
>> >>> Interesting idea, that is much simpler than trying to mess with
>> >>> CPU page tables in the GPU reset path.
>> >>>
>> >>> The only downside I can see is that we now drop VRAM and doorbell
>> >>> writes, but I think that won't matter since VRAM is lost by a
>> >>> mode1 reset anyway.
>> >>>
>> >>> MMIO writes are dropped as well which means that we can also drop
>> >>> the no_hw_access flag.
>> >>>
>> >>> And BTW the SMU code should absolutely *NOT* touch that
>> no_hw_access
>> >>> flag in any way. Who added that there?
>> >>>
>> >>> Regards,
>> >>> Christian.
>> >>>
>> >>>>
>> >>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com
> <mailto:yifan1.zhang@amd.com%0b>> >>>> <mailto:yifan1.zhang@amd.com <mail=
to:yifan1.zhang@amd.com>>>
>> >>>> ---
>> >>>>=C2=A0=C2=A0=C2=A0 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c=C2=
=A0 | 29
>> >>>> ++++++++++++-------
>> >>>>=C2=A0=C2=A0=C2=A0 1 file changed, 19 insertions(+), 10 deletions(-)
>> >>>>
>> >>>> diff --git
>> a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> >>>> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> >>>> index 072d9c4e202d..25b9085ead71 100644
>> >>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> >>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> >>>> @@ -2078,21 +2078,30 @@ static int
>> >>>> smu_v14_0_2_set_df_cstate(struct smu_context *smu,
>> >>>>
>> >>>>=C2=A0=C2=A0=C2=A0 static int smu_v14_0_2_mode1_reset(struct smu_con=
text *smu)=C2=A0 {
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_device *adev =3D smu->adev;
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0 u16 saved_cmd, cmd;
>> >>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> >>>>
>> >>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D smu_cmn_sen=
d_debug_smc_msg(smu,
>> DEBUGSMC_MSG_Mode1Reset);
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (amdgpu_emu_mode =3D=3D 1) {
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msleep(50000);
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 } else {
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* disable mmio acce=
ss while doing mode 1
>> >>>> reset*/
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smu->adev->no_hw_acc=
ess =3D true;
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* ensure no_hw_acce=
ss is globally visible
>> >>>> before any MMIO */
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smp_mb();
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msleep(1000);
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ret;
>> >>>> +
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0 pci_read_config_word(adev->pdev, PCI_COMM=
AND, &saved_cmd);
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0 cmd =3D saved_cmd & ~PCI_COMMAND_MEMORY;
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0 pci_write_config_word(adev->pdev, PCI_COM=
MAND, cmd);
>> >>>> +
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (amdgpu_emu_mode =3D=3D 1) {
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 msleep(50000);
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* disable mmio access while doing mode 1 reset*/
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 smu->adev->no_hw_access =3D true;
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* ensure no_hw_access is globally visible before
>> >>>> +any MMIO */
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 smp_mb();
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 msleep(1000);
>> >>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> >>>>
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0 pci_write_config_word(adev->pdev, PCI_COM=
MAND, saved_cmd);
>> >>>> +
>> >>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> >>>>=C2=A0=C2=A0=C2=A0 }
>> >>>>
>> >>>
>> >>
>> >
>=20

