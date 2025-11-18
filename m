Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09683CED24B
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 09:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C53810E46F;
	Tue, 18 Nov 2025 09:31:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZcqY7sca";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4A6A10E45E
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 09:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5BT8JlAuwDyjCfGpOBo2WgNKzq4nBSzM5h+15yhSSId0miDlh+vHtbIOqxx603bdLFKvqgJFm3+S3HYyXazSymJh2qKpxtWX/iyoy+EDUJJh+th944yIalTbyd9YuJhMfe03Uj8IrYgbw0CzLeTKJgt0jwzMA24+5pEUerVGNx4L2gZBbhsmAGchwva4jN2nVhSTkkKtUJeEF9S6ply/L9GFh6ZAfgnS7gkqoGxj9vqjPF/NcsAqH9H6vRkBj9TmsBo3obP7khaXilqKx9mzEOicF/UX7hDJPOp76GpG6lJ+2uTaiqNXPevrEo12/HGa5QXDf1m7drQlWjlQcwynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+VcnhlHhbdgrbWyxxFYaQPsu4Jo0HeFuoNUx+jV0E4=;
 b=zDv3DOyQWaFbfAfsr9yO3F3QZ8J1sjAywfbT6yAOkSU5KvZE4NnPNp9x2QjJnxm5P/j8LHIQi5n5clJUwWXIin7R9kTJuflCPOqyOwjfVpsVGtN+Hef6CnX7CfeScIGskz1l181SjB8o5M1BK+6XxiA1/x+gTHDVMgBMX/ujlRgcvIiUTFf7P2pO6P+aVOFTohpq+CEk5AX7bKrMr2PEVDMigWR4av7SqgloE6r06DcEtI3fvBI1prH42PUNogteazvb82sQ1YcerfkndPp5+BXI13nSXA5+8LP4rLtvlOYSrqCUx9qcB7hS9tZwL0XL14C5JkjD3PyBB2LwOJCKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+VcnhlHhbdgrbWyxxFYaQPsu4Jo0HeFuoNUx+jV0E4=;
 b=ZcqY7scagc3TIzinkUdpva5Mx2NHh/QWZUmmdUZdvBjqL/no4AyAxzLM8mfgH1JXozxpKvEUt1Gws7gr0nwsmSq3/bqsw0Mm1Bovfc/2F7+xFG7siw9yUX9IkwdS2KqJMKjk0Pxj86l1pIUS5n6iCIBXjocey0PG+NwQHHj0Lxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 09:31:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 09:31:16 +0000
Message-ID: <b6c09fdc-168c-4489-9a20-d20c472b16ff@amd.com>
Date: Tue, 18 Nov 2025 10:31:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds timeout
 is not enough for sdma job
To: "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Chen, Horace" <Horace.Chen@amd.com>
References: <20251117065323.3435034-1-chongli2@amd.com>
 <cde95388-b48c-4310-b5e5-bcff56a31744@amd.com>
 <DS7PR12MB576863BD7C14E3671B31EC0E9BD6A@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB576863BD7C14E3671B31EC0E9BD6A@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: d6209bc2-786f-47ce-609f-08de268538f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3E1c2ZPTzQ3MWxlTi8weC9hVHltcG5LeG9qYVpCcSt2Yy9jc3o2YkFLWkRD?=
 =?utf-8?B?UWJCTzhzdTNGeWNXZEdpT096Rmlrc3FhSlBmZzZaanFRc3lma3l6eFJVcGdP?=
 =?utf-8?B?Rm5SazZEdG1ibDlXMFh5bVlLUmROOTFzREJUVW1RcVhsNVhRYzllc01yUThE?=
 =?utf-8?B?T0xaenQ4ZnU0OE85QzlqdGRtZk1wMUZ6dXEreEtwSlVGOG1FelBkL3RoWGor?=
 =?utf-8?B?TVMxZE9ESDhLdmk2V0xPWk1ETXVQbkM5S1RqTmIvdldKMTJPbDNWV2Voc3d2?=
 =?utf-8?B?S0dxS0NqTUZTRXptYWdoZ3ZmVW0xaXRZSXdnbW1BYmlxWEp2SjBPZklsVWcy?=
 =?utf-8?B?eW5GVEYwT2dMaWNlNGJFVVg2Q3R1NkdhOHErcmtWbWIxUXMrTU9oWlpyOWZ1?=
 =?utf-8?B?U1dDVlg5MGRwTTMvVTFnMDkwcTZDRU1qcEgveUN4YXN4V3FPeHd4VjZYNk04?=
 =?utf-8?B?TG9odnZvYkZzWkN1RUFkUm1CY25yUXBPcHdDTHhlYWNpZW1zMWZxUVBlUVk1?=
 =?utf-8?B?R3NrVkxyYzJ6K3c3N0JUdEtGVmhLOVpLTUswUVRBZ3gwNE83NFQvbm5XRzVo?=
 =?utf-8?B?WmRhbzIxQzVFOVB2Qm1jOVpCYmRkZmlsU0Zqb2kwcDRNMnJDd2dzNlp1Rjh3?=
 =?utf-8?B?UWE2NmxEbGszckFJVGN6Q2M1QjRSZ3VQeEs5ZFVGVllIY1RvMXUyYndHS20z?=
 =?utf-8?B?RGZxakpLRmtiNWx4ZW9yZ3R1MFVYQ1I2MXREdFRjSnVJQ0R4ZENKeDVYZmFm?=
 =?utf-8?B?RkExbnFIOUxHZTNpWjBybW5kM2ZYRWpEVEg4MjFkVGxkamtnSEo2d2lYODVH?=
 =?utf-8?B?RFZCTmRRSWR6WFdaVmNMN28zVllrL3Zydzh4MUdLdGdFalhBSXA1QWdmdzVp?=
 =?utf-8?B?d3ZCR1I4MEpGaTZUY0lEZW90UHJPaG1Za2pqdmJkSHFRY3ZCYzJ2czdVeVFu?=
 =?utf-8?B?OEtYRlFrcVpsMDlYK1RCMzFqWjRqcFlHUEo3Mjc2UHl6RjBvVTlXMTJUSzZW?=
 =?utf-8?B?VDJBSHA1c1VnaWpiT3NkMkMxSEJHdHJ3SG5Mcno1VDNTS1BGZGxLaGUzVWNB?=
 =?utf-8?B?eWhxUG4rVjhZcno2V01PZkJ2Zm5qaDltZldPZURsT0ViekJtU2FYTXA1N1A2?=
 =?utf-8?B?U3QwZzI4NEwrSEw4c3hrb3hmNWFaazYvZHVwNkt2VU16NUpTeVIrdnJvNHlP?=
 =?utf-8?B?YW5acDgxOTN4ZXN2aGNEYmJjSzRodEUralBYU01QRWIxRlE5NHRQcWNnL2k2?=
 =?utf-8?B?U0d1VnFUSnVlZE1NUHlkaHZ2bHU5NFRCRVdxYnVZWXNmYmZjeXpkQzM3dEcx?=
 =?utf-8?B?OTRmVjJmODVHUVo1V1RoelVvQWZRMWoreGhqcmRYWCtmZlRqc3hsdGc1Z05V?=
 =?utf-8?B?NVA3NURqeEdFaVFPZ2J4b3ozMW1nTGd1ZkU4S3p1R2VpejVUTWVZWDRZQzFX?=
 =?utf-8?B?MU5qeFdVSkI4R2R0N0VNNEx5V1QrcngvVVBHYXdUOGxKUVpTbUtyRk1FYy9O?=
 =?utf-8?B?VXJ0V0xic2ltaEIvSG9kbDNPV2duVVZXeEhiVnlySytBRlhoT1UxaWR4TWh4?=
 =?utf-8?B?dTBDQm96NXpSUHp1RmxyTFZWQlRvcjlURzNGa0x0RFUzWGFCdElBYnFIM0pR?=
 =?utf-8?B?WEtaakd2ZUZ1RU15NWcwbWRTTjlSWGJmMUk3cy9kWkd0V1UwaDV2bnlGU2VU?=
 =?utf-8?B?dmlweDFqSk1sZ0RXT21sTXRxdzNJckZlMlV4UDZzVExScENpTmhRVEkwK1g1?=
 =?utf-8?B?enR4Y2dkaE1RYmg0dkQ5eEwrYy9sZmoveEVBQ09PYStaUStiVWR5bitzd29W?=
 =?utf-8?B?bHRLV1dHcDNLSUtpZHJvRTl1STd0NFNTdEswY3c1MUg3YUIwdDRBdE55Unlm?=
 =?utf-8?B?bzdFMTI2a1V5cUo0RFlDZUdQSVRIQ1Y1dGFqWnRBcHZ1THVhWUhFTGNiemtJ?=
 =?utf-8?Q?vbJfpUoh8gGp1vCtWuj9QF2ClujBANSd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUZtb0h5MElTUVZ1YWZtOXdZOFFKK1R2U3ZiZ0VZZGFtMWVONTZ4aURENkRr?=
 =?utf-8?B?SjlPSDdNUlBWeDRTejlJcWw0ZDI5Z1VPL1JadExleGgwNVRXQVRVeU5LNWw3?=
 =?utf-8?B?ZEJSZzlYSkR0ZnNCdzZYdERKdnBLcms2K29vckI5ZmdTMG1pUDNDYlZ4aFdk?=
 =?utf-8?B?VXRvQ2NjcG1yWHBPTlVudExrR2l2TjBka3RNRHhXOFUzek1pOTQxbCtBMlY5?=
 =?utf-8?B?VDJaVzZ0OVpnRWFDUXJXMUMwVEtvbGJETTFuVkQ3N1dsL3BZK1F3UGFUcTV4?=
 =?utf-8?B?Y3Z1VUdNZU1FaXZhbm9meElEcWZwYkpmYVdSN0VsYUkyNmNtaUFLNm1IelVO?=
 =?utf-8?B?bkZPSVMydjNuUVF6eHdlaFBVQTg0R21mR01lSUpxRzdNR09jMTJCdE1EZFkw?=
 =?utf-8?B?TU44a3BZSC8zaHJaMlhsWkZoc1V6bDVmNEl3OVZ3T1pVN1d4RmMrakN2bGJ1?=
 =?utf-8?B?eXd2Wlo5UE5LbUFDeS84Nmo2Y0JoZmQvTHpYd2k4dHd4SGhXSUlSUDhmSjBG?=
 =?utf-8?B?cHVDcEM1R1dBSTFzMllZMmVZM0locDhaWjlCTW9VWDBROGRvNmo2VzQyckMw?=
 =?utf-8?B?emJBMkVLY1I2cTZ0akhIWUlQVkJSOVZQK1NWSWFPZzF5VFFpNUdyRVJGYmV2?=
 =?utf-8?B?eUtyclVYSW1SdnU4ZlU5enlRaTBEcG5lSVZBRzRUMFNldm9qVTFRYTltWGdM?=
 =?utf-8?B?cnllbFE5OXI4eGdkWkZQRlRLU2NxbEpvbTVvd0tTOG5yVWd0bjEwTGpQbXpN?=
 =?utf-8?B?aGt2Uk1TK3NkbWdVL1RsSHJZSlJPbGNkdGxCelFrblhTamE0dGlHQjhka09L?=
 =?utf-8?B?dnlYZ2FyYlY0bWkxTWRiODNYYXFZZmowTkpERHozbGdrOFlFVXBOeGZnc3lY?=
 =?utf-8?B?L1kvZUpIVjMra1dnUmhjTTJDYjE1T3hjb0pKMWNCaitJWWFQd0RldHVSaDAw?=
 =?utf-8?B?SWkzQTFiM3RZc0RpT014aU82VTVXV1VHYll6bHVLSkJkSlRWT0N2SUo4YTJK?=
 =?utf-8?B?Y0s2ZUdCK1dCOHMzWmx1YitsZ2pnZGlZTU5xRjZJRkY2Y0NVaS9ZNHJxZ0tp?=
 =?utf-8?B?NXQ0cTlXVnE2b3hVNDV3Y2g4aC8xcnUzeHh2MGZCNi9EOThwZ3VJTDhXTWpR?=
 =?utf-8?B?RG1RSHJQWFR0UFpObTFLR0svWmhDSUp6c1lzZU5kUkVUK0IzUnZMRytodjRr?=
 =?utf-8?B?NUsxdFNWcWpsd2Zza0hEQWFnQU5YbUpXS3NCTitxS2RsZ05QR2tNbjNMKzR3?=
 =?utf-8?B?NGZ0NjBkK1c1UDZaSVlGbGMxelZDdlh5djhGNHdnWmRGSVR1YURPNmdrK2RU?=
 =?utf-8?B?cjFoM2hDOVg3Nk5pV21ldk1EUmZGbElWb0wvYjh5Y3F0RGpsdjJLcm1Oc1RP?=
 =?utf-8?B?eWxad2laMTB6ajVrdEtNTnoxckJoTmlxRmcyaHNRcm9HbndFVVlNRlEvcmVV?=
 =?utf-8?B?cC9tQ2FKaTV6YVh5eHM0cHVhQWVLeUhndlNFbVRaaTFRTm9kdGN6eTVxbEZm?=
 =?utf-8?B?YlozZWtKY2lodUxGRXI1ZjZKZmZXcmFJUUZ5d1FhUVgwYWxBMzRJY3g4U3lj?=
 =?utf-8?B?SEpycVRmTUV4bnNhaFZ1Y0EwbWlLMGJXUkZFSU5lcEhSQkUzL3A2d3hOelpJ?=
 =?utf-8?B?amQwL1VPbzl6dWkxUzE1ckVpZTJ6ZDJhcVF4cDV1ck41TUNnRkVjdDQzaUs3?=
 =?utf-8?B?eHFodXpLOVlsKzdGeG4xenNra3k0RmRwMktsY1A2TEV0L2JWdzZ2b3JDUWRP?=
 =?utf-8?B?d0tGam9EWVBRRVQ4Y2QzdDUrVmxIMmtEME50MmpsUFVkR0daRGFiL21GSEZX?=
 =?utf-8?B?TWozR3FtMlJnWlR5Qk9veFFiK1NPTmoreTI0MUcraUZ3c21uZk83TG8rMzVr?=
 =?utf-8?B?YUoraytCaVRSMVlHQi9SdzZKYjIyd0R2dTJqanNaaVY0NE9EM2xNMFBMa2Q0?=
 =?utf-8?B?a1FJWURDeVFQeWVSU3JOcUNGam4xR0Q4cWM5RU9saG45cC84dVV3Q0wzWWg1?=
 =?utf-8?B?K05zVUlPUWlab0J3akV4ODNwZnFmZERHMzJKd1VSTFhqWFhrcjQxT0hNa1BZ?=
 =?utf-8?B?S1poa0JiRzk0N21pNVpmUDhUMHRBUFExNWVHTE1mRVdiQXlSOFNzcGVCVzg1?=
 =?utf-8?Q?SSB5xsM8le4ByoP+aO4gZ0viD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6209bc2-786f-47ce-609f-08de268538f0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 09:31:16.2409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWEd2p5cbq/iOYeIcrHQ7a/XR3cP3qiL9EfU5wxOSCnv9xsYTRqBcnh+02IjADt0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505
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

Hi Chong,

that is not a valid justification.

What customer requirement is causing this SDMA timeout?

When it is just your CI system then change the CI system.

As long as you can't come up with a customer requirement this change is rejected.

Regards,
Christian.

On 11/18/25 10:29, Li, Chong(Alan) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi, Christian.
> 
> In multiple vf mode( in our CI environment the vf number is 4), the timeout value is shared across all vfs.
> After timeout value change to 2s, each vf only get 0.5s, cause sdma ring timeout and trigger gpu reset.
> 
> 
> Thanks,
> Chong.
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Tuesday, November 18, 2025 4:34 PM
> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds timeout is not enough for sdma job
> 
> Clear NAK to this patch.
> 
> It is explicitely requested by customers that we only have a 2 second timeout.
> 
> So you need a very good explanation to have that changed for SRIOV.
> 
> Regards,
> Christian.
> 
> On 11/17/25 07:53, chong li wrote:
>> Signed-off-by: chong li <chongli2@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++--
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
>>  2 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 69c29f47212d..4ab755eb5ec1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4341,10 +4341,15 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>>       int index = 0;
>>       long timeout;
>>       int ret = 0;
>> +     long timeout_default;
>>
>> -     /* By default timeout for all queues is 2 sec */
>> +     if (amdgpu_sriov_vf(adev))
>> +             timeout_default = msecs_to_jiffies(10000);
>> +     else
>> +             timeout_default = msecs_to_jiffies(2000);
>> +     /* By default timeout for all queues is 10 sec in sriov, 2 sec not in sriov*/
>>       adev->gfx_timeout = adev->compute_timeout = adev->sdma_timeout =
>> -             adev->video_timeout = msecs_to_jiffies(2000);
>> +             adev->video_timeout = timeout_default;
>>
>>       if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
>>               return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index f508c1a9fa2c..43bdd6c1bec2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -358,10 +358,10 @@ module_param_named(svm_default_granularity, amdgpu_svm_default_granularity, uint
>>   * [GFX,Compute,SDMA,Video] to set individual timeouts.
>>   * Negative values mean infinity.
>>   *
>> - * By default(with no lockup_timeout settings), the timeout for all queues is 2000.
>> + * By default(with no lockup_timeout settings), the timeout for all queues is 10000 in sriov, 2000 not in sriov.
>>   */
>>  MODULE_PARM_DESC(lockup_timeout,
>> -              "GPU lockup timeout in ms (default: 2000. 0: keep default value. negative: infinity timeout), format: [single value for all] or [GFX,Compute,SDMA,Video].");
>> +              "GPU lockup timeout in ms (default: 10000 in sriov, 2000 not in sriov. 0: keep default value. negative: infinity timeout), format: [single value for all] or [GFX,Compute,SDMA,Video].");
>>  module_param_string(lockup_timeout, amdgpu_lockup_timeout,
>>                   sizeof(amdgpu_lockup_timeout), 0444);
>>
> 

