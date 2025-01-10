Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B625E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 17:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E6410F14D;
	Fri, 10 Jan 2025 17:33:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zH0lJow9";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54D2F10E50C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 17:33:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qawZcNqmTH0zI/ca2WAv5WRVGiGZOXfaFinB/HMukmkfPS6poTDdQQ2ok9InUAIU/UjO6Ts52NJ7BO/jgasFTk4Bb+p8AEbJgYV53kKU/rnK191Uy7YnYQ3LdXnPtia+WWJHo906UPF7vnMNmq5qjS2M7NcwpxyY82Pt0X0iXkrPbAO54FlNTq/qBE/5PdIEfhWJ22sN0xTfjCkFLva9GwKt/+7yJ/8vUBIFmZaIeZJVjzEgheBawbQ1zZa9Goe1xIbYv464TXScxUKKyJ6ronj56JG0XYU5vi1RnN6AvOdWOIoEoVr9nZA3V7TueDbHfJoXxUTk0qRFLxmjKFbsvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmmDCU4Utw3T05JlQ820R4hlbXZzdiRoE4HY8/d0ipU=;
 b=i2wKxEDFx5S/e2QUuyLNaWmEUC86wCaNRd7ZAXhIsbpJAQKEYyjrNSsAwmKQtlY8F5s7TgduIjAcEtUeCd2qcYkKBnv0THPs+ZG8SW5JI7Ldm773Q5BWl5xGrHIR2VJOsLZOtJek24H3Y3tXg9ksyJ1xcHn8DFRAhd66fTnGUAQ3Ekqj645ORJuCxP9MwSpiCQXHpc8xzWWViANITdC1X8W56BYVgYCuLZBiN/RC8yi2hVd9Hjn0oAt/UdJG8HXTtspzYciJJe21PhzxGuwULrTBeWUPMwdbgApmkgnfyiDKOYeP1NSycTSSgg+NYhXvs4us3R2fPlwCfFZfIbVLXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmmDCU4Utw3T05JlQ820R4hlbXZzdiRoE4HY8/d0ipU=;
 b=zH0lJow9B71WapOiL7KI32eakhhV97I4H2VMD5hTGGxhhnYVFMPT9lmhPQJGzuYmnwEuS14Uouidu//iSkSjz1delEhmWrYaadWrpvhmARfxQH6ulKL7NAa0fAgv8jJMoyeGxGLh/y+8Aq1iiwKRa5wi+ka3nHY3Gi1qFIXwYB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH3PR12MB9341.namprd12.prod.outlook.com (2603:10b6:610:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 17:33:21 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%3]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 17:33:20 +0000
Message-ID: <bd1da61b-0f84-eba0-4a4c-9124429c4eac@amd.com>
Date: Fri, 10 Jan 2025 12:33:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4] drm/amdkfd: Fix partial migrate issue
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, Emily Deng
 <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250110074924.1441364-1-Emily.Deng@amd.com>
 <28f8397b-0f2a-4738-22e6-734abc21f0a9@amd.com>
 <7fba9b16-4bb7-44c2-bc7e-d455024ce2b7@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <7fba9b16-4bb7-44c2-bc7e-d455024ce2b7@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::14) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH3PR12MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0b0043-4ac9-4220-81ea-08dd319ce06a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RisrUzFzQy9vZWdFeU96UzJaM2JpSUVIZ3AxTFl0UDYza1UvaVZWVnAxVEtX?=
 =?utf-8?B?U1hFcFYyaGVmalpZVlI5N0h3eE9CZlUwRFl2QWNXV2JFQ2FWa2Y1SWN3RTZt?=
 =?utf-8?B?bWhXMzNKejhocHl1Y3Y3R1krYWllcm9walJmNjZnbDNhNVR2MUxIN2xCdEw4?=
 =?utf-8?B?VGdBc1hjd2s4aHdtWkxGZTJjaURMZlhMeG1FcjQvajI1OXZzRmRMNjF1Qm9s?=
 =?utf-8?B?WDFMdHBkUWdVT05lWU9wNWR4SnEwWFFHK1dTVC96WS8wRmpISExBVndpZ2NJ?=
 =?utf-8?B?M1hyR0tpdmIvWTRDQmZLOTdwc0hidFlqc1ROUmRiS2gzZzBnWVVtTzlhYUFp?=
 =?utf-8?B?TWJUMnNpWFdCOGlhU2ZvaGdhaE41L3Uxa29rQjEwdS9DZFRsbXhGQ3hVbjV1?=
 =?utf-8?B?bWRXV2ZXSzFPNWRQZkFsL3VsK2pvTG9QSkRHY0lvT1JvYkx3UjBqdnFCRzdu?=
 =?utf-8?B?NzJuR1VscWdLaHpKUmVXcW5qQTFTZnVRQmtrYUl6UGpWeTdXUDFEYUYrMCtm?=
 =?utf-8?B?VFQzaHhTenNoL2tFcmp1UHo0T1p5ZFdOa3VMK3hOL0dRUWFhdlkyOTI4NWRa?=
 =?utf-8?B?djJaYmV1eHRXbkRBUHdId2E1dzdZWEE2UGZ3RWNVQ2tvT1ZWQWt4M3JsMlM0?=
 =?utf-8?B?N2k4dUJTZHl6Y1U2amVEYWtrcXhETlhHMktIaVd2VmdWUlBMbGg1Wm1welZh?=
 =?utf-8?B?T1NPeFRMOCtxUDYzckIyYzl6OGh0Z21oSWVLVDhHYU1EQ0VYQnhjek1TTDFl?=
 =?utf-8?B?RGZXOVFzRlUwakVxUkpRdFNNbmdZWHVjdFRFdWRkV0tZdndLaG1aYkxEcXlN?=
 =?utf-8?B?K2lndklrWFNiVEplbDVGRjFrdjM2TjM5SnpYdjY3cXFDMWlEYy9KWnRDbE5F?=
 =?utf-8?B?UTZGelRMdzJnN2x3aU8xc3ExZmdZb1J0MFdOV1N3aUNMVmJSc3VGa0Jna0JD?=
 =?utf-8?B?U1JIeFh0S0VKKzhlTzNWRGhCVnBvQzB2QWlUTXJzVHlRZllyNUI3UTZjdzkw?=
 =?utf-8?B?WlRDNExGNzJHdzlic2w3bEdXS1kwNW54bzNxZzZ2R0VES3JuR1l4cm9XUzhp?=
 =?utf-8?B?cmxVTGhqckdneStvcVFJcEJkZDMvM0VKNFVSOVdLZjZ1Y0ZNQU16RW04MStD?=
 =?utf-8?B?ZXVjVnRqRThTdHUvU1E5ZFdtQ3M4bWNCdDVSU2FmVUcxM1J4TGNxSjJxdkFP?=
 =?utf-8?B?bUZIa1Y5c0RaWFYxam9NQ3VxdTBrbTFZendPOFlGQ0VvdEMwSG5TV1FFbkFW?=
 =?utf-8?B?UCtkbHU3b1djQjBzeVd3RHBXQ2ZBWTVVOEdhc0huNHN5bWJGblVpSUZiQ1pL?=
 =?utf-8?B?V09Xd3kzcFl4ZVozejl5U0lPL0hndjhVK0JTeVhDTlhpV0YzK21CUkQ3SnAw?=
 =?utf-8?B?azRWdmtuVHBVUFhsT2pXcVJtZTB2c1MrV0VuMElIczVUZGgxdU9TK1hOaEp5?=
 =?utf-8?B?VmRndFJhQlNub1MzWjBBL0F1cm05RG1oa2hOSHJRRHNOOFVtd09OSWF1clhz?=
 =?utf-8?B?dXNzMjBNcFMrcTlnN1VSUTFUa21XRXBqWmdpOU1URmVsNVBZS3hGbnhaNlRn?=
 =?utf-8?B?SmlMWlliUGZ6NlFaeVBmZVgwVVJZSVFNM0RNckRhd3FwZE40V01GUkpHczV3?=
 =?utf-8?B?SWVXUHNMRGZtQ0xNWXM3ampvL0RNU1BJTEJudXBzeVB2c2VHZ3NzL3VUdk9E?=
 =?utf-8?B?aHoxcXJJY3MvTkVGYmJXTC9icWdGYWQzeGhnTlZwZHhzZnloQXRuTUkrZFZu?=
 =?utf-8?B?SnV2L1JDak03bDMzekpheGxFVmJIY0UzYWJ3UVBISGhKclJtam1oblhEVTBr?=
 =?utf-8?B?MWdibU1YdzFEL0Z5OXN4a2lOV21WcEhQZnFMSnMyd3JSaHE4QlBKb3hQamxo?=
 =?utf-8?Q?aLib3mW55e3/E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXhMcE5NbkNiY05taVl5eHBueXdJY2wybHdQYTZ1ZFFIRzI4UTFlSDlZbWR6?=
 =?utf-8?B?Y21iM2YrUWlJTHZtVGJwWXgweE9QR0laRk83b2RpQ3NkYzZyMVBpNDNJVmZp?=
 =?utf-8?B?SGROL1pCbEs5dFFjZFRvdmhoUkhqS1hFK2txR3o0ZjhySFIyNEg5SDVJUUhl?=
 =?utf-8?B?NUh0ZkhweEZyYnZyVk9obkM5Q1lic044MW4rSG1SNGJpY3dGUm4zTlQ5enkx?=
 =?utf-8?B?QnhmRjI3dWFpV0RLT3BxQVJyeWtxcXk2Z0lBeW1EL21sVXRFYkF5NWduaEZG?=
 =?utf-8?B?L1BHWWR2ZW8zeU0vdDBhS1dwWGdJNHp0blNxY3c5T2FjU2JhdUlqSXZjV21r?=
 =?utf-8?B?a291L1Q1TnRkRGxWMUJ5bU05OTJVTTI5VzQvSnc0M1VYclZSdlFmbkk1c3k3?=
 =?utf-8?B?Y0kvajdWS2NRdGNKZXNwcDkyS0ZQTFlJdW5zQnBDMVlTdXU3K2dLSHozd2Vu?=
 =?utf-8?B?dkpLZWVlcS9KUkNRd2s4eTdqK1l5UkxkT3BWWGwyajlOMUZvajZkMGd2QVky?=
 =?utf-8?B?Tjk5VlNlR2hmbXU1c2kyL2MwMUgrSEVldTBNNUJJWjFJblNLOGZsRUhlTk1o?=
 =?utf-8?B?ZEN1ZUgzSTBSbWtWSHZHYVpOV1k4REJvK1FRRmppdlB6VU81Yk5tUWR6RlIz?=
 =?utf-8?B?enk4QVNHb2VyaWZQRWE5OXNGdTQrZXY1YWpMdTNSd3hvZlJuTE81aUVBc0JY?=
 =?utf-8?B?NmpkeXlJeVNaY2xLcE1OOWFXWUVTc2crampLeGJHNWVlVTZ0Wk9oVERrSXpW?=
 =?utf-8?B?d0JzcTdBYmpreW5CZGd1a0w0OGF1NENnc01tck1LTit6djlGSGtPTURwUTlD?=
 =?utf-8?B?M3YyVzN2WS9hYlp2bUNTQnZsbjMwclA3QXBqcUZzQmVjV0RiNDJvNEdQbWht?=
 =?utf-8?B?RHp4QnVCRGlFdE82aFRMRSs3dzN5bGs1ZkdGdkJ3NnUzQXRvNkRmdFQrRGFu?=
 =?utf-8?B?NE85RDFPMng5VlE5dnoxdmNMMnNCaThOY1VlcFVHNTFPZEdKbFpoQTlOUG9G?=
 =?utf-8?B?RnFHcVp2RGwxSWVFaXVUMjl6Sk5GNFhhQjE5VEdTOXhiZkQ5V0pIamE2OTZo?=
 =?utf-8?B?VlQwVjJQNk1jMys4cEZCR05INGVCVDlrLzZ0dFIwdUZXbkhmNHFBMEo3OVZJ?=
 =?utf-8?B?S09Ja1QrNWdNRDU1YkFzekk1WmUwN1Rpa1FSVWtWVUc3RkV3VXYrTytEM2pX?=
 =?utf-8?B?S2RCZjNFSHNFV2NueWIxdVhuY28zMFE0bFc4N1kxSWZKdE5XTnZ1ajg4T1Va?=
 =?utf-8?B?SHNZVDFHR01TT0R6dTRWZWFoT2hwU2NFYVdnd3lpZGV0cGRuclpDOTB2L3I0?=
 =?utf-8?B?blBBeW8wU0I3akt0T0tFM1NtVFc3eGRBdFdHV3V6UUkzRTd4OTNaR1NXVFRn?=
 =?utf-8?B?VjRoMFF5S2RkK05DVjhnKzVvZlppeVBsTVFHR3owUGQvYUFjT0V2MlBlY3RQ?=
 =?utf-8?B?cEFDK2M4aGdNQmRBZ21qZ3VtVGx1UG53OEg1T2xlTkhCUkJQTHNSMUVxMVRH?=
 =?utf-8?B?Um5mZGRlY1E0K2w0bmhhMkE2L1BUNGx2NkQ0TUxLem1wUE1wcGNlT3ptUmVx?=
 =?utf-8?B?TzhoMGVwKzJkcWhsWGdaVVNiNjZSVzYvSFpxcFpXQVFmQ2xCamd6aHdlcHJU?=
 =?utf-8?B?UUJ6dWxISDhIQm1uaG9ldWljaE5ZWk9oMFlwZDB5SDI5YUpRM0tRRTVCNEVn?=
 =?utf-8?B?Y3ZwMzBqb0JGSkFQWUw3TU12UFZnZ2RqUjVDNVkzWGIvS0pPVHB1NG05Kzda?=
 =?utf-8?B?U2tBUUdMMDNzYndrc2FXdHBLYVAwcFdqdVhta0lURjZpbDcwZVdYMnZNNWZW?=
 =?utf-8?B?UWJlVDd6ZktSN0lxa1RpTEhnQktrYmJkSmYzRU5mV0pUa01hdWUrc3VKM29V?=
 =?utf-8?B?TkNDdUFBTFRsck85SEx0T0tDcWFxMkhtZmtsTkNjZ2VZenUzS0s5b3Mwbnhz?=
 =?utf-8?B?TXhicHJPdFNSQ3J4dG1rVnp5WE9jVWx1YlpUZ3FaaENBZG8vYmVQUVJNN3RW?=
 =?utf-8?B?TkEzZXdrS2tHSmx2UHNST0EvQ0d0aHlOdDRLYXhJSkFEWlcxSkdCMTJuRVFy?=
 =?utf-8?B?OFRMdDBxVUY5bndhU3pyV29mcDEzbTZXZU1FODJLWlIxZmE5Q0xWWFhFUXBn?=
 =?utf-8?Q?FdJV/pUnzLbr3NKwKsOtPZT1H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0b0043-4ac9-4220-81ea-08dd319ce06a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 17:33:20.8853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfO1E6SBmftmxFqA/hkIazBDp9UGBtpA864KlrfaiKydK3mJCx0fvbBpGEsEo5Db
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9341
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-10 11:23, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:7fba9b16-4bb7-44c2-bc7e-d455024ce2b7@amd.com">
      <br>
      On 1/10/2025 8:37 AM, Philip Yang wrote:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2025-01-10 02:49, Emily Deng wrote:
        <br>
        <blockquote type="cite">For partial migrate from ram to vram,
          the migrate-&gt;cpages is not
          <br>
          equal to migrate-&gt;npages, should use migrate-&gt;npages to
          check all needed
          <br>
          migrate pages which could be copied or not.
          <br>
          <br>
          And only need to set those pages could be migrated to
          migrate-&gt;dst[i], or
          <br>
          the migrate_vma_pages will migrate the wrong pages based on
          the migrate-&gt;dst[i].
          <br>
          <br>
          v2:
          <br>
          Add mpages to break the loop earlier.
          <br>
          <br>
          v3:
          <br>
          Uses MIGRATE_PFN_MIGRATE to identify whether page could be
          migrated.
          <br>
        </blockquote>
        <br>
        The error handling need below change, with that fixed, this
        patch is
        <br>
        <br>
        Reviewed-by: Philip Yang<a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        <br>
        <blockquote type="cite">Signed-off-by: Emily
          Deng<a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>
          <br>
          ---
          <br>
          &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 17
          ++++++++++-------
          <br>
          &nbsp; 1 file changed, 10 insertions(+), 7 deletions(-)
          <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
          <br>
          index 4b275937d05e..bfaccabeb3a0 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
          <br>
          @@ -278,10 +278,11 @@ svm_migrate_copy_to_vram(struct kfd_node
          *node, struct svm_range *prange,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct migrate_vma *migrate, struct dma_fence
          **mfence,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *scratch, uint64_t ttm_res_offset)
          <br>
          &nbsp; {
          <br>
          -&nbsp;&nbsp;&nbsp; uint64_t npages = migrate-&gt;cpages;
          <br>
          +&nbsp;&nbsp;&nbsp; uint64_t npages = migrate-&gt;npages;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = node-&gt;adev;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *dev = adev-&gt;dev;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_res_cursor cursor;
          <br>
          +&nbsp;&nbsp;&nbsp; uint64_t mpages = 0;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *src;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *dst;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t i, j;
          <br>
          @@ -295,14 +296,16 @@ svm_migrate_copy_to_vram(struct kfd_node
          *node, struct svm_range *prange,
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_first(prange-&gt;ttm_res, ttm_res_offset,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; npages &lt;&lt; PAGE_SHIFT, &amp;cursor);
          <br>
          -&nbsp;&nbsp;&nbsp; for (i = j = 0; i &lt; npages; i++) {
          <br>
          +&nbsp;&nbsp;&nbsp; for (i = j = 0; (i &lt; npages) &amp;&amp; (mpages &lt;
          migrate-&gt;cpages); i++) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct page *spage;
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev,
          dst[i]);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_get_vram_page(prange,
          migrate-&gt;dst[i]);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
          <br>
          -
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
          svm_migrate_addr_to_pfn(adev, dst[i]);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_get_vram_page(prange,
          migrate-&gt;dst[i]);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
          migrate_pfn(migrate-&gt;dst[i]);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages++;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spage = migrate_pfn_to_page(migrate-&gt;src[i]);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (spage &amp;&amp; !is_zone_device_page(spage)) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
          <br>
        </blockquote>
        &nbsp;out_free_vram_pages:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to copy memory to vram\n&quot;,
        r);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (i--) {
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; npages &amp;&amp; mpages;
        i++) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dst[i])
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_put_vram_page(adev, dst[i]);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = 0;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages--;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
      </blockquote>
      <br>
      This error handing not need recover all vram pages as error
      happened at middle. Can use se do {....} while(i--);
      <br>
    </blockquote>
    no, for example migrate npage=cpage=4, and outside for loop,
    svm_migrate_copy_memory_gart failed, dst[4] is out of range access.<br>
    <blockquote type="cite" cite="mid:7fba9b16-4bb7-44c2-bc7e-d455024ce2b7@amd.com">
      <br>
      Regards
      <br>
      <br>
      Xiaogang
      <br>
      <br>
    </blockquote>
  </body>
</html>
