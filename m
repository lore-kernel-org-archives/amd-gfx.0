Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E3DCD379F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 16:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5DD510E5E8;
	Tue,  3 Sep 2024 16:36:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zBSK3JCT";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7BCE10E5E8
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 16:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8CN318e+T0IaQsV4m5Aq2dU2glW0NLpmvbVCdicDd+mGIs4uDasVnuetQKK6cfDnh0/BKZnYPfduXQiBaBCBYPddCjqBzlOiL+F1AV2l7P4gfBdV6cF7uDb+22dnzXD8ud3q72imzm7FORJUZnqcOMlJej49pL3KZFts+Qcu6Nk0SEQ5QJqYjLwa2+taYhP+vBGhCiRv9Bv2jj9yLuVirLAu5TsP+RnJIxXzZUatAKRsxdu9kDxZf3vnrgWObYFlaj3ZtAa52fqds1JCrIr4eK920134O+sU/h/m6r6voMqcDD5Zxk6jF/h/1oplc8xmPNmRzEi2IBpcq8XcYpj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9weTB6ykdQjWdqZGKMJP2mBuHN0ZaIGryyxiSOszB8=;
 b=J4p9TLjOwBQ1Ytw1EV0gbL7RDM2E5gxykRUPb+Laxjbd2a0hE27NxuJu4Zc/zM+ihvN/sAEjF4SqEYj6gKh+RZhEUWXpjMuG62wxwqTXpXXdgseVzwQrPeMG4WNJrY3mvn7xuYyxMODZ27VZg0Rw6aGwaP7DbhuBSfmsgnX6bZWKW2ecBUjeAb7sCz1GHqoOYmV06gAtAC0IrMcmLBBKO/tLCT/HsicqciICPf2XYOnkFXLVEZJkFPkDqgeZ0aUGf2PlsC17t+FHkkC9EoPG99Px+PZW2exT7APrCh0RHZOEFe2+NqQv0hjpAE8eHC6IMk1pIHVDC4BghLvws+H4vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9weTB6ykdQjWdqZGKMJP2mBuHN0ZaIGryyxiSOszB8=;
 b=zBSK3JCT/ifeFptp8+Djh6nYKIjxyeiQbynWPwPeElTGBQabIjpJaKCRhinGHqldddHm2cx0F+WhCRwb2qPf8CRSBw/u++hfcTb8khcEueNKwMbqJVgAi5ibmoOhpVA4ZG6GuNuoR/Ojh0iciuQeif6q+VT2IC20cfYWCbSrZ6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH7PR12MB6634.namprd12.prod.outlook.com (2603:10b6:510:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Tue, 3 Sep
 2024 16:36:19 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%3]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 16:36:19 +0000
Message-ID: <98466ceb-8116-2948-b577-016173799f1a@amd.com>
Date: Tue, 3 Sep 2024 12:36:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V3] drm/amdgpu: Surface svm_default_granularity, a RW
 module parameter
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240829221334.313701-1-Ramesh.Errabolu@amd.com>
 <78d992ce-9a81-480c-9acd-5a176d40ada3@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <78d992ce-9a81-480c-9acd-5a176d40ada3@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::11) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH7PR12MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b56512-5561-4562-5d9f-08dccc3689a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXUrYTg3T0VlZGlrdndHV2tjbGIxQW03OFZQWVB3K2FtdkJoNHcrYzFnWXhk?=
 =?utf-8?B?MnRJNmlsUWFLQ01GUHR4YTY3ODBuemY5ckZyLys0K0cvSTZhRlpFa0t2S3V1?=
 =?utf-8?B?NmlGMTNzS1RPN0tXY1JudTVHZ0ZKT1dRcWZXTCsxSlh0dTF2RjRKbTdBR3lB?=
 =?utf-8?B?RGZ6Y0RkUVBPWFg3dkwxQVlJWDBMM3c5Rk12OFVnL2U2eG1ZMXBIcjJydlNB?=
 =?utf-8?B?MFlMRTZna2JTQlJPMTA3N0J5TkI3MlB5ODJvSzlSRnQ4SVM2Y0x2bytreXlR?=
 =?utf-8?B?WS9Zb3p0dUJETWt5cGN5d3phdWI3dUNTdGFjd0ZxRldYeXVkNFN2TWd0d09x?=
 =?utf-8?B?eStIckt4MnJKY2gwakw4OEw2Mk9iRkVWc2xYcEZLTnVyOWw4VitPTGVNQ2Z0?=
 =?utf-8?B?Y2hyQ2dKVEczQXU1TFVlT0RiREdyaVA1TzNVSThpdmNZdm5WdGtVb3R6T1Zl?=
 =?utf-8?B?N1JRMVFWRWtzUFhWcXdXcE92M21XZUZDQ3A2VW5wdkJ5SW5ITktmRzJJL0xu?=
 =?utf-8?B?Sld1eXNNVXJZV25FYUtBSXJsdmNFbmIyQ0FyYXp5Q0NOQjlIeEZUbk5YczRy?=
 =?utf-8?B?YVdYaUpnMGJ0TnJhT2h4ZFpNek1oZkczNzVjMVRRRlFHczdYWmFDa2ZwSWVI?=
 =?utf-8?B?ZldWaVFoOWk2K1oxODgzTkpnZHR5RHplMkxIZ1d1ZlZNSmVWT2lONkVnMFNR?=
 =?utf-8?B?TXllK3dWTnZyWUhzZTBROC9IUHQ1dU9xOVlJMWdLdWN5Y3pmL3NPWWM1cllJ?=
 =?utf-8?B?UitRakxoZWdseWQ0OEg1aEhKYkxVKzFLQkxCTjRxRVdKclQ0S1JvWDdaTFpV?=
 =?utf-8?B?M21MNFFUQUlqNXNVSkFiMzUwMVlyY1N2ei9rZDNTbjhvWU5sTUtodUM4ME5p?=
 =?utf-8?B?Z3NPUHpISkxQeWo0L1Q5K0Eyc0NGaFIrNkVtL2oxbHdyUGc3YzNTYmEyMEsy?=
 =?utf-8?B?TTdER1JlQzUwc29vZFdLTXF5bGVGQUhYRXhWK0QrNUpsYmhuN2psNlBVdURt?=
 =?utf-8?B?d1lIUFZmRkxzSE1pRGI5YmNsRWRGazhvSlMzSU1oQm8wcWd6cDgrNlNGM0Fw?=
 =?utf-8?B?TUtqaEd3Uy9id0c2ZjFITHI5WUNUdElraFg1RU5FbVlST3hXQ2VIZDdhZU01?=
 =?utf-8?B?ZlplNmhrYXhKd01iNVBobmZCR1g5VnN0WnNGdlh1SkxaeThScGpkdUpHZ1c0?=
 =?utf-8?B?YmpCTWVxa1VLWFgrSHFXOVVRWEowWHprcThMMTJhVGlEbWllanpzaFFRTWI1?=
 =?utf-8?B?L1JWV0RmVk54dllZd1V3cHhwMEdwYVF5ZHFFOUo3Qy9COFFUWDBGVFg5ckkr?=
 =?utf-8?B?OTdxd29JY3pQQzhFN0RvWEVWYWxHbGdPMFRRNCtKd1prOXZXK3pPMGVkc0dC?=
 =?utf-8?B?a09tVE1tdzNMZkZ4UFQycU1FeUVUTzl1SmVpbjQwRUlqOWp4ckNPL3l5OFph?=
 =?utf-8?B?enRLU2lBQURKSGZkQkZkeTZhNyt1UmZSMnZvWTQ5ZFlVVTNPL1RjZUdFcUs3?=
 =?utf-8?B?WmNvdi9NaTlhOE12UzJTWXlMc0puWXBzcnI2aWpzS1dQaUxMbjVMZmZFM3I3?=
 =?utf-8?B?SkhlN3hodFBXSUkwcVNrQ1NMNFh5R05PUnlzVXVyWEFobnlaSHpTMVYwQTBW?=
 =?utf-8?B?eWN4VlM3dnE3VVR6dE9RNlQySUw5S1J6a0lNWGk0d2lUdTdiZVo1TnhEQity?=
 =?utf-8?B?RVUzSmlEMURZUFZqNmFnSEg5bWNXN095NVEyKy9oYmZEMmR5MFVENlhOb0I3?=
 =?utf-8?B?WC9WZmcwZWNKcGdzOXFPSzcyQUtXUDdTNEV6eTFQSUpaUWZyL1NDVDZCY1Vr?=
 =?utf-8?B?T2VRenJtbDZGdTdUcEQxdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFhUeGZrY3NMdS9VWWFwanVFYnozTUYxc0xIVnprVVlJTmVLakRKdWc4b09K?=
 =?utf-8?B?c1pEMHY3S1QzZFRZaGtFNVljekY2RWxiOXpQTnArY1NzTG13S3UyT1BJcEFu?=
 =?utf-8?B?OTY3ckRkdi9xQVlMNUExT2QzcEpsaUxacWN1NUFBSlo5Ry9wdHVSMUZOcCtC?=
 =?utf-8?B?ZTg5UHl3NEZkbVBDbmJmcEZ4Y0RSaXdxQlBuUG5HRk8zcGcydTBiNkxPdnh0?=
 =?utf-8?B?ZXRoc3o3bG0xN3gwZk9NSFlzaFU5Vi9mNGw0VjUweE11bDZjd2JRdjZZT1dE?=
 =?utf-8?B?Y0FKZjRSTUJuNnlSTWVxblRlb2dLYzIxMUw0dGhjL095eHBDYzBEdUJWZ2U5?=
 =?utf-8?B?c3dCL0dFL2tYNi81ME83U0tjTjR6R0puVWFDekJUVWgyMDhNMXE2UkVGNmhX?=
 =?utf-8?B?akVReGMvSlFPVWRxUExBbG5jMWhBaG82WlpIbjhrMlJrQ2tmZEk5NzR3TTB6?=
 =?utf-8?B?RXVBdmxtZXFBWXFoU0ZBelFXVmlHcGgxRHJQV1NES0lvZm9kamppalU1UE1t?=
 =?utf-8?B?R0VBeWNOS0dPdGo2aHk2SVRYNW5LQUdPRTJtT1pzZ3RTN09ISWo5aUI0OVJM?=
 =?utf-8?B?T2czTjZsSXYyRkEyNUNxYzdtaVBJSllERjBDTy8xTHpQVndDa2dFK3VLa2R0?=
 =?utf-8?B?VisvdSsvM3BPcmJORVFVbFFnbUpkejBIUlNPNk1sU1RJQ3NmK3FnYW81RlRT?=
 =?utf-8?B?S2thM2Vmd0VTYXZ1WUsxWncxaGhYRDBUaVc1MDQyVkF3eDdxUkZzM0dkd0l5?=
 =?utf-8?B?RWlrVlNTa3M3NDI2VWgxWlFBWmpCWUNqMkgrK3B4SHNQWHJ2WDVpMjNwSjVZ?=
 =?utf-8?B?TjgwcEhhU1pWT3dhQkxGSHphb3V6K3A0NmFkcWd5b1h2bndxdUVwTzJ1YTQ0?=
 =?utf-8?B?WGFNeW9xc0o2RllEQ1ZVTEN0TXBTR01JY0d2YmRrOGVndytLNTlNNTcrN3Vt?=
 =?utf-8?B?ZlNhTWJVcXA2YklhU1hZSUVrZ1U3ZzUwNy8vZFB4VzREOVVQb1I4aFl3dnBZ?=
 =?utf-8?B?cytzRUE4Q1h2b2p6Qkk3MVVkcmVscWVuNXUxQUJlUVZCQ2hMQSt2UkVnTXpr?=
 =?utf-8?B?c0Nud1RpYWU4RGxPTHFROElaMlQrcjh2QnZQSWR0ZVMwUmI4TUFONXdwWm5k?=
 =?utf-8?B?QVhEa2w1VUFZOGsrVHg3NWRNT0dER2d0aHlxNDN6YnVwRVdoazkrUGM3dGhx?=
 =?utf-8?B?Z0h0NU42QWNyMWFNK0lTNHUvUDlTeE5zdENFNTlVN1NIZTFRUVNLWS9ZU3BS?=
 =?utf-8?B?a2dUSk9ud1E1bHhWb3kyVFArS01PWDRqY1NRUFg0OUVtekYxaWZYTHl1UnRa?=
 =?utf-8?B?c2RhYUdLTnlQdFNUUTlMYkIzcERzdWdUeklMNVNQNHpwVytmbk5nV1JjZEhm?=
 =?utf-8?B?Wm5MZ3F0eElKMUo4d21RSXNCdmszRXRtRndWQlJGSVZqZzFXam55a3dSaXpM?=
 =?utf-8?B?TFVlcW85dnEzd1ozOXZseWRPa0dodUdiRU9SdGEwQzJIVVhjNWFneFRjbzJZ?=
 =?utf-8?B?K1JjWFVlU1RnZDcreGFhRVlQVzhqWDlkcmg3aC9TZ0ZVVi9IZmhCNkpiTUp5?=
 =?utf-8?B?Kzl0SmcwZnRTTUxzcEs4QlltQXBMY0FLdGlrYUlzdmNvSHVYelVSQ3NDSTBH?=
 =?utf-8?B?aklKcGVWREtiMElwcHk4b2RESjNUdVFIdTB1T3Awd2RXV0ZnRFA5eEpRMjlt?=
 =?utf-8?B?YUs4c2NKTU5XN1VKdzhzNE9PenprYXVMenF2VkxFZ2ZrblZkRkhTY0lSalkw?=
 =?utf-8?B?QUZ2VGU3QUo5WTExNmtka0lua0lnVTh2blIzUnBUN3V2YzVQekJ4UnhxaEZr?=
 =?utf-8?B?d2tVa2w3ZTZBOUZvTHVSbklMUTRyLytlZ2t0TTlFejJSQzFKSk1UVEc4LzRH?=
 =?utf-8?B?QnRTTUZ4TkJaZFRPNHVpRG5xNTBvQXRaOWJSNXhWblp3WWFjblBOME9yUUto?=
 =?utf-8?B?U282bFdHcGF3cmxRaS9Qdy9uWklFSUR4eEFwL3F2TmR4WnUyVnovVk4yOGNN?=
 =?utf-8?B?bjg3dEpCRUtZQWZhMEY1ZXBpSkxOTmN3UHkvdldZUXdQQjJWKzNnN3NvekNM?=
 =?utf-8?B?WDR5VUt6c1k0RFRnRGxTM1kyRXV2V3NxOU1mbkRHNVVVVStjSmFWZ1RkV2Vv?=
 =?utf-8?Q?PzGw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b56512-5561-4562-5d9f-08dccc3689a1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 16:36:19.0238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ci3wJLlb8aAPHPrz2qji41eptL6ZC48QtrsXejHfL6ZZsztLqWPh6lV6Boia0WQ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6634
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
    <div class="moz-cite-prefix">On 2024-08-29 18:31, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:78d992ce-9a81-480c-9acd-5a176d40ada3@amd.com">
      <br>
      <br>
      On 8/29/2024 5:13 PM, Ramesh Errabolu wrote:
      <br>
      <blockquote type="cite">Caution: This message originated from an
        External Source. Use proper caution when opening attachments,
        clicking links, or responding.
        <br>
        <br>
        <br>
        Enables users to update SVM's default granularity, used in
        <br>
        buffer migration and handling of recoverable page faults.
        <br>
        Param value is set in terms of log(numPages(buffer)),
        <br>
        e.g. 9 for a 2 MIB buffer
        <br>
      </blockquote>
      <br>
      Forgot asking if this parameter is request from customer or used
      for debug/experiment purpose? If it is later, how about put it at
      debug fs? There are already many driver parameters.
      <br>
    </blockquote>
    <p>debugfs is not always available, depending on kernel
      configuration, and debugfs seems for debugging purpose, ex.
      /sys/kernel/debug/kfd/mqds, hqds, not for functional purpose. one
      comment embedded below.<br>
    </p>
    <blockquote type="cite" cite="mid:78d992ce-9a81-480c-9acd-5a176d40ada3@amd.com">
      <br>
      Regards
      <br>
      <br>
      Xiaogang
      <br>
      <br>
      <blockquote type="cite">Signed-off-by: Ramesh Errabolu
        <a class="moz-txt-link-rfc2396E" href="mailto:Ramesh.Errabolu@amd.com">&lt;Ramesh.Errabolu@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 17 +++++++++++++++++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp; |&nbsp; 6 ++++++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp; | 25
        +++++++++++++++----------
        <br>
        &nbsp; 4 files changed, 39 insertions(+), 10 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
        b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
        <br>
        index e8c284aea1f2..8eb934af02f2 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
        <br>
        @@ -237,6 +237,7 @@ extern int sched_policy;
        <br>
        &nbsp; extern bool debug_evictions;
        <br>
        &nbsp; extern bool no_system_mem_limit;
        <br>
        &nbsp; extern int halt_if_hws_hang;
        <br>
        +extern uint amdgpu_svm_default_granularity;
        <br>
        &nbsp; #else
        <br>
        &nbsp; static const int __maybe_unused sched_policy =
        KFD_SCHED_POLICY_HWS;
        <br>
        &nbsp; static const bool __maybe_unused debug_evictions; /* = false
        */
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
        <br>
        index b9529948f2b2..442039436cb3 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
        <br>
        @@ -169,6 +169,16 @@ uint amdgpu_sdma_phase_quantum = 32;
        <br>
        &nbsp; char *amdgpu_disable_cu;
        <br>
        &nbsp; char *amdgpu_virtual_display;
        <br>
        &nbsp; bool enforce_isolation;
        <br>
        +
        <br>
        +/* Specifies the default granularity for SVM, used in buffer
        <br>
        + * migration and restoration of backing memory when handling
        <br>
        + * recoverable page faults.
        <br>
        + *
        <br>
        + * The value is given as log(numPages(buffer)); for a 2 MiB
        <br>
        + * buffer it computes to be 9
        <br>
        + */
        <br>
        +uint amdgpu_svm_default_granularity = 9;
        <br>
        +
        <br>
        &nbsp; /*
        <br>
        &nbsp;&nbsp; * OverDrive(bit 14) disabled by default
        <br>
        &nbsp;&nbsp; * GFX DCS(bit 19) disabled by default
        <br>
        @@ -320,6 +330,13 @@ module_param_named(pcie_gen2,
        amdgpu_pcie_gen2, int, 0444);
        <br>
        &nbsp; MODULE_PARM_DESC(msi, &quot;MSI support (1 = enable, 0 = disable,
        -1 = auto)&quot;);
        <br>
        &nbsp; module_param_named(msi, amdgpu_msi, int, 0444);
        <br>
        <br>
        +/**
        <br>
        + * DOC: svm_default_granularity (uint)
        <br>
        + * Used in buffer migration and handling of recoverable page
        faults
        <br>
        + */
        <br>
        +MODULE_PARM_DESC(svm_default_granularity, &quot;SVM's default
        granularity in log(2^Pages), default 9 = 2^9 = 2 MiB&quot;);
        <br>
        +module_param_named(svm_default_granularity,
        amdgpu_svm_default_granularity, uint, 0644);
        <br>
        +
        <br>
        &nbsp; /**
        <br>
        &nbsp;&nbsp; * DOC: lockup_timeout (string)
        <br>
        &nbsp;&nbsp; * Set GPU scheduler timeout value in ms.
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        index 9ae9abc6eb43..d6530febabad 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        @@ -868,6 +868,12 @@ struct svm_range_list {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct task_struct&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *faulting_task;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check point ts decides if page fault recovery need
        be dropped */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        checkpoint_ts[MAX_GPU_INSTANCE];
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Default granularity to use in buffer migration
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and restoration of backing memory while handling
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * recoverable page faults
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t default_granularity;
        <br>
        &nbsp; };
        <br>
        <br>
        &nbsp; /* Process data */
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index b44dec90969f..624bfe317c9c 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -309,12 +309,13 @@ static void svm_range_free(struct
        svm_range *prange, bool do_unmap)
        <br>
        &nbsp; }
        <br>
        <br>
        &nbsp; static void
        <br>
        -svm_range_set_default_attributes(int32_t *location, int32_t
        *prefetch_loc,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *granularity, uint32_t
        *flags)
        <br>
        +svm_range_set_default_attributes(struct svm_range_list *svms,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t *location, uint8_t *granularity,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t *prefetch_loc, uint32_t *flags)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *location = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *prefetch_loc = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *granularity = 9;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *granularity = svms-&gt;default_granularity;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *flags =
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOCTL_SVM_FLAG_HOST_ACCESS |
        KFD_IOCTL_SVM_FLAG_COHERENT;
        <br>
        &nbsp; }
        <br>
        @@ -358,9 +359,8 @@ svm_range *svm_range_new(struct
        svm_range_list *svms, uint64_t start,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(prange-&gt;bitmap_access,
        svms-&gt;bitmap_supported,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MAX_GPU_INSTANCE);
        <br>
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        svm_range_set_default_attributes(&amp;prange-&gt;preferred_loc,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &amp;prange-&gt;prefetch_loc,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &amp;prange-&gt;granularity, &amp;prange-&gt;flags);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_set_default_attributes(svms,
        &amp;prange-&gt;preferred_loc,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;prange-&gt;granularity,
        &amp;prange-&gt;prefetch_loc, &amp;prange-&gt;flags);
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p [0x%llx 0x%llx]\n&quot;, svms, start,
        last);
        <br>
        <br>
        @@ -2694,9 +2694,10 @@ svm_range_get_range_boundaries(struct
        kfd_process *p, int64_t addr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *is_heap_stack = vma_is_initial_heap(vma) ||
        vma_is_initial_stack(vma);
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start_limit = max(vma-&gt;vm_start &gt;&gt; PAGE_SHIFT,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long)ALIGN_DOWN(addr, 2UL
        &lt;&lt; 8));
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long)ALIGN_DOWN(addr, 1UL
        &lt;&lt; p-&gt;svms.default_granularity));
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end_limit = min(vma-&gt;vm_end &gt;&gt; PAGE_SHIFT,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long)ALIGN(addr + 1, 2UL &lt;&lt;
        8));
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long)ALIGN(addr + 1, 1UL &lt;&lt;
        p-&gt;svms.default_granularity));
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* First range that starts after the fault address */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node =
        interval_tree_iter_first(&amp;p-&gt;svms.objects, addr + 1,
        ULONG_MAX);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (node) {
        <br>
        @@ -3240,6 +3241,10 @@ int svm_range_list_init(struct
        kfd_process *p)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
        (KFD_IS_SVM_API_SUPPORTED(p-&gt;pdds[i]-&gt;dev-&gt;adev))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_set(svms-&gt;bitmap_supported,
        i, 1);
        <br>
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Update default granularity to one bound by
        user/driver */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms-&gt;default_granularity = min_t(u8,
        amdgpu_svm_default_granularity, 0x1B);
        <br>
      </blockquote>
    </blockquote>
    <p>the max granularity is 0x3F, 63 bits, why do you limit max
      granularity to 0x1B?</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <br>
    <blockquote type="cite" cite="mid:78d992ce-9a81-480c-9acd-5a176d40ada3@amd.com">
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Default SVM Granularity
        to use: %d\n&quot;, svms-&gt;default_granularity);
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        <br>
        @@ -3767,8 +3772,8 @@ svm_range_get_attr(struct kfd_process *p,
        struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node = interval_tree_iter_first(&amp;svms-&gt;objects,
        start, last);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!node) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;range attrs not found return default
        values\n&quot;);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_set_default_attributes(&amp;location,
        &amp;prefetch_loc,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &amp;granularity, &amp;flags_and);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_set_default_attributes(svms,
        &amp;location,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;granularity,
        &amp;prefetch_loc, &amp;flags_and);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags_or = flags_and;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;xnack_enabled)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(bitmap_access,
        svms-&gt;bitmap_supported,
        <br>
        --
        <br>
        2.34.1
        <br>
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
