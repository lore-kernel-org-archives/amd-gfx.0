Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEBECA0EDC
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 09:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 302F910E81F;
	Thu, 14 Aug 2025 09:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="afzimrYg";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F7E10E81F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 09:11:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYo9c3ei6NMz2wLo2FmTJPrgLgnzdzVsriJv8EvYngXIyfn7rLz/ydZfTwhRwvFqj/vHW7DIewj5bkUPvkbQBoC+9MPDgiTWG2s0GKbkxiFm5ZQ6qo1ph5egrkQnSNbGwdvz5iivc4d5nh89wbsn69Blfz3ctCwIMVlNoINSAxpnsstHsYiCdzQkFMvwI3UmwVw1Yc30ks5K9Vcqf/gXv1B4GXt6S5fg1cAP9acsNc+QV/Nfzh9rGN7j4pVMsGfi8f0ZA57iQZyv8ecDQktWE10qErOcScl6ieNwrYHYSZS1G66cn5B0ZzX/vSf1pIn373i1HBdgK4l8cEcUEgtyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndqC2Fh3x3Bpltbwjmjt9SE0gzUIHMnWjQfwfIIFm9c=;
 b=aQoKFwCvX5IG8ndTVGA3r8fCcg48/S31pcpoyg2SvCRbPFDKcRitNNH6zXc9o6p/0oUzcf7eXrC0/GukH6azmfczdJ6e0SCviPRnC9k2nl0CKOEBbMYq2tY6BzO5a1mL9XQjfGKgxDIptzqORj6nwzglrQMrmG5RdvfOchvwq4+ITw2LJirgrNj5epIRCMvmbu4ARjtQnJF/KBvM2+WKtp1gkJwW/+p9u3zPdV75iGi3Enw1mimX9zoCTe6Cb/2NUeVSwMymoe2guOsk9DMIRxXVdATrF5ApLgF5yeVfMtfV1Dt/CLfHN6TpXHCjOXTwLyzUtpjNkiJ/4g5ML1t6LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndqC2Fh3x3Bpltbwjmjt9SE0gzUIHMnWjQfwfIIFm9c=;
 b=afzimrYgYRt9i0uZ/VD9PPZrBV8PfmTGfPKCMLgn8gS+ClKe+II4YOwV6rrwuy3GyF1EssomOKGkuBE3bUE5GMnMVXOPS5PkGav1MVERJ9fvcaFfmUspSoeJRRHtj4kc8b8WuZEAptCAoG2kr7hNmyMq4ycTYqV02+qBVnxppuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 09:11:17 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 09:11:17 +0000
Message-ID: <dd993060-e357-ebe2-4786-cbff7f3eb60c@amd.com>
Date: Thu, 14 Aug 2025 14:41:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
Content-Language: en-US
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: "Wu, David" <David.Wu3@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <ae769200-c37e-426b-b73a-ac9473cf66eb@amd.com>
 <CADnq5_MbT-4Q4HfQ15AWMNGu6hct2=Yu5K5+F6qMGWDC6H_ojg@mail.gmail.com>
 <faee7074-f3bd-4791-b3f0-fe409049de06@amd.com>
 <dc8beb3b-789c-03c1-1c37-50c998b7e44a@amd.com>
 <CADnq5_MJouzU1QFsuuMtiXeFAHi96zXfBzuAWFAvfauHssw_eg@mail.gmail.com>
 <1633c024-a1dc-cdc3-6a28-c48b49640297@amd.com>
 <CADnq5_P7OWj6GLi+qzZ_EVZAK5dPiOrjmvV9CRqRG+iFtcq78Q@mail.gmail.com>
 <376e6482-7319-426a-3d67-994b9581c678@amd.com>
 <CADnq5_NajJn+6hHVmQsxBQ=-j_Xhc50csXGVPDmRoDvAb3AZgg@mail.gmail.com>
 <422ce379-1a56-de36-c040-6da658dead63@amd.com>
 <DS0PR12MB780454748D8280FEAA9DF3339735A@DS0PR12MB7804.namprd12.prod.outlook.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <DS0PR12MB780454748D8280FEAA9DF3339735A@DS0PR12MB7804.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::31) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: 996c5f43-a6ce-4462-bb63-08dddb12864e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVE4V0VrRWhjTzUxak9BWndKSFArRythT3FYSnZ0d1RqQURabmNVVmVRbWE5?=
 =?utf-8?B?TVVnTTZpb0FhM25pbmxaWEIxdk5yRmZsbWpaUklHWkZGTEFwWVpVSVhDUnhN?=
 =?utf-8?B?ZTF1cjczRDZvVEpZZ01RZWhWMjB3bFl6ODRwU2haaWh2bjhyRzlYNCtGeGov?=
 =?utf-8?B?aDUySTZ2S0FMR0pXNEI5cFRzc0dNb1FtbXVjUWF0ZnZMTEdzME5UMjVqWWZU?=
 =?utf-8?B?M0hRWFRjYkdFTGVNcE9vSHZGajBVNWN5enpMUEgrQnlNMWpBUEI4SlFEM2lm?=
 =?utf-8?B?N1piSXk5UGUvVVdwZEJuaWhqWG5JcUw0YlBSQ3F3SWZuaEhOSE1xRmROSTZY?=
 =?utf-8?B?d3R1RVRsRmdoY2FpQ1l5RmJHQ3cxaDdRZkE0MFgzR3RGVWMzbXIyT1NBSk05?=
 =?utf-8?B?MHFqZGhlSzV2OW1EVUtCTmZmNDlyTVNIUEEyM2xrOHFCNEdJUFpnaEw1aG8y?=
 =?utf-8?B?ajBVZzIxdGZUMmtFNm5NZ0tCTzZpQ0ZXT0MzL0RsRW5NUDEzeTNWTXNnWWJJ?=
 =?utf-8?B?MlFrZ1FDS0xjRzk2d25RSmFrRk1XUnkzQ254NjE3VUZUbTVpdWc1dDdDRHEy?=
 =?utf-8?B?elhoMzdDMWdlZVVoZnBueUJhbkFaQVlkZ3h5M3RDbFM3TlVWRFBIRFFYdmhI?=
 =?utf-8?B?UG5GbzZwRDdyeDA1M3NrNDRBa3VUV2FqVGpTNGZuZmRUaVdyOVFLVXZwV0dk?=
 =?utf-8?B?Um45TDJNeGUvcW13TUNmUExQTW9RNGF5Y0xPRTFCMkhZbkJjWWkvbjg4RXRo?=
 =?utf-8?B?SmtnUWo4MXJmUkRaQy8zd1JNSDE4eThEOTBtWFJBMitlTm5TY1BXU3F2VWFE?=
 =?utf-8?B?c3NlY05HckVjMXVkOWtkejA5Zmc5OEFyZnBJMHoxUzJ6SjBzSUhzK0lVNS9J?=
 =?utf-8?B?YmF4VmZGMUJSdzdwQU5GUnZEZ3c4UWd5K3hKSXdxRlJzN0EwVzU0YnBUdTQ4?=
 =?utf-8?B?TVo4bjEra2I0SWxFcTlwZVI0cnZmblErYU00UWlOR2IvLy92TnB1azlLaGZQ?=
 =?utf-8?B?c2trc21Ncys4MXZIREJxVzhSalRhTlFGRlp2eHJybUlwTG5jNXBJMVpUZHVB?=
 =?utf-8?B?Y3d0TVUxaHNmT251Tlg1SXFwbno0RFlRWG9rc1J1SlVuVXNpSmJvY0dpYU16?=
 =?utf-8?B?WThoMUJGSitvSDV1a09kbzBSQk94dWlpQmpnOFN6bFFVY0JwdnBwS2FXMFJr?=
 =?utf-8?B?QnB5aEpRNGVybGQ1TlVGcjdOOElMT3JNMmlud2dCcU5WV1NvRWZ3VzBOYTA4?=
 =?utf-8?B?cFk4YVlneS82MW1ZdVVYaFY3QVZLMVhYaHRZQ0ZRVTVQL3l2R0JSMU1VT1p4?=
 =?utf-8?B?Zm1UeFFMY2wycm9qUmlGeE5xNmorVHZ1SWM2SHhWMzBtcmN4dTBob01NR25L?=
 =?utf-8?B?L3R3N3Vocm9JU1hZWUVmV3FXdC9TbXAySzYvYUhjWm50b1JtRkJQeGhnUVNw?=
 =?utf-8?B?SEhxeHozeTFRcEdqVnRnZ3hCVnB1ZnVJWFBDM3FsQWtEWVBHUXc3WmkrdDlu?=
 =?utf-8?B?ams5cnBnd0ltSmNxcjAydGp1RW1CYjRZYmR5VjlOYTFjY3IxNkhESkNJTjdO?=
 =?utf-8?B?aFpzWGJnenFMR1NqMkk0T0ZFaXRxUnJQMkZXR0hsQ3JlamN6R0QzNnR0V0dj?=
 =?utf-8?B?Z05pMEYzVHg2TVhCVkNQVFlMblN0WEM0YkdqQjhibENZVnJvWEFxV3dkMDdh?=
 =?utf-8?B?MXlTQjdRM1hyNzZvMnVCWlZhTUFGTDFIOFh1ZTFjWlI5ZkRYZjNTVFc0WVd4?=
 =?utf-8?B?eElOWGRJdkdrNTAwa2lKK21JWEtpM2U3Rk4zUE9vajkxcFRGbVJXUldnTmRT?=
 =?utf-8?B?aDIrYlJvY0lLaFlqLzF5clhrbWxXdHNqRUVMYkVMQ0N1YlA0dmk1OXVaTi9z?=
 =?utf-8?B?OFFFUjJpUzZFOWhuZGRPSUFGaUlYNVYyamM1c3JIMmlrQXJ4YWRlUVYzNS9X?=
 =?utf-8?Q?RyaTqx/EoCY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXlIbDZqbXpNSFhCY0xucTRZTDJMcXlXcDlDc0owcWR2Q1RuakVhNWtCUU4y?=
 =?utf-8?B?ekIraHpKTmQreHNxR2NCOS84d1lhOUtLQmRaN011SXNPRWE5ZjFQWU9XWmNz?=
 =?utf-8?B?NGhSdjBIUExtWmJZcVZqeXpEV2t5OEZ3c2RTdjdvWGd1MFA4NzhLTEpzaHBm?=
 =?utf-8?B?cjBjSUpyKzZQYjRVRThoanBWK0ZobWpjdUROcXhqaUJjM0k3cXNDQzdsL0JL?=
 =?utf-8?B?ZFZqNUFDdGd2WGx2cFIzcDhpaHhNck1ReVpJUndwZWhPS3hiVHF4NlNxOFhk?=
 =?utf-8?B?NWR0YjROSXNrb2ZiclNyUGUyOCtnZ1ZFbmEzRFVNRnd0VHBsNmRXOEE5eG83?=
 =?utf-8?B?dWY5Kys5YlNoT1JOb1hpYTFycWJ3UGNGVEdSZ2lEMWIxcGtiSkdIWG1TdXpr?=
 =?utf-8?B?blVWZW1qMmdkck4yMWNWZ1FGWDRLK29JTkNhYjB0UUJ0WlhvajNvNXp1M0VQ?=
 =?utf-8?B?QzE1M2I0WFYxMEhkV0F3dkd1Z3NwMU40M1o2U01QMUp1NDNkdWhtQ2tLa1B6?=
 =?utf-8?B?SGNtSUJ5NFBJSVorN3JpOGxMZVU2akV2THdxQ1RaN24rbDd5cFB6UU5wNWJl?=
 =?utf-8?B?bGtXV3ovVjBQUlI2TyswMXFzQVBqdUV6b0RBS1YvenRvczNxbWpiRExKUXRI?=
 =?utf-8?B?eGdFL0V1c3RtS0tBWUJlallyTzlGaHJVTU5YVkFBdklLMHhqWnNWdzE3NHVU?=
 =?utf-8?B?OExnZ3RVaktrdldUd085ZXhTTWJ6SVFUcW1vTWxXUzhUdXFVeCtobHFmMmJH?=
 =?utf-8?B?VEQ4NE56TFFjdmcvMEZMUzdHY1VyUFpvcUI0cTRXVzJ5RHJ4VDNHKzhGRlFJ?=
 =?utf-8?B?dk1EWXU4ZGV0aUtUVytQNjYrWHVqOHBDZjZjUjg4Z1NieVYwTFk2RFdrUmY0?=
 =?utf-8?B?cTkyRk5sNG1FOHRPT3hKTXprT2xoSDVmU212YWJ4clhWYlIwSDRxU2JOb2dj?=
 =?utf-8?B?MW1qZDZrdDcvMmt2NmQ0S3cxb3NEMzB4dmp2Rk1FWWhLdDViQ2gweDMvckJx?=
 =?utf-8?B?cStQeXNjemRNSXVyZ2c4L01EM3VxczRZcFlSTnExWEVSSTBEZkhoV3VQWnVj?=
 =?utf-8?B?UXI2TGxZbHlkVHlxcE5HK09hMVZwYk5GK1BBNDZMV2dUb3Q4a0s3aUgwU2NE?=
 =?utf-8?B?QU1TaDZ5K3VoRXc0ODFDVlQwaHdrTE9GajJSOU1WeWpPWG1DK0t2Nlo4UW5p?=
 =?utf-8?B?Y1VMN29JWFM2SU9KOWpibnlhdUl1TFV1QzBaUFB3UGR5MEwwdnk0NlcrZi9l?=
 =?utf-8?B?MVlnR3Q4dXJza2dhck5KaW9ndnhrM0NjenVhMUNqdG5sbG5vdHo5N0tLSnFR?=
 =?utf-8?B?cUpSd09halNyTElOK3lXMXJvWDFyV1ptTW5uU1g3Vk5SWTRpcGZRUjg5QThD?=
 =?utf-8?B?MmpRZkNjRUFSOEpLV2IxTjQ1b3FkZ1pCcUo1Zi9UWVFZemdnaHhITExZM1dh?=
 =?utf-8?B?bXBjcFlvTVdiSVFmcUZ1NUpIdVFjUFBxOEIzcGJmWitDb0NSRzFDNnhudVBv?=
 =?utf-8?B?dUk4aU95aTNZaXp1cis2TmlWUlhRTUlrYUJ4U0RrSUVjYTU2QUd6SThSNXdD?=
 =?utf-8?B?T0U0MUhQN0dvdVRSelNrS2hEL2lrRDZWdnZlVVVYSGNlWnRpTGgwV3BnN2dU?=
 =?utf-8?B?bDRrMS9LUVN4MUVsMjN0NW41VWdkdXlHMUNpbTlsNmZCSitiSEFDb1AwY3hk?=
 =?utf-8?B?cUxsSjFGWVgxZmRXUjBjeU03eWFVN1o3aTRrT1BhRVVCYnVpckpyVUNueW5u?=
 =?utf-8?B?NDV1TEs0ZmpsQ21hUUc2SmRuTjFQbHRUTHJZNmJHOGFuYk1YMUIxY01pUDl5?=
 =?utf-8?B?SU9iamZ2SUQyc1lnbHdhSUZabjdZeG5IUVZmZDFsODZHa1BrcHBEcWN6VFlW?=
 =?utf-8?B?MnQ5NnpMVjdFZE9UdUdoQ3ZlaHY5Yk0yNGFFSUVyZEpSKzJSZW4rcGRoQlNY?=
 =?utf-8?B?eE9yU29qUEc2SEJBZTBjd3VoYS9qc29aOFo5djZsRFBtbGRKRVRZMDVPdm41?=
 =?utf-8?B?WkNjZXlqMnl5cWRHVTZxNmMwd2h6eWNtTzJBZkFNeDJoaldFUk9WT00zZlJT?=
 =?utf-8?B?OVNnOUQ5WFRTY0p3UllWOVphOFZDaFp2eXVaaVZOajNqcFcwajJnT0haVDBn?=
 =?utf-8?Q?FhCAXmMGlSHHPWBM+KA9qcXIU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996c5f43-a6ce-4462-bb63-08dddb12864e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 09:11:16.9304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgB9STfBMk94NZHHHyo68MW9V6d9IdNRCu++PC5KY7/QgHsjNvpR5Th/rnrxINfuPKG2DdBvr+ekNDfNx0Ik1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
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

Hi Lijo,

On 8/14/2025 2:11 PM, Lazar, Lijo wrote:
> [Public]
>
> We already have a per instance power state that can be tracked. What about something like attached?

This also has concurrent access of the power state , 
vcn.inst[i].cur_state is not protected by workload_profile_mutex

every where, it can still change while you are holding 
workload_profile_mutex and checking it.

Regards,

Sathish

>
> Thanks,
> Lijo
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sundararaju, Sathishkumar
> Sent: Thursday, August 14, 2025 4:43 AM
> To: Alex Deucher <alexdeucher@gmail.com>
> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
>
>
> On 8/14/2025 3:38 AM, Alex Deucher wrote:
>> On Wed, Aug 13, 2025 at 5:16 PM Sundararaju, Sathishkumar
>> <sathishkumar.sundararaju@amd.com> wrote:
>>> On 8/14/2025 2:33 AM, Alex Deucher wrote:
>>>> On Wed, Aug 13, 2025 at 4:58 PM Sundararaju, Sathishkumar
>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>> On 8/14/2025 1:35 AM, Alex Deucher wrote:
>>>>>> On Wed, Aug 13, 2025 at 2:23 PM Sundararaju, Sathishkumar
>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>>>> Hi Alex, Hi David,
>>>>>>>
>>>>>>> I see David's concern but his suggestion yet wont solve the
>>>>>>> problem, neither the current form , reason :-
>>>>>>>
>>>>>>> The emitted fence count and total submission count are fast
>>>>>>> transients which frequently become 0 in between video decodes
>>>>>>> (between jobs) even with the atomics and locks there can be a
>>>>>>> switch of video power profile, in the current form of patch that
>>>>>>> window is minimized, but still can happen if stress tested. But
>>>>>>> power state of any instance becoming zero
>>>>>> Can you explain how this can happen?  I'm not seeing it.
>>>>> Consider this situation, inst0 and inst1 actively decoding, inst0
>>>>> decode completes, delayed idle work starts.
>>>>> inst0 idle handler can read 0 total fences and 0 total submission
>>>>> count, even if inst1 is actively decoding, that's between the jobs,
>>>>>      - as begin_use increaments vcn.total_submission_cnt and end_use
>>>>> decreaments vcn.total_submission_cnt that can be 0.
>>>>>      - if outstanding fences are cleared and no new emitted fence,
>>>>> between jobs , can be 0.
>>>>>      - both of the above conditions do not mean video decode is
>>>>> complete on inst1, it is actively decoding.
>>>> How can there be active decoding without an outstanding fence?  In
>>>> that case, total_fences (fences from both instances) would be non-0.
>>> I mean on inst1 the job scheduled is already complete, so 0
>>> outstanding fences, newer job is yet to be scheduled
>>>
>>> and commited to ring (inst1) , this doesn't mean decode has stopped
>>> on
>>> inst1 right (I am saying if timing of inst0 idle work coincides with
>>> this),
>>>
>>> Or am I wrong in assuming this ? Can't this ever happen ? Please
>>> correct my understanding here.
>> The flow looks like:
>>
>> begin_use(inst)
>> emit_fence(inst)
>> end_use(inst)
>>
>> ...later
>> fence signals
>> ...later
>> work handler
>>
>> In begin_use we increment the global and per instance submission.
>> This protects the power gating and profile until end_use.  In end use
>> we decrement the submissions because we don't need to protect anything
>> any more as we have the fence that was submitted via the ring.  That
>> fence won't signal until the job is complete.
> Is a next begin_use always guaranteed to be run before current job fence signals ?
>
> if not then both total submission and total fence are zero , example delayed job/packet submissions
>
> from user space, or next job schedule happens after current job fence signals.
>
> if this is never possible then (v3) is perfect.
>
> Regards,
>
> Sathish
>
>> For power gating, we
>> only care about the submission count and fences for that instance, for
>> the profile, we care about submission count and fences all instances.
>> Once the fences have signalled, the outstanding fences will be 0 and
>> there won't be any active work.
>>
>> Alex
>>
>>> Regards,
>>>
>>> Sathish
>>>
>>>> Alex
>>>>
>>>>> Whereas if instances are powered off we are sure idle time is past
>>>>> and it is powered off, no possible way of active video decode, when
>>>>> all instances are off we can safely assume no active decode and
>>>>> global lock protects it against new begin_use on any instance. But
>>>>> the only distant concern is global common locks w.r.t perf, but we
>>>>> are already having a global workprofile mutex , so there shouldn't
>>>>> be any drop in perf, with just one single global lock for all
>>>>> instances.
>>>>>
>>>>> Just sending out a patch with this fix, will leave it to you to
>>>>> decide the right method. If you think outstanding total fences can
>>>>> never be 0 during decode, then your previous version (v3) itself is
>>>>> good, there is no real benefit of splitting the handlers as such.
>>>>>
>>>>> Regards,
>>>>> Sathish
>>>>>> If it is possible, maybe it would be easier to just split the
>>>>>> profile and powergating into separate handlers.  The profile one
>>>>>> would be global and the powergating one would be per instance.
>>>>>> See the attached patches.
>>>>>>
>>>>>> Alex
>>>>>>
>>>>>>> can be a sure shot indication of break in a video decode, the
>>>>>>> mistake in my patch was using per instance mutex, I should have
>>>>>>> used a common global mutex, then that covers the situation David is trying to bring out.
>>>>>>>
>>>>>>> Using one global vcn.pg_lock for idle and begin_use and using
>>>>>>> flags to track power state could help us totally avoid this situation.
>>>>>>>
>>>>>>> Regards,
>>>>>>>
>>>>>>> Sathish
>>>>>>>
>>>>>>> On 8/13/2025 11:46 PM, Wu, David wrote:
>>>>>>>> On 8/13/2025 12:51 PM, Alex Deucher wrote:
>>>>>>>>> On Wed, Aug 13, 2025 at 12:39 PM Wu, David <davidwu2@amd.com> wrote:
>>>>>>>>>> Hi Alex,
>>>>>>>>>>
>>>>>>>>>> The addition of  total_submission_cnt should work - in that it
>>>>>>>>>> is unlikely to have a context switch right after the begin_use().
>>>>>>>>>> The suggestion of moving it inside the lock (which I prefer in
>>>>>>>>>> case someone adds more before the lock and not reviewed
>>>>>>>>>> thoroughly)
>>>>>>>>>>        - up to you to decide.
>>>>>>>>>>
>>>>>>>>>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> David
>>>>>>>>>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
>>>>>>>>>>> If there are multiple instances of the VCN running, we may
>>>>>>>>>>> end up switching the video profile while another instance is
>>>>>>>>>>> active because we only take into account the current
>>>>>>>>>>> instance's submissions.  Look at all outstanding fences for
>>>>>>>>>>> the video profile.
>>>>>>>>>>>
>>>>>>>>>>> v2: drop early exit in begin_use()
>>>>>>>>>>> v3: handle possible race between begin_use() work handler
>>>>>>>>>>>
>>>>>>>>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile
>>>>>>>>>>> handling")
>>>>>>>>>>> Reviewed-by: Sathishkumar S
>>>>>>>>>>> <sathishkumar.sundararaju@amd.com> (v1)
>>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>> ---
>>>>>>>>>>>        drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40
>>>>>>>>>>> ++++++++++++-------------
>>>>>>>>>>>        drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>>>>>>>>>>>        2 files changed, 21 insertions(+), 20 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>> index 9a76e11d1c184..593c1ddf8819b 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>> @@ -415,19 +415,25 @@ static void
>>>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>>>>>>>            struct amdgpu_vcn_inst *vcn_inst =
>>>>>>>>>>>                    container_of(work, struct amdgpu_vcn_inst,
>>>>>>>>>>> idle_work.work);
>>>>>>>>>>>            struct amdgpu_device *adev = vcn_inst->adev;
>>>>>>>>>>> -     unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>>>>> -     unsigned int i = vcn_inst->inst, j;
>>>>>>>>>>> +     unsigned int total_fences = 0,
>>>>>>>>>>> fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>>>>> +     unsigned int i, j;
>>>>>>>>>>>            int r = 0;
>>>>>>>>>>>
>>>>>>>>>>> -     if (adev->vcn.harvest_config & (1 << i))
>>>>>>>>>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
>>>>>>>>>>>                    return;
>>>>>>>>>>>
>>>>>>>>>>> -     for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>>>>>>>>>> -             fence[i] +=
>>>>>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>>>>>>>>>> +     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>>>>> +             struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
>>>>>>>>>>> +
>>>>>>>>>>> +             for (j = 0; j < v->num_enc_rings; ++j)
>>>>>>>>>>> +                     fence[i] +=
>>>>>>>>>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
>>>>>>>>>>> +             fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
>>>>>>>>>>> +             total_fences += fence[i];
>>>>>>>>>>> +     }
>>>>>>>>>>>
>>>>>>>>>>>            /* Only set DPG pause for VCN3 or below, VCN4 and
>>>>>>>>>>> above will be handled by FW */
>>>>>>>>>>>            if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>>>>>>>>>>> -         !adev->vcn.inst[i].using_unified_queue) {
>>>>>>>>>>> +         !vcn_inst->using_unified_queue) {
>>>>>>>>>>>                    struct dpg_pause_state new_state;
>>>>>>>>>>>
>>>>>>>>>>>                    if (fence[i] || @@ -436,18 +442,18 @@
>>>>>>>>>>> static void amdgpu_vcn_idle_work_handler(struct work_struct
>>>>>>>>>>> *work)
>>>>>>>>>>>                    else
>>>>>>>>>>>                            new_state.fw_based =
>>>>>>>>>>> VCN_DPG_STATE__UNPAUSE;
>>>>>>>>>>>
>>>>>>>>>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
>>>>>>>>>>> +             vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
>>>>>>>>>>>            }
>>>>>>>>>>>
>>>>>>>>>>> -     fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>>>>>>>>>>> -     fences += fence[i];
>>>>>>>>>>> -
>>>>>>>>>>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>>>>> +     if (!fence[vcn_inst->inst] &&
>>>>>>>>>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>>>>> +             /* This is specific to this instance */
>>>>>>>>>>>                    mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>                    vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>>>>>>>>>>>                    mutex_unlock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>> -             if (adev->vcn.workload_profile_active) {
>>>>>>>>>>> +             /* This is global and depends on all VCN instances */
>>>>>>>>>>> +             if (adev->vcn.workload_profile_active &&
>>>>>>>>>>> !total_fences &&
>>>>>>>>>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
>>>>>>>>>>>                            r =
>>>>>>>>>>> amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>>>>>>>>> false);
>>>>>>>>>>>                            if (r) @@ -467,16 +473,10 @@ void
>>>>>>>>>>> amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>>>>>>>>>>            int r = 0;
>>>>>>>>>>>
>>>>>>>>>>>            atomic_inc(&vcn_inst->total_submission_cnt);
>>>>>>>>>>> +     atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>>>>> move this addition down inside the mutex lock
>>>>>>>>>>> cancel_delayed_work_sync(&vcn_inst->idle_work);
>>>>>>>>>>>
>>>>>>>>>>> -     /* We can safely return early here because we've cancelled the
>>>>>>>>>>> -      * the delayed work so there is no one else to set it to false
>>>>>>>>>>> -      * and we don't care if someone else sets it to true.
>>>>>>>>>>> -      */
>>>>>>>>>>> -     if (adev->vcn.workload_profile_active)
>>>>>>>>>>> -             goto pg_lock;
>>>>>>>>>>> -
>>>>>>>>>>>            mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>> move to here:
>>>>>>>>>> atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>>>>> I think this should work for multiple instances.
>>>>>>>>> Why does this need to be protected by the mutex?
>>>>>>>> hmm.. OK - no need and it is actually better before the mutex.
>>>>>>>> David
>>>>>>>>> Alex
>>>>>>>>>
>>>>>>>>>> David
>>>>>>>>>>>            if (!adev->vcn.workload_profile_active) {
>>>>>>>>>>>                    r = amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>>>>>>>>> @@ -487,7 +487,6 @@ void amdgpu_vcn_ring_begin_use(struct
>>>>>>>>>>> amdgpu_ring *ring)
>>>>>>>>>>>            }
>>>>>>>>>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>>
>>>>>>>>>>> -pg_lock:
>>>>>>>>>>>            mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>            vcn_inst->set_pg_state(vcn_inst,
>>>>>>>>>>> AMD_PG_STATE_UNGATE);
>>>>>>>>>>>
>>>>>>>>>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct
>>>>>>>>>>> amdgpu_ring
>>>>>>>>>>> *ring)
>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission
>>>>>>>>>>> _cnt);
>>>>>>>>>>>
>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_c
>>>>>>>>>>> nt);
>>>>>>>>>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
>>>>>>>>>>>
>>>>>>>>>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
>>>>>>>>>>>                                  VCN_IDLE_TIMEOUT); diff --git
>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
>>>>>>>>>>>
>>>>>>>>>>>            uint16_t inst_mask;
>>>>>>>>>>>            uint8_t num_inst_per_aid;
>>>>>>>>>>> +     atomic_t                total_submission_cnt;
>>>>>>>>>>>
>>>>>>>>>>>            /* IP reg dump */
>>>>>>>>>>>            uint32_t                *ip_dump;
