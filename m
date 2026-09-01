Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CB9C61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD5C210EF23;
	Tue,  1 Sep 2026 20:18:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dtZKTQuf";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 386DE10EF23
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:18:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfDiDtD5GckAexlPbFeZJSXe61SDPsm6Dg8H4dtb3FLdyAFm9KizyJoVfAZIcj3729N38jyD7LGVD99YBcCtQzgQl218u1BPjdTLRhlOOWuYrFjfA2sC+Zd+exZTnUokIrZI//PGo8tYj67IMW5mVhNE8nVk+2xoezePwEFJrOVOyWycMP+tltJI4+DDU5jJrITKN07+yi6UUM3IzgqDqgSWdZAaMqxBkNgYd2sTFfgIP6+ww5p2bSPueDGNwjXajb8AhVTVXM6EktWDaQ1rOry8vt2quUYZnD9VS7sh+YfQGW2Qgqr0F+lH8Bqh3l7+ZUo6OCpDcdV8nIglIEwa3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QB6KPGD1bcYkoKfJWktCOkIv7d8PitVd9tHsMCLIGE=;
 b=E9U534CRAGDB8x1TkRmblJjETJI5UyX5uPaVtH7CDbLnVPNR0OJXx/L8nHMp5xE/ramaHaRk+9WFYIrAtizFfgJpjdxeJWbf+Lv7kk388qE4OKNkQA9mkIqYcHUOJozUE4U3rkKTlrmA2Aq4Lp2ySxByl4fJV2mbQ6/CRol2Mmyky68ZqNPgpK78/kOFMjlO2a0ErFge2R41DaCpdehx2kufMm4xlGHNo+dCATpm43FzD0fmjfhqOhNFlxA2Zh2YTtLtp78u1AkIZFXjY/0FxWvdLiOJlXadVxqga/G/kBxqt0nFS9cvpnUqCNDRBGeBvqhpYLviMrD6P8iFNFX7gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QB6KPGD1bcYkoKfJWktCOkIv7d8PitVd9tHsMCLIGE=;
 b=dtZKTQuf6+G+4po7qAEUqj72ggPmtlNwMWdcq4eqqOaABY0RT3aIhe6jL4lDPUTdAsRTcYINL57bKmJ040XBSRH3wCC1IRXdtrqAooxQ6uGj85lUjzALFOjGXttQi8Xmjpp85reen3Es5siZBDqXOF/uRiOXeYf0fCknEFCeBPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Tue, 1 Sep
 2026 20:17:45 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::89d1:d03e:f443:d4d6]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::89d1:d03e:f443:d4d6%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 20:17:45 +0000
Content-Type: multipart/alternative;
 boundary="------------OHShPpi6m00b5Uk3KgHwMRoe"
Message-ID: <9a353fc4-6947-4a5b-bb37-ee6e17529ede@amd.com>
Date: Tue, 1 Sep 2026 16:17:43 -0400
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] drm/amdkfd: Fix TCP XNACK scoreboard reset race
To: Jay Cornwall <jay.cornwall@amd.com>, "Russell, Kent"
 <Kent.Russell@amd.com>, "Ba, Gang" <Gang.Ba@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260831205059.1803721-1-Gang.Ba@amd.com>
 <BL1PR12MB5898416E809BE5392EA63D9A85A82@BL1PR12MB5898.namprd12.prod.outlook.com>
 <037a59c6-f698-443b-9fe0-5fdcc23e9084@amd.com>
Content-Language: en-US
From: Gang Ba <gaba@amd.com>
In-Reply-To: <037a59c6-f698-443b-9fe0-5fdcc23e9084@amd.com>
X-ClientProxiedBy: YT4PR01CA0253.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::6) To DM8PR12MB5478.namprd12.prod.outlook.com
 (2603:10b6:8:29::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5478:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a77b251-ac32-4fe8-88a5-08df08661556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|10067099003|11063799006|4143699003|56012099006|8096899003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: n5kHl6cRiy5C3NrqcqMsGjDmeyifK9RmwTexqN4kdqnETFuVJxvjBYKXeTVDojHDaGkPmEUYv4Zb66mr4B8SU4YlmfBKtoVSWhTK20RhmwGKkwYaAzPtv3sA4blJUiHjKXOVow1Kt7DJvc7Sr9EsQKXvCZAbRVF3f31H8FpwQHxoUrgSWWet4uJQSiUolAilMZydCOkZ2ynltxdm3DuAUUDPMnPdkijfSvQ4RNpKpvXHIysphiAo0bgFjvtUb92FF9Ts+xIVz7g8E9gNRF2J3yKN0byRHdsvTSQX6gVLj+ruE3l8gTOoGlKqDoGCUCgx7YTtMoOf9kUjTzFpT3r/w8E9KOSZgbNbtW83XetWHMmAWDo0o/Dlbx15mPF7nrM/3R+mcjk3ZQg1f0ejpIBbSXOMH5Y/9ahpCSCTIYT5LBR+5+dgMQMoEQ2Lh+lARZupZHXXcmi4/iwiUUMWEkhnOw9a8DN/ze1q/hP4LiZcaF5KySaB4wci5E20L5bl+xoyDrt2deAoZCr2l+TkP2g3whJB8/AYd/jZkJ/rfLsCpCXdcn1ltDLo04Vx1nA9zwZvDVN8HAoIbycPT3o8oyHU5OHicdRBqKJVKqOpx7MrPyT+0YqL0nQsRG8Ox573W4WJrS8UTp33yimV2YQXt2kFL9wCDwprke+Mi0WbxX31NxY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(8096899003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkV2OGs5ekFyVlVLeVJDMTl5QzRMakxMa0Q5Tm9PTll1eE9heklER1NBdnox?=
 =?utf-8?B?eWYxaGl1NGpsYkVsMER0RjdqSVczcG0yOGx6bHRva0ZwTnJ3cHhJenRtcFdZ?=
 =?utf-8?B?aWxYVzB5SnRvZlVMSExaRDRHdUdYSkFaM2tlUk1aTE41YjZIQnExalNNK3Az?=
 =?utf-8?B?R1JOZUk4d2lkVkZjeE1ZdVVDeko2bnBBMExQdXFjMll6R01JS281ZnFKYVR1?=
 =?utf-8?B?YkpwZjdqeXB1T3lWdmpTNlFMc01JN09vUnBVRTdKZU82azQ3QWdhd2NkRGVQ?=
 =?utf-8?B?aHBKa2sxaGlNUzFRcjlsQXV3d2JScjdKTFJCV3FQRnZYVGtXOWpJMktZV21O?=
 =?utf-8?B?Z2YzS2VVaWoveE9UWGlkNkxndkxCaThzZW5vdFFoWWJYYlhkOHY4NCtaQnI0?=
 =?utf-8?B?bU1JRHBSdGtnclZTcUJRbjR5TVBidGNiZmtHVWJsOHFKVDZYVFFqOWFkMXlI?=
 =?utf-8?B?UGVwZ2tCMnRMb2xzd2hUTHIzODJUckwrSnFsTnNEcDAxemhwaEQyTUovZ0xy?=
 =?utf-8?B?ZmxwdTdCVzVUUFQ4RG15UkQ5TFVRNjZJUWE0NUsvcCtINlFZcnU1d0dKb2lI?=
 =?utf-8?B?bG9qQklEUE9nTWgwVThMd3BEMlByd2p6SXVtbjdXUXRtOFlTSkQ5YzkrWVQ4?=
 =?utf-8?B?QVppVGRZemMvQzFqREJaa2k1ZlBtbTYvT2NCM3BXY3k5RlhOc1lXVjRtVzJ1?=
 =?utf-8?B?a1lEa3MxWUdweHJsSzZ5d25nSGdncXIzV0RhNTM5NkhxSkNnaXFWNlJLV1Fr?=
 =?utf-8?B?Tm0yOEdPek9tempkNkFvbExyTTExam91bERYSHpobnhVZ3F4MzZKa2o5MXM4?=
 =?utf-8?B?MUk2RDRPSVo3RXFwOTNicE5MeXBBNWFrMGMzbk5XTkY0RjdPdGJLZHp4THJh?=
 =?utf-8?B?K3NPb3FmUnl3Nks0MWhtcmJ5djdoRk1DYlZuQTd5eVBkdkFOb1pNTGhiN0pB?=
 =?utf-8?B?K2JXVndQMDBMdUk0dXZNN21yUnJMTUpQenZYZ05Ca1AxTnVCSkk3cXgxUTdq?=
 =?utf-8?B?dDk5Mm9pR2p4UE1yL3BaVmFnb041OVlYUUsrTzZlMStJS08rcmtWWEZlWmRk?=
 =?utf-8?B?cWk0aGNDclFidk5UVXdrbVUzNkROcVRHRFo2c1k5ZzY4MWtRL1ZWQUI5bUpo?=
 =?utf-8?B?N2RjbTc1TTRpSFVHMkRFTEV3Wi9KRS92Yk05QVpYZnpyNUxvZ2x6L2wycTZU?=
 =?utf-8?B?eGlWNFJhaklIR0d4SklhN0FEUjFGRzBTY3NDUkN6V0IzL2ZQdXdOQzZTN0M2?=
 =?utf-8?B?QzNvV01jRE1RY0xUOEdOTkNYYnk3aUEwQ1M4SVJNK0NaZjE5TTJGNTdiUVlB?=
 =?utf-8?B?Z3g3VUhnMDV5UzFwMUx4aExYSWhwdW1iRnl1ejhVVnVWYkk4cEdwYUZXNFZF?=
 =?utf-8?B?TWNvN2p2WmdWRnZpcXFWS2tSelIxSG1keUQraHRJQ0dKMEJ3OEYzRXhwbXdn?=
 =?utf-8?B?cVFwT0dqNEdaRG05cUZiYndUanlxQVVkRTcyK2NqN1lURkttamw2RmtHN3hS?=
 =?utf-8?B?dUluRFVRN1NrcEQ4RUtLRitvcnlCUUU3Z3ppcC9XL2JLQTJBQ2lhaUEzM0Ey?=
 =?utf-8?B?dUxnRWxRMjBYNmxQQzBHcEFkM25iLzBMajFobkZLUkNUSHRmclZkc0MrM094?=
 =?utf-8?B?T3VXcjlGb2I1clA3ZjJTSTQ5Y2hzQXZabGFFOHlkUWo3UGd1QXo5SWRieGF5?=
 =?utf-8?B?ZHJkRi9NZUJOUHBJWURrb2tGWTJaRG5ZcVh6aUdXSFJHVHRkOWxYcmI0cFVv?=
 =?utf-8?B?UStLMERFYXczZ2s5Rmh5cFU0NjhxVmdUSGtmM1R1QjR0a0pwQzdMQ1hNKzlK?=
 =?utf-8?B?eWxFcExLUm1YZWo2KzVBM1ZEUVNJc2pMVVFpNjNPcytvd3VWcGlUUm5qRlZT?=
 =?utf-8?B?WHVGMHNSZ29TZEJWMTc1a3JJdG9OYWNVSFdCK1ovRjEyTFQ3Q0c3YWxUQmlm?=
 =?utf-8?B?NGh0bUJPeld0dHI3SXVabGNHaHRIUDNwNFBReFpMZTUyajhBM2kvWGxSYTh3?=
 =?utf-8?B?MzQyQktsL0lsSW95WGYwYXJUWXhmMmZrWDFET1VsamZtWEZZQWppVEl2STZk?=
 =?utf-8?B?dFZYQ3RlMFp0SmZwUkVEWTZrTEZiaXlvWnZiSmsxR1FuTFZ1aFE0aWQrZjFT?=
 =?utf-8?B?blA3MjdjeUFxS2FQTUdFZ0Z6c3RGTEM5WDUvNEJ6bnVBT0FFblBjWnQyODNK?=
 =?utf-8?B?dVRMNGIyaXc0eXZBKzhYb3gxajAzdGZ4YTFhZnNXSFoyeVI1OUN5VG5MYjlF?=
 =?utf-8?B?Qnh5NVhQVmRPaHRVVDkvdWRVZVgyRXBSanVEbUp4b1NhYUlwdTZjQ1oxMVJC?=
 =?utf-8?Q?YaFj5d2RoUxMfkx/m1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a77b251-ac32-4fe8-88a5-08df08661556
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:17:44.9452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2t+TkO2cvwv13sYoHG5UuCmw+3PwjbwR16kBV4j+ci0H4eDSrF8Kj4pH3L71clKB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
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

--------------OHShPpi6m00b5Uk3KgHwMRoe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/1/26 12:45, Jay Cornwall wrote:
> On 9/1/2026 08:04, Russell, Kent wrote:
>
>>> +     .hqd_gfx_cleaner = kgd_gfx_v9_cleaner
>
> Prefer a name like fault_cleaner. This is not related to a HQD.
>
will update


>>> +void kgd_gfx_v9_cleaner(struct amdgpu_device *adev)
>>> +{
>>> +     gfx_v9_4_2_shader_cleaner_workarounds(adev);
>
> Similarly, fault_cleaner.
>
will update
>>> +static void gfx942_workaround_cleaner(struct kfd_node *dev, 
>>> uint16_t pasid)
>
> Similarly, fault_cleaner
>
will update

>>> +     /* Run the GFX cleaner workaround on the faulting device.
>>> +      * Only run once per page fault (evicted == 1 after first evict).
>>> +      */
>>> +     pdd = kfd_get_process_device_data(dev, p);
>>> +     if (pdd) {
>>> +             /* Only call cleaner once per page fault. Run the 
>>> workaround
>>> +              * only on the first eviction (evicted == 1 after 
>>> evict above).
>>> +              */
>>> +             dqm = pdd->dev->dqm;
>>> +             dqm_lock(dqm);
>>> +             if (pdd->qpd.evicted == 1 && dqm->dev->kfd2kgd-
>>>> hqd_gfx_cleaner)
>>> + dqm->dev->kfd2kgd->hqd_gfx_cleaner(dqm->dev-
>>>> adev);
>>> +             dqm_unlock(dqm);
>>> +     }
>>> +
>>> +     /* Restore all process devices after workaround completes */
>
> I'm not sure that we want to do this. Once a process faults there is 
> no recovery path for its queues. If we restore them then other waves 
> may cause further faults, leading us back here.
>
> Similarly, if the workqueue contains pipelined fault interrupts we 
> don't want to do this multiple times. Perhaps check pdd->qpd.evicted 
> before evicting queues and only run the workaround if (evicted == 0).
The eviction and restoration functions feature built-in concurrency 
protection. If an eviction process is already underway, the function 
automatically bypasses the operation.

The function utilizes the "evicted" value (which can be updated to 
|pdd->qpd.evicted <= 1|) to prevent multiple concurrent executions of 
the cleaner function.


--------------OHShPpi6m00b5Uk3KgHwMRoe
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/1/26 12:45, Jay Cornwall wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:037a59c6-f698-443b-9fe0-5fdcc23e9084@amd.com">On
      9/1/2026 08:04, Russell, Kent wrote:
      <br>
      <br>
      <blockquote type="cite">
        <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp; .hqd_gfx_cleaner =
          kgd_gfx_v9_cleaner
          <br>
        </blockquote>
      </blockquote>
      <br>
      Prefer a name like fault_cleaner. This is not related to a HQD.
      <br>
      <br>
    </blockquote>
    <p>will update</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:037a59c6-f698-443b-9fe0-5fdcc23e9084@amd.com">
      <blockquote type="cite">
        <blockquote type="cite">+void kgd_gfx_v9_cleaner(struct
          amdgpu_device *adev)
          <br>
          +{
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_4_2_shader_cleaner_workarounds(adev);
          <br>
        </blockquote>
      </blockquote>
      <br>
      Similarly, fault_cleaner.
      <br>
      <br>
    </blockquote>
    will update
    <blockquote type="cite" cite="mid:037a59c6-f698-443b-9fe0-5fdcc23e9084@amd.com">
      <blockquote type="cite">
        <blockquote type="cite">+static void
          gfx942_workaround_cleaner(struct kfd_node *dev, uint16_t
          pasid)
          <br>
        </blockquote>
      </blockquote>
      <br>
      Similarly, fault_cleaner
      <br>
      <br>
    </blockquote>
    will update<br>
    <br>
    <blockquote type="cite" cite="mid:037a59c6-f698-443b-9fe0-5fdcc23e9084@amd.com">
      <blockquote type="cite">
        <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp; /* Run the GFX cleaner workaround
          on the faulting device.
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Only run once per page fault (evicted == 1 after
          first evict).
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; pdd = kfd_get_process_device_data(dev, p);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; if (pdd) {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Only call cleaner once per page fault. Run
          the workaround
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * only on the first eviction (evicted == 1
          after evict above).
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm = pdd-&gt;dev-&gt;dqm;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pdd-&gt;qpd.evicted == 1 &amp;&amp;
          dqm-&gt;dev-&gt;kfd2kgd-
          <br>
          <blockquote type="cite">hqd_gfx_cleaner)
            <br>
          </blockquote>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          dqm-&gt;dev-&gt;kfd2kgd-&gt;hqd_gfx_cleaner(dqm-&gt;dev-
          <br>
          <blockquote type="cite">adev);
            <br>
          </blockquote>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_unlock(dqm);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; /* Restore all process devices after workaround
          completes */
          <br>
        </blockquote>
      </blockquote>
      <br>
      I'm not sure that we want to do this. Once a process faults there
      is no recovery path for its queues. If we restore them then other
      waves may cause further faults, leading us back here.
      <br>
      <br>
      Similarly, if the workqueue contains pipelined fault interrupts we
      don't want to do this multiple times. Perhaps check
      pdd-&gt;qpd.evicted before evicting queues and only run the
      workaround if (evicted == 0).
      <br>
    </blockquote>
    <div data-olk-copy-source="MailCompose" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">The
      eviction and restoration functions feature built-in concurrency
      protection. If an eviction process is already underway, the
      function automatically bypasses the operation.</div>
    <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><br>
    </div>
    <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">The
      function utilizes the &quot;evicted&quot; value (which can be updated to <code>pdd-&gt;qpd.evicted
        &lt;= 1</code>) to prevent multiple concurrent executions of the
      cleaner function.</div>
    <p><br>
    </p>
  </body>
</html>

--------------OHShPpi6m00b5Uk3KgHwMRoe--
