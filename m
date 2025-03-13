Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69565C282DE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 19:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E17F310E0D1;
	Thu, 13 Mar 2025 19:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ryfXGYvl";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDAB410E0D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 19:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuaRemRGZ+lwGtpakv+NRW3Pmz5Nb+i17xiwjnlAUTxUEJeVcYg+BZ0Fv2/GtzQ1tYupPk4QVWsfe8OyOXHUTF7fq7v0AMzXdKTP9BGsbQb/FSb3NVJ0UMAT66iRLVIWbebyMPxxjRwNkj2uVunhTevrqZkctJBIz24aG195g73Li8bJ2ccx5/ZkmN0QXy3g7fcpcLh2dnbto3g1WI84KU7HJVAVhmCz/+B3arEQ3IG47YcTRTTI2CRE8Mg9jElQPJeqtUc32c+0WT0uNrpLUAzmKsCVivTpfDX77F2IGgMMnpd+Ia2VSzHC86JcVji5bWSptgmjeMbX6t4y8rhZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pz23cT34V08PLMxLVtpPjBUo2bGkeO833Qq4Yr792eM=;
 b=jHEFvrlbL0sCmtv9iQq47uH1fF3exG3oowwW10Jn8a5wxksVUDaJhslPuG79GbC89t8NBOEg5zFY+YfqF7v7h5dEL46uRH0lxdtSIVaWiqx8XpPFRnQFKjNZDV00QanEh8hDQBr/VrHtnr7FnqxbX47KfkLLC7gifppTZQuJJkVViy75VIrnabV1Lx0p3ETCnyq8dmsPhthsksQoVX+gkmXqD4dH0tvTQii6uFu/9XTrR8i9y01Xf+PS7jtc4oDo8rnM/NnHMWKSdwOMroiEEAiR21dA0bSH+Auo+d0MNjLtQlzoeVm+gMCkc6q2j86cAB5FGevgNW5G1Uvy/Fp9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pz23cT34V08PLMxLVtpPjBUo2bGkeO833Qq4Yr792eM=;
 b=ryfXGYvlYelLdPXNrh/imbnyOpuPpuZNnLEDosNJp0Rzt8fEvdWbze8rt3RPOp07XkhWW1V4/sbjLDdICdlfmdM8sS/VV5ilcsXAs+FypeD2m4ocHiozvp73GgD03EJkJVatGzgwW1fwPI1PF9rR7CXhtMdkbuJR2CCT7gfmMTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 19:35:51 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 19:35:51 +0000
Message-ID: <5817095a-fd0c-4ca8-afe4-ff89cda2a4f3@amd.com>
Date: Thu, 13 Mar 2025 13:35:47 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] drm/amd/display: more DRM edid common-code to the
 display driver
To: Melissa Wen <mwen@igalia.com>, harry.wentland@amd.com,
 sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 mario.limonciello@amd.com, siqueira@igalia.com
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20250308142650.35920-1-mwen@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250308142650.35920-1-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0011.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::24) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|MN6PR12MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ce987b-b5df-40bd-0387-08dd62664346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmZjUFBHT00ramdqNlRyRDN1WDdYQ1Z0NTZKK0JjQ2U2cCsvb3BzTmcwa051?=
 =?utf-8?B?RHZrcUx1bWVIR01OSTdxYmI2T0Q3M2xZenpsKzZ0N2ZGVmJzMENkQmZVRnJv?=
 =?utf-8?B?QjhjS2pPdEFqMlhCSW0vMHY0NkhMR2RHT0xrWlRRU2ZjYi81M0JnVVR2MTY3?=
 =?utf-8?B?bjM2YzhGRi9uTWtrbWI1bUZPallIUDFBbW1ZZkY0WDc5ZFhTbGI3bE9pb2Qz?=
 =?utf-8?B?R2I4WVpTVEpJNWRuNHNFdCsrbHNrQjZsSXlnaGpyb0kvemFQUHVkTDgxekV6?=
 =?utf-8?B?RWhkOEd1NWhJSXRPQlNlaFA4NG51ZTVHMThKN0dpTkNPMXRTcFVLU0c1MzRZ?=
 =?utf-8?B?Mlh2UGtRa2N5dlI1UFE0TnUwWHNtVmN5V3lQcEJHRVRTZ1BSK3Bwdk1PQXRW?=
 =?utf-8?B?T0llMU02UkFPZ080S1QrSk1ZR3Z2cm5VdEg3bTRPT2JTVzFBR0tXMzZPQlI3?=
 =?utf-8?B?bkNrcURqQStEaDYvSk4ySDZmL1M5enNtbEw5bjBOOVpMWWRCbmo4Sng4dmFR?=
 =?utf-8?B?SlZFakJEK0ZwSERsOFdRWlYyWVZrckpKSm9BaTR2WmpHTTlTVWY0cWZnZVR6?=
 =?utf-8?B?ZzZTSGg1WmljVjF0eFBYem1iYXZqM3VYeE41THV3c1ZiOTUrbGtHODJzVVJV?=
 =?utf-8?B?UXArS3laTWNVWEtwbFpNNGpyOEJpbjJRVDc2djdWdlBONUhGa2EvSkJxb05m?=
 =?utf-8?B?R2hPc1hHd1R2R01oVjNZT2lsSThHeDFEekRYblJQeVR2bEJXemUyN0VXektL?=
 =?utf-8?B?aUFPeUFQdE9udmN1MVpsaG90NlllNENkZkk5UGdJYVowQW9GeTJsMnZJNTV6?=
 =?utf-8?B?b2M5eDVLKzNJdW4rdDJmQ1hPNldWSlQrOHY0VkhrZUtDK1FvYmlKQjl1UWVo?=
 =?utf-8?B?NHlXS2JCVzRxdFN4eGxsMXFKb3FqRzc2M2ZvRk1pcHgxL0xiTlV2VnpSbVl4?=
 =?utf-8?B?cy8yZmtHdjU1QXpoNURCZEtJK0RXdDdkQ3BFVjlUeU9NdS90NEFzNjlOZHZQ?=
 =?utf-8?B?VG9NRUs5dXdXWnJwbTViZkpwUis3QXJ0UnV6dG5uOUkwOFhQUWJBK2NXN1Br?=
 =?utf-8?B?ckN4bkx3bjk4YWUxUGY5TTNsZ2RXcVJvVDdvNU9CNzk2L3EvVVk3dDY2WGpn?=
 =?utf-8?B?ZWFkRWhLWndvaVAvOWk3alRvc2lHcmVCbXd3bnZSWUFnOU9GNXdqRFhzWHFY?=
 =?utf-8?B?TVYvM3Q4Z3I5amltbC9yZkZnNkQ2Q2QzYXpNWUxkQ051cTY5aWUwaDJJRHZH?=
 =?utf-8?B?ejdvQ2dlNzVwVE1TK0h1Ymg4bkRrUE5mYWxOS0lrc3RycDRVV3c1NmR0UVVH?=
 =?utf-8?B?S0ROS1phMWdEcitveC9OVGg5N0ptaEhMNlpaM3BZaURjamxHVzlrK05QeSs1?=
 =?utf-8?B?Uzc2VDFkeFVScWMvN2k1WVl3SWw3RkZoV3V5STVNQW9ZeksrbXg5bFNWcito?=
 =?utf-8?B?RlY5UC9iUVlaZFpnOEs2UFZPS2hldGg4d3I4WVdwdi9TNkc3Z0h0clhLQUQ2?=
 =?utf-8?B?ZXpwVGNjY2dCdGhnZjJweG9KaDlsVm0xRG5ucmdOUDd6cUlWd3BoNGhacXlS?=
 =?utf-8?B?V2cvWWFMemNoeEEwRmNZbEJhMmhHb09VU1BjN05jVzZWTEN6Tnd0YnEzb3JR?=
 =?utf-8?B?VytvVDdJczBIU3ZYOGEwRkpNT0FTQkF1bU91M3JEbVJ1QWdxWTQ4RCtjMHlj?=
 =?utf-8?B?bTB4Ym1NbThoSnBrNllZZWMrQnhLZ1Y5ZGJOR2Ftc1dVYVBlY1A1RkVMMFVs?=
 =?utf-8?B?VEZaZHZMSFRqT3FuY0pQZUdoYms0YjBYOUhoSmRheEtvR1MvN3NRYnpxekkr?=
 =?utf-8?B?TjBaN2FBVUJqTFpyMEFuUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVBXNGxyMEF2V0RwOXptOUdiWGdYNTBtOXdTMDdXYzc3bzdKejVYUkRRUVhW?=
 =?utf-8?B?REMzbFRYa1B5djJjandtRnE3dC83cm9Cc2pYR0R2VmVGZGdEMkhYK1ZuZ2pp?=
 =?utf-8?B?QWc2YVFMNFI3QVFBTU4zc3dRbkVIUmRQUEMveFpVVGY2dW12RkxZTEc0eE5S?=
 =?utf-8?B?QTk0WlJDL1NZSGdBRUpIdHNvcTZoNWx5Si9zZ0JUY3hYRmhjR1JTWlFwR2Jj?=
 =?utf-8?B?cjVtOHZtN0tRNVZMckZhZkxMTnZOWENOSC80a2RTUi82WFE2d3pFcVhZc013?=
 =?utf-8?B?SEpMc3BpRFR0N2duZGVmL2t3azR1Ym9xSmFpWkJMbXdMOVJxakd1ZE9EUFpZ?=
 =?utf-8?B?ekZFWmtUS0xSWHVvWkE4UnROajFmSVpqYWZpV1cyeVpHY09KR1lrdHF5eWxw?=
 =?utf-8?B?d3l1Sjcxb0E5UEg0dGxOcWU4OEVjNXVSUktlUHN2M0VaTW1WamVBVys0WEdr?=
 =?utf-8?B?UFIxR1lyRWdMYzE2dXQvekk5c3B2K2UwdndlOWpYaHl1MW40UFBkV0xiRlU4?=
 =?utf-8?B?ZlY2RlRlYTdaL3JlZmpaWnEwajErbVhBQ0pxSnVTMDE5L2NDcFlUSGxibU16?=
 =?utf-8?B?a25BNnY2NnNadmdhRkdrQ2V6RWozTUE3MSt4MXYrV053ZklmenhENlhFcTJT?=
 =?utf-8?B?TjR5N2lobWQ5Qi93OEJlbjVCOVZVeENDYlMydU1HY045YjRNR3pPd1dQa1NO?=
 =?utf-8?B?R2lsSGFMU1IwcnQ2NWg2Z2xQdlBhSXQrWnNXTVFPMHFmNnFQYTVrd3NiMTd2?=
 =?utf-8?B?cHJWQ2FiUjcwZHU5WWl5bXdDMWliOW5Cc1RtM2RwMmF4N0poVWtUTlJHck56?=
 =?utf-8?B?WVFSbitORThvRFZQUGpWenpKV0swTG9OcUxKK3lxdnR6M09GMURRd1JrUVFG?=
 =?utf-8?B?b1p1SVlUbDdJRzlOOWtHQzI1WDJva2FBa0dETXRrV0g1aGEzOFVlV2NqWnZn?=
 =?utf-8?B?ZnpKb08reE5qUnE4Q0Nzc1AzOU9UdEtZU0FMZEZHWDFWUjYzeDFQaG1SWEE1?=
 =?utf-8?B?QkMwZGpURTNOQ1FVK2hNYThxd00zUWd3VGpDaDhXWXhocVJTUUJpdEhzWFJs?=
 =?utf-8?B?ZmpMN0V4cXM0TURFU3VVdmg0REdVajg5ZGFCRnhOV3lpd0ZKbFhqWUVETDdp?=
 =?utf-8?B?YkJiV3Q2WWlURVZLdU9DRHRoTERPdjcwRDdYclRzeGFvbTE2cXFyR005eW93?=
 =?utf-8?B?emNuMFdEeHV5U1VybXVxQjMwR1RNWDduWjZFRDNXSmx2RHYvQk9TeUU4ckY5?=
 =?utf-8?B?eW9VWE50U1EzWDFwYjVxZmxMTElTT2VKbjJyeFg0d29lSEhRQ0ExWGVXeXVD?=
 =?utf-8?B?eGx6V3BMU0tuNHp2RmtJOGxybkFWL3NRdTNLWHdudHZodTVlY2hUVjJxSm5i?=
 =?utf-8?B?ZVYzMFFkMm9waUtnT1dLZDBNYkJoTHlielpBNCsyNFlEbHhjN1VjaDZuSUZu?=
 =?utf-8?B?bXVacHY3a2ZyRUY0eXM1T2VqSFNyUG94YjhNQ0xwazhQa05pbVYzNGlLc1hv?=
 =?utf-8?B?VHJqVFB5K1ZTZUFreTJoMXpyNXNjSU9HOFdRR0VlZ09BMGlsbk8zaEY4QlhZ?=
 =?utf-8?B?aVZRY1FFSFpTbkQwWSs1UmhpK09Rdmd2YVpYSzRVN0xwQlhuYWl1eVFKVjRB?=
 =?utf-8?B?RWp6MnFHVlZyaTJhKzhJTzNOeVNteDBYY1MvbTllenloeEs0YkhNblZDa1Nj?=
 =?utf-8?B?cSsvTS80NVVIZ3MzeFRZcVJQeHJObWV5WVVWNi90MERFZTZockVNVEVjMStn?=
 =?utf-8?B?WjVqOVJSclBIb3UyajZJek9XNzlKdVRZNUt6d2dOMTM5OTQ3TUFQcFdscEJX?=
 =?utf-8?B?c2o2REI4SlJVVnppWHBPeGQzMUxZeWlDVitPek1SK0pCL21LTXlDK01PWXds?=
 =?utf-8?B?WkxwTlFpUXZaZDMyREgxS015dFhWbEx4eU5GZFVEbUJBQTJlRlVXUVFyajNN?=
 =?utf-8?B?T2l5N0ZGK1kvTWhnM1lPQ3F5M0ZBa3FmYlp3ZzE0NkMzM2xoM3YwR2ZKWG8w?=
 =?utf-8?B?T281TkdZSlFnQi8wcWxYcUtJMmgvM2NLakpJS3NyRVFJeC9sMWJDWk9TNitM?=
 =?utf-8?B?ektQejFWZkVjQkRFQm16VHFMWjNiVVpzSUkwckRnRXJub0R3aWhUb0cvb2ZR?=
 =?utf-8?Q?SQSYpRDmHMfNRPlKiGwegxh7r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ce987b-b5df-40bd-0387-08dd62664346
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 19:35:51.3270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ikjrk4G295sK/0gqNPR8mWkCYnMTU14aSglA47LCQI5vpO1S0yBLxbsAOEH/bnQzFYe9ncPR0w7cleSajvHCdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513
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

The series look fine to me, except one small error in patch 2. I can 
send this series to promotion tests once the error is addressed. Let me 
also check others for comments.

Hi Harry and Leo,

Do you have other concerns before I sent this series to promotion tests?


On 3/8/25 07:26, Melissa Wen wrote:
> Hi,
> 
> I've been working on a new version of [1] that ports the AMD display
> driver to use the common `drm_edid` code instead of open and raw edid
> handling.
> 
> The part of the previous series that didn't make the cut was to replace
> the open coded edid parser with `drm_edid_product_id` and `eld` data.
> However, when addressing feedback I ran into a design issue in the
> latest version because I was trying to not add any Linux-specific code
> to the DC code, specifically, DC link detection. In short, we have a few
> paths in the DM code that allocate a temporary `drm_edid`, go to the DC,
> and back to the DM to handle `drm_edid` data. In the last version, I was
> storing this temporary `drm_edid` in the aconnector, but it was
> erroneously overriding a still in use `drm_edid`.
> 
> In this new version I allocate a temporary `drm_edid` in the DM parser
> from raw edid data stored in `dc_edid`, which was actually extracted
> from another `drm_edid` in the previous DM caller. This is a workaround
> to bypass DC boundaries and parse edid capabilities, but I think we can
> do better if we can find a clean way to pass the `drm_edid` through this
> kind of DM -> DC -> DM paths.
> 
> I checked working on top of Thomas' work[2] that replaces `dc_edid` by
> `drm_edid` and adds this DRM struct and its helpers inside DC. The
> resulted changes work stable and as expected[3], but I believe that
> adding linux-specific code to DC is not desirable.
> 
> Siqueira and I have discussed other alternatives, such as updating the
> DC code to match `drm_edid` structs or checking how well the change in
> this series could work with `drm_edid` as a private obj[4], however we
> would like to know AMD team's opinion before making this big effort (and
> probably noisy change). The main goal here is removing `drm_edid_raw`
> calls and duplicated code to handle edid in DC/link_detection that can
> take advantage of DRM common-code instead.
> 
> Please, let me know your thoughts.
> 
> Melissa
> 
> [1] https://lore.kernel.org/amd-gfx/20240918213845.158293-1-mario.limonciello@amd.com/
> [2] https://lore.kernel.org/amd-gfx/20241112-amdgpu-drm_edid-v2-0-1399dc0f0469@weissschuh.net/
> [3] https://gitlab.freedesktop.org/mwen/linux-amd/-/commits/drm_edid_product_id_v4
> [4] https://gitlab.freedesktop.org/mwen/linux-amd/-/commits/drm_edid_priv
> 
> Melissa Wen (7):
>    drm/amd/display: make sure drm_edid stored in aconnector doesn't leak
>    drm/amd/display: start using drm_edid helpers to parse EDID caps
>    drm/amd/display: use drm_edid_product_id for parsing EDID product info
>    drm/amd/display: parse display name from drm_eld
>    drm/amd/display: get panel id with drm_edid helper
>    drm/amd/display: get SAD from drm_eld when parsing EDID caps
>    drm/amd/display: get SADB from drm_eld when parsing EDID caps
> 
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +
>   .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 85 +++++++++----------
>   2 files changed, 42 insertions(+), 45 deletions(-)
> 

