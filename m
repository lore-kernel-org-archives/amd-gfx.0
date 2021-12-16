Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6A9C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 16:56:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0968710E4D4;
	Thu, 16 Dec 2021 16:56:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C31E910E4D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 16:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHp3pCeBQ/CBMhZ74OpKoGSFTdrtp0POnnahKxktSvnalRzbBDAk4rMMqcvv/FwI4MWYzOHMOytqhCm1AY1KHlL87mcCGuUpKabv2YoY7N5qJ/FsuOGVGGkxkWrqxkWeeX4fN7anLJzFhoaEi5ax/Ye4vqDDZxjn2k+JD99pLHMonNOhkXLkb4yUjO02v9iBcCeWgrjD0siHPrPGdLZNBazll+uGniSOJy8Lv61eNt0n1ivYZfCb56xxTTyK/IgH/sCRIPEiKPBNUQRkDfK+f4No4NAa08tNIBR7xTeH1/fp9J42rftZQx06B8Lsi76Iz4XXoHIHhZbFPOXfRbDFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNb2DKdNIhhxnDaChhQYxnDLnyYgEusPv+Z8JAPjBJk=;
 b=hWkvoOn67jUPHOakQDhfMcQBjPPQGBwsWqUTHZDDvxUggDn0e3R33ADKScXjQ3DGP2PE2v+gCtgFKgNw299G4nSa/wHwVZyPLmxfhPKoMQ+e3GHTPq5ryAOMu0wAqxKBYgM3T1hBFATVIEmOSZ3Vd1Sz8Me//CDzGgwaNPBh7sJPiz+MWbmwB89jAfO74ACYJ2PTf1Y5FJ4jWSc0LjWFxOiVTsp9eUDhCUPq8LW7jAWRTCDDwYwC3Ks8aMgDXGCuNn76kYxzE4FJH8qs45GkQEj9N5P6QOA/2e4FPvEajPDIaHvMO57OgD/dwv3zj+R/Mv/yBDYAiynQtLGDlFNGwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNb2DKdNIhhxnDaChhQYxnDLnyYgEusPv+Z8JAPjBJk=;
 b=U3knzfAyQCxTgpXUtkECEhKG9Wh7Q1UOF9G6iGQHeTGknxGBZkjRXERSkFOaDzpWandac6xFJ6pC4ExnIDrDrsVRsfTN4uvddNvjAogBprHU1w9gqjX5V1mKnF0FaJG9PruyqpA7t7CxUEFlnvRTt884v4FQP1CX0c3DRbKo5/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB4602.namprd12.prod.outlook.com (2603:10b6:5:168::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Thu, 16 Dec
 2021 16:56:25 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::5573:3d0a:9cfd:f13c]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::5573:3d0a:9cfd:f13c%7]) with mapi id 15.20.4801.015; Thu, 16 Dec 2021
 16:56:25 +0000
Subject: Re: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() iff device
 is unplugged to prevent crash in GPU initialization failure
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>, "Shi, Leslie" <Yuliang.Shi@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211216061342.2385661-1-Yuliang.Shi@amd.com>
 <DM5PR12MB2469859E35394E34AC2A7A01F1779@DM5PR12MB2469.namprd12.prod.outlook.com>
 <CO6PR12MB545814E39E2A95074E7924CCE0779@CO6PR12MB5458.namprd12.prod.outlook.com>
 <DM5PR12MB246983C6BC18ECA5EAC2F86FF1779@DM5PR12MB2469.namprd12.prod.outlook.com>
 <2a61cafc-408e-f228-3349-f97d6005c4e4@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <fce754cd-74b5-d057-f0f6-da8460992dcd@amd.com>
Date: Thu, 16 Dec 2021 11:56:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <2a61cafc-408e-f228-3349-f97d6005c4e4@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::22) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dc34cd5-81b0-452b-7437-08d9c0b4fedf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4602:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB46025A337EE9540FDB0B85DEEA779@DM6PR12MB4602.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ghNCjO2/3LbpUG4R3/TIwQ/qiwr59A0tFLGo5/40YEVkW8BcKnRkRkcj0twtz6KI2e3Ta5K2wcSTz5wI0zVzBkpVRU6Xk9s+HXuNP3bNPd+kylmTEqx/m0GvWR3qIRwQdYnQfdOKnEhUHzIcstwSNRceq3PLOFCxIfTahwpWwUaUMNLHEZDbyus9hlbjjt6r3JNChWcE0HH/SLPbnkKt7UzKzxXLOFyXakBOF9uShzHmPxEfqLCIkKk7IiSBWrkQq0eAxy0Qhj/zVcBm3DXRKIC/ZAyvSLOaFC/4/LiwGUmXg7/Z3R8pVD/UHcpJ3mXjB1oeKLtx/H5M1LBrLdDZX90TFTzzAbxVnwcOicnDi98b/R/rQ6aeA32uTOKx6t6nKDsrbQJmB7Hu+ywWUGCKbyf1XedO+OfoVgt+MqLvY6eVTE12smYQQbe7UkDX8fH0jxJV1poIvYYR7AgUkfc/ehsRdAgAdiit0k6vjLx3QP5HKExvdAGlhG4n3yCoBU23V6PWx9VtfbWUOFKw1HezHeHOi9oq50j7J3BW78ybViCN1Du1MbLXKx98ydYs0orIDhiQM4wwSuQCZOAue0ohEwOVuyhRswoKkCLqm1EI6feBx1xSdqrafC/9WX4F4xygRKVBTMHBbmDK71GWVtA7xell27SE+cyf8IevE46/hWe3WUDGQcN7D9oodKHu2HoVCROlAf3L8z7mBAOjYRQJ5xQdcCU4S5QrbfHXojwlJ37RGazRznMCIoEa5jvmNlrA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4001150100001)(110136005)(31686004)(66476007)(66574015)(83380400001)(66946007)(66556008)(6666004)(6506007)(2906002)(36756003)(31696002)(316002)(921005)(186003)(6512007)(8936002)(86362001)(44832011)(38100700002)(6486002)(8676002)(5660300002)(53546011)(508600001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWUxd0ZpQ2VVMlB1WXRDUkNrREhwZk9JRS90WW1BZ2tleXpYWFVaRDMxZktV?=
 =?utf-8?B?bkNab3pkM2FaRUxTbFdDYjdwZnlHRDJXSytxVFFEV2E4NGFta1dLdjV2WWRD?=
 =?utf-8?B?bFFXTHFnYU03OWRLdGszTExJSU4zUmdhVUIvQU91ZlBMcG1Sa1F4cjY3alV4?=
 =?utf-8?B?YUEwWERQN1RybFl3YnpjbStic3c2Q1ZtWUUrQ0FTVUNoNnZGL1lEWVVaYmRY?=
 =?utf-8?B?YVNXbWUxQjlVRlFyVFNZaTNPMHU2bDJObzlBc1BYL3ViNUJTS3hOR2d4QXFT?=
 =?utf-8?B?alp4MFN5b21tWUU4NSs0NHNJd2xkcmRDQlFOTlJRakZlS0NyWE1CZzVROXhz?=
 =?utf-8?B?dVBOZ1JrTHlhSDc2dnZZVWZFV2h3eUpVVThGUy9qaHk2ekdZei9KV3hlWmlO?=
 =?utf-8?B?eHVwV1VFS1BUS1ZFSFZ1SmVwRFFxWXZOWGppQnF6Y0dBTDlSMmpUTWU0YlRa?=
 =?utf-8?B?UmU1TFFOZTUxUndwSVNsaFdrVTZqei9ORWg3cXhuclp5bWsvTWw4L214UzZm?=
 =?utf-8?B?UnBCbk9SaU56Y1c1R1d0dnZtS3dFYTZGMEZRRWZJc2IrNVFQZ3dQbDE5c3Ri?=
 =?utf-8?B?T2NPdVpWVmFFb29VU3MycVJsWkl6K2tRUnVDeDFWOUE1QTd6OWg5Q2dQcG41?=
 =?utf-8?B?WHRpT1JEUWgvWDZGd3N0N3FIU1Ezb1RteVN5bjBGckR0R0J5SzcyQVNUakFY?=
 =?utf-8?B?VEtLcG0zVURZS3dYUWd5TzJ0VGtsL0tzK3Q0S21nUEU1RFdEbjIvN2VYcjlj?=
 =?utf-8?B?WmxpQXZSRXdPb3F5SXROV0pZakhIbFRhc1hLQ0c5QmtMbGhRMjQvRlJDbUFa?=
 =?utf-8?B?Vjk2TmJqN3NQelRVbVF6R0hwQ04yNWx4UTR1K3RDNGRzN0VucThFMHpmbnlM?=
 =?utf-8?B?dEhscVd6TUZxRmZkVDBBWjIxWkhQeHVpY2hsanBJQmxOMHMxSXV6a3RNYm8r?=
 =?utf-8?B?Uno5S1Q5QkphZGJLTTVTUHVmWHhubFhzc09EUEtWS000UVorUGRCTXcySDBu?=
 =?utf-8?B?Z2xPOTlwNUJTNGNpekoycmFKNTE4c2RHcEdTSWp1QUVSSlQzUm5wdTIzc3ZM?=
 =?utf-8?B?VXJabU5aR1haRmJkWU9XcUZvWk0wNk8ya1FFeFlFUGYzekhtNGVSNHFRQXg3?=
 =?utf-8?B?cG1hYU53U1FoOWk5QUJ1Skd1ZHdaMDU3cnArWW5jNkE4S241REdDbjNLV0JR?=
 =?utf-8?B?Um9md2QrZ3VRa0RNQWhqcGtzemFRTkUxZ3dPbkFMNmVld3FDUGlhOEp0Sm1S?=
 =?utf-8?B?RE9kY1NrRGE2djFVZ09OTkhZZm41R05SM0tWaEtWay8yQ0JRaWtobHRQRHVO?=
 =?utf-8?B?YWJTSEJYVjRWRW9PMmxDOVNUckpXcUlSaGVpd3JGTERYc0VoZkhpNE94RGd1?=
 =?utf-8?B?QzBCQnlzRjN3WXFwRSthVURneFh0SVBycUNUN1FXWUFWbUp4U1N1d3JiVEtJ?=
 =?utf-8?B?MkdFOUJmMloyRVVoM2lOQllNVDd4SWROSFlQOU9JT25LcnZNNVFQbW1IRjJt?=
 =?utf-8?B?cTJDZ09tTXA4M29mWEhBa0F0eFVvZmx2NXZ5WlZZNCtWWmFDRFdjTFAvVVlH?=
 =?utf-8?B?N2c3czBWS1kwRDhUeVkwcDZFYjJlUHJoVWpmOG9kRW9iMkhSalptdGdsb2tI?=
 =?utf-8?B?bVJhQTdxaGMzdlRwdmdUNDhqa0lhcTZnZEpzY0V1MG9PdTc5REplYVJ6NDJG?=
 =?utf-8?B?VmxlZGphcDI2c2ZSTURRbDlneXY2c2JTR0xYTzV4V1dJUzdtQXFrTXBnSnFE?=
 =?utf-8?B?eGI2ckdJcmhJRExEUnJOajc0MUtYRWhuekJLS3IwWUZRWmFUNEtvNzJRME8v?=
 =?utf-8?B?MTdhZ3NuT2Z4aHNKOGt1OFJ5VGdBQU1zS3V0MDQrSU53U2h3NllGVVEyd1B0?=
 =?utf-8?B?Y1VDb1EwYkZZbllxeTNtL2pUUkZoczQzSUEvNmM2L2FrcmtwWG1mZHpoUmZh?=
 =?utf-8?B?VWtIcEtXWll5Uy9MZFZFZEhBUi9OVkxEdDFsY3ZSeDMyS2JlREJ2OVJ2ODM1?=
 =?utf-8?B?MnczZnNTa0hyeUJ1OXNVSWpwVnlaQlcyeEtuQU55eCt3Umd5UUxrYlc4SHZm?=
 =?utf-8?B?VEZZQlYzYkQ4NTBLRmtjTkVkaE5IdHJiV3BPT1lXRG5GemhTem1uTVpELzlX?=
 =?utf-8?B?aVNFT2VQcm8ySDhyeUlEN2FIbDdsUTJ2cWNjU3o1NG9oazZKS0hWYWZaNHdC?=
 =?utf-8?B?VzZxa2ZjcDJWL0ZWZ1BKVWpScWR3RzdqYTVnTG9oaVk2NC9GMzJQWlFzV1RU?=
 =?utf-8?Q?+YodCnB5AVfuqPRjpT0S19ppBZhIJpuoPP0vo/Z4rU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc34cd5-81b0-452b-7437-08d9c0b4fedf
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 16:56:25.5151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cFzFVDyd0rgYeV6ct3XOq+EP7/r1HSUY6CDlOdqr1NVLjoba/+IufYemIg8yKdJsUiNCMFK2npRjj5yLxlZ/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4602
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

Maybe we just should use drm_dev_is_unplugged() for this particular case 
because, there would be no race since when device is unplugged it's 
final. It's the other way around that requires strict drm_dev_enter/exit 
scope.

Andrey

On 2021-12-16 3:38 a.m., Christian König wrote:
> The !drm_dev_enter() is quite unusual and deserves a comment 
> explaining what's going on here.
>
> Apart from that it looks good with the typos fixed I think.
>
> Christian.
>
> Am 16.12.21 um 08:27 schrieb Chen, Guchun:
>> [Public]
>>
>> My BAD to misunderstand this.
>>
>> There are both spell typos in patch subject and body, s/iff/if.
>>
>> The patch is: Reviewed-by: Guchun Chen <guchun.chen@amd.com>
>>
>> Please wait for the ack from Andrey and Christian before pushing this.
>>
>> Regards,
>> Guchun
>>
>> -----Original Message-----
>> From: Shi, Leslie <Yuliang.Shi@amd.com>
>> Sent: Thursday, December 16, 2021 3:00 PM
>> To: Chen, Guchun <Guchun.Chen@amd.com>; Grodzovsky, Andrey 
>> <Andrey.Grodzovsky@amd.com>; Koenig, Christian 
>> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; 
>> Deucher, Alexander <Alexander.Deucher@amd.com>; 
>> amd-gfx@lists.freedesktop.org
>> Subject: RE: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() 
>> iff device is unplugged to prevent crash in GPU initialization failure
>>
>> [Public]
>>
>> Hi Guchun,
>>
>> As Andrey says, "we should not call amdgpu_device_unmap_mmio unless 
>> device is unplugged", I think we should call 
>> amdgpu_device_unmap_mmio() only if device is unplugged 
>> (drm_dev_enter() return false) .
>>
>> +if (!drm_dev_enter(adev_to_drm(adev), &idx))
>> +    amdgpu_device_unmap_mmio(adev);
>> + else
>> #     drm_dev_exit(idx);
>>
>>
>> Regards,
>> Leslie
>>
>> -----Original Message-----
>> From: Chen, Guchun <Guchun.Chen@amd.com>
>> Sent: Thursday, December 16, 2021 2:46 PM
>> To: Shi, Leslie <Yuliang.Shi@amd.com>; Grodzovsky, Andrey 
>> <Andrey.Grodzovsky@amd.com>; Koenig, Christian 
>> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; 
>> Deucher, Alexander <Alexander.Deucher@amd.com>; 
>> amd-gfx@lists.freedesktop.org
>> Subject: RE: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() 
>> iff device is unplugged to prevent crash in GPU initialization failure
>>
>> [Public]
>>
>> Hi Leslie,
>>
>> I think we need to modify it like:
>>
>> +if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>> +    amdgpu_device_unmap_mmio(adev);
>> +    drm_dev_exit(idx);
>> +}
>>
>> Also you need to credit Andrey a 'suggested-by' in your patch.
>>
>> Regards,
>> Guchun
>>
>> -----Original Message-----
>> From: Shi, Leslie <Yuliang.Shi@amd.com>
>> Sent: Thursday, December 16, 2021 2:14 PM
>> To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Koenig, Christian 
>> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; 
>> Deucher, Alexander <Alexander.Deucher@amd.com>; 
>> amd-gfx@lists.freedesktop.org
>> Cc: Chen, Guchun <Guchun.Chen@amd.com>; Shi, Leslie 
>> <Yuliang.Shi@amd.com>
>> Subject: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() iff 
>> device is unplugged to prevent crash in GPU initialization failure
>>
>> [Why]
>> In amdgpu_driver_load_kms, when amdgpu_device_init returns error 
>> during driver modprobe, it will start the error handle path 
>> immediately and call into amdgpu_device_unmap_mmio as well to release 
>> mapped VRAM. However, in the following release callback, driver 
>> stills visits the unmapped memory like vcn.inst[i].fw_shared_cpu_addr 
>> in vcn_v3_0_sw_fini. So a kernel crash occurs.
>>
>> [How]
>> call amdgpu_device_unmap_mmio() iff device is unplugged to prevent 
>> invalid memory address in
>> vcn_v3_0_sw_fini() when GPU initialization failure.
>>
>> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index fb03d75880ec..d3656e7b60c2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3845,6 +3845,8 @@ static void amdgpu_device_unmap_mmio(struct 
>> amdgpu_device *adev)
>>    */
>>   void amdgpu_device_fini_hw(struct amdgpu_device *adev)  {
>> +    int idx;
>> +
>>       dev_info(adev->dev, "amdgpu: finishing device.\n");
>>       flush_delayed_work(&adev->delayed_init_work);
>>       if (adev->mman.initialized) {
>> @@ -3888,7 +3890,11 @@ void amdgpu_device_fini_hw(struct 
>> amdgpu_device *adev)
>>         amdgpu_gart_dummy_page_fini(adev);
>>   -    amdgpu_device_unmap_mmio(adev);
>> +    if (!drm_dev_enter(adev_to_drm(adev), &idx))
>> +        amdgpu_device_unmap_mmio(adev);
>> +    else
>> +        drm_dev_exit(idx);
>> +
>>   }
>>     void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>> -- 
>> 2.25.1
>
