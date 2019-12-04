Return-Path: <SRS0=SH5p=Z2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_KAM_HTML_FONT_INVALID,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE368C2BD09
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 16:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F882206DB
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 16:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F882206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 118B36E922;
	Wed,  4 Dec 2019 16:05:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E422D6E91E
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2019 16:05:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6tVyDI5xWOWkUzqKZbsUENQnYu+yMyq+IqVwJZ6PjhBpEgV0aqWg5KF59Ou0KQMYLpCqGSN6dTXETNgZETpjOFqQifwjaaHVZTJ+u4FLBDZ/NkFjqxYoj8PopMbxkqoj7QEiuusWqPgsnY9hV91olOqylRhrOlnEOOGCYFCmXZprPE3JMZo6H4XMRHly5Oe/yTfHc0LZt8ZcmtYwz857fLK27gVdYHXi4zJoUxeEc0xlnAkbjTik6MJjTfwpnBfPZ1zJ3LBPWv8CvwLjxGU2FApkLe1AF7oolSgeU1UfrdIa6PLF+sGtcHO0Uq4jxJ9d7lIugAVl+v5OORcpyPZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6snCBHCRNC8M4elER5XZ59FBMevZXKPbxbjdfhDcQ7o=;
 b=MwY5bfN40GD+E5r5NUJ+9VFFLS4IDYaMV7gjmOUwpHbWLkykpFMOp6oMO48qEV/PcBkICcC9QgrsCY1Sxei8ReMhZJBo5eUHu8x9Je5APlyYGymdE4FMn82s6LqxSlMj9YgNcdMH82B+Pk/dRJtniZYsH1Nmz4YKaQslVBpIjtwnlmERYzRFbFMQqR9hD6/Tn9d7AqtPwBvXovNPx2vLuP8bXbVvSAGeKz2+WYOrmTJcaN48gs+8xlGIxiSGevlK/nugVw4veJOoiWx4kTf9ucJ3s9ZtY44fHz8i0VxVvkR++XO2SEFWn5pXC7ufxSObHQUYmbfWS9aFIqcvGA5few==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1823.namprd12.prod.outlook.com (10.175.55.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 4 Dec 2019 16:05:36 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80%12]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 16:05:36 +0000
Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support for
 XGMI
To: "Ma, Le" <Le.Ma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <1574846129-4826-6-git-send-email-le.ma@amd.com>
 <c09d7928-f864-3a80-40e2-b6116abe044c@amd.com>
 <MN2PR12MB42859443EA78D08B295AFE0DF6470@MN2PR12MB4285.namprd12.prod.outlook.com>
 <157d7671-803c-4f6e-f77c-9738f32905e3@amd.com>
 <MN2PR12MB428532FA663C99770AA71263F6430@MN2PR12MB4285.namprd12.prod.outlook.com>
 <5b505116-17aa-383d-5cdf-246663a1f4f9@amd.com>
 <MN2PR12MB42855B198BB4064A0D311845F6420@MN2PR12MB4285.namprd12.prod.outlook.com>
 <2c4dd3f3-e2ce-9843-312b-1e5c05a51521@amd.com>
 <CH2PR12MB4278F9759EF24F29A85D7D23F65D0@CH2PR12MB4278.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <0cf9f58a-3ce4-2a9c-cb1a-db3cb13760b9@amd.com>
Date: Wed, 4 Dec 2019 11:05:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <CH2PR12MB4278F9759EF24F29A85D7D23F65D0@CH2PR12MB4278.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: BL0PR0102CA0031.prod.exchangelabs.com
 (2603:10b6:207:18::44) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-Originating-IP: [2607:fea8:3edf:e127:edfa:8840:22aa:56bf]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 560111ca-32d5-41e7-a7a2-08d778d3cc45
X-MS-TrafficTypeDiagnostic: MWHPR12MB1823:|MWHPR12MB1823:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1823C50B6F1D98D8DA42EBF9EA5D0@MWHPR12MB1823.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(13464003)(189003)(199004)(186003)(6636002)(2501003)(790700001)(6116002)(37036004)(6506007)(53546011)(478600001)(25786009)(14454004)(4326008)(966005)(99286004)(30864003)(6246003)(110136005)(86362001)(66476007)(66556008)(66946007)(2616005)(81166006)(81156014)(65956001)(8676002)(8936002)(11346002)(5660300002)(6512007)(54896002)(6306002)(7736002)(71190400001)(36756003)(31696002)(6486002)(31686004)(229853002)(316002)(16586007)(5024004)(58126008)(6436002)(6666004)(33964004)(14444005)(2906002)(52116002)(76176011)(921003)(1121003)(569006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1823;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZtTvzgd2/kCkYvfU5FhmZ24bA7H0uIFr+Tn8Ubja1FpmdrLG0Op/EKUHREXqqhyhmmHo670cUR+DVUgUVpK14FDRlnwEWW555YknH27ow2WhpqaGNEgMNUjQu2oOzw7tVzYqp9Ce6wrdErn9dqTmewxeuu9CDaWw2WKjV0UYEtmvPgwICXYBePbWltz+vQd8Z7uympb/m7Pdoy73u+Ha9u+7fjZn/UbN5+5SIVb/MN6yfSuzN/SFwdKXpOqMki7qD1IM02St6LcByP59n75fo3kdc8aL7DN8iySwfoUrGiD5GqwZZn+l90Nw+dhzRN+/c5KptDgifbaL/940waSEuoEfcmgRtlXlrDvRcAyIhXR7jvld/rycdKU9m/rE+ybGGSwE6K5nqC1SaiqH7XXKXRg6GAT7y9qDw7xKIHqMfXCVWdTJyg67fLP/yCUGdU26mdegUA3ahmJQL1pJ85Ow02V8fsuraFhcC8aHbRxL6cBWMGcX6pw2HCwKv5LCed6q9oOHe74Uq2DnIucLpcUjRX5/Rs46g0YUZqjuaJyj+AXWFg3cE4INd1gJTkv2AKWlSPn75HCmlwszlsrLtsPu8A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560111ca-32d5-41e7-a7a2-08d778d3cc45
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 16:05:36.0532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoajX1+pcjuyhR2ggqjDS7pFCqh8byOM2/oCFZcP37HL7k7nm/XqG7tBeIwPlIpY95YjN50ukBxYnGaFbWDaxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1823
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6snCBHCRNC8M4elER5XZ59FBMevZXKPbxbjdfhDcQ7o=;
 b=Dnj4+ckLFXiNYZGF9JudWa2WgZOibyUH9zfMsDZW/W3xERu3M7D3k+Gjq30MSrEe8dVUP1FytneiP5loviPHfyMz3YwZknxggniq+4p6Aqu8tiOODRYMXLrwKoxl/of6XVGNOTgVIRQyBtM4cWoSlvscHwWTUXdQxSbFTRDQxy0=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Content-Type: multipart/mixed; boundary="===============1238137983=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1238137983==
Content-Type: multipart/alternative;
 boundary="------------D09511E636D64ADDBEA6A351"
Content-Language: en-US

--------------D09511E636D64ADDBEA6A351
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/4/19 2:09 AM, Ma, Le wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> *From:*Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> *Sent:* Wednesday, December 4, 2019 2:44 AM
> *To:* Ma, Le <Le.Ma@amd.com>; amd-gfx@lists.freedesktop.org; Zhou1, 
> Tao <Tao.Zhou1@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhang, 
> Hawking <Hawking.Zhang@amd.com>
> *Cc:* Chen, Guchun <Guchun.Chen@amd.com>
> *Subject:* Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset 
> support for XGMI
>
> Thanks Ma, this was very helpful as I am sill not able to setup XGMI 
> hive with latest FW and VBIOS.
>
> I traced the workqueue subsystem (full log attached). Specifically 
> here is the life cycle of our 2 work items executing 
> amdgpu_device_xgmi_reset_func bellow
>
> [Le]: Thanks Andrey for the deep debug. Your feedback gave me a more 
> profound understanding on this case. My comments split as below.
>
> You were right to note they both run on came CPU (32) but they are 
> executed by different threads. Also as you see by 
> workqueue_execute_start/end timestamps they actually ran in parallel 
> and not one after another even while being assigned to the same CPU 
> and that because of thread preemption (there is at least 
> psp_v11_0_mode1_reset->msleep(500)) which yields the CPU and hence 
> allows the second work to run + I am sure that on preemptive kernel 
> one reset work would be preempted at some point anyway  and let the 
> other run.
>
> [Le]: Yes, from the trace log, the xgmi_reset_func items are assigned 
> to different work threads bound to one same CPU. And you are right 
> that cpu preemption will happen when msleep called which yield the CPU 
> to allow second work to run. That’s a great founding😊. But it’s not a 
> *real* parallel run to me because second work can only preempt to run 
> when first work go to sleep. I made an experiment here to change this 
> unique msleep to udelay, then second work item will run after first 
> item finished in a serial execuation.
>

I would expect in kernel compiled with preemption support that a running 
thread would be interrupted to let others run even when he is not 
voluntarily yields the CPU so this is strange.


> Now you had issues with BACO reset while the test I ran on your system 
> is mode1 reset and so I assumed that maybe BACO has some non 
> preempt-able busy wait which doesn't give a chance to second work 
> item's thread to run on that CPU before the first finished - but from 
> looking in the code I see smu_v11_0_baco_enter->msleep(10) so even in 
> that case the first reset work item was supposed to yield CPU after 
> BACO ENTER sent to SMU and let the other reset work do the same to the 
> second card and so i don't see how even in this case there is a serial 
> execution ?
>
> [Le]: VG20 uses old powerplay framework 
> (smu_v11_0_baco_enter->msleep(10) in swSMU framework), so no msleep 
> and no CPU preemption. BACO reset has Enter/Exit 2 phases. We expect 
> all the XGMI nodes enter BACO simultaneously instead of one after one 
> as a serial execution, then exit BACO simultaneously.
>

Well, we always can add something like bellow to force each XGMI reset 
work to let others run before going into BACO exit. We can also 
guarantee that all of the reset works will execute BACO ENTER before 
proceeding to BACO EXIT by using some kind of semaphore barrier along 
the line of this - 
https://stackoverflow.com/questions/47522174/reusable-barrier-implementation-using-posix-semaphores. 
This will also solve the #XGMI_NODES > #CPUs use case.


diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c 
b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 48649f5..3e91e54 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -531,6 +531,8 @@ static int soc15_asic_baco_reset(struct 
amdgpu_device *adev)
                 if (pp_funcs->set_asic_baco_state(pp_handle, 1))
                         return -EIO;

+               yield();
+
                 /* exit BACO state */
                 if (pp_funcs->set_asic_baco_state(pp_handle, 0))
                         return -EIO;


> P.S How you solution solves the case where the XGMI hive is bigger 
> then number of CPUs on the system ? Assuming that what you say is 
> correct and there is a serial execution when on the same CPU, if they 
> hive is bigger then number of CPUs you will eventually get back to 
> sending reset work to a CPU already executing BACO ENTER (or EXIT) for 
> another device and will get the serialization problem anyway.
>
> [Le]: Yeah, I also considered the situation that XGMI hive bigger than 
> CPU NR. I think it’s an extreme situation and should not exist. 
> However, assuming it exists, many work items scatter in several CPUs 
> will be executed faster than bound to one same CPU, isn’t it ?
>

AFAIK it's enough for even single one node in the hive to to fail the 
enter the BACO state on time to fail the entire hive reset procedure, no ?

Any way - I see our discussion blocks your entire patch set - I think 
you can go ahead and commit yours way (I think you got an RB from 
Hawking) and I will look then and see if I can implement my method and 
if it works will just revert your patch.

Andrey


>              cat-3002  [032] d... 33153.791829: workqueue_queue_work: 
> work struct=00000000e43c1ebb function=amdgpu_device_xgmi_reset_func 
> [amdgpu] workqueue=0000000080331d91 req_cpu=8192 cpu=32
>              cat-3002  [032] d... 33153.791829: 
> workqueue_activate_work: work struct 00000000e43c1ebb
>              cat-3002  [032] dN.. 33153.791831: workqueue_queue_work: 
> work struct=00000000e67113aa function=amdgpu_device_xgmi_reset_func 
> [amdgpu] workqueue=0000000080331d91 req_cpu=8192 cpu=32
>              cat-3002  [032] dN.. 33153.791832: 
> workqueue_activate_work: work struct 00000000e67113aa
>    kworker/32:1H-551   [032] .... 33153.791834: 
> workqueue_execute_start: work struct 00000000e43c1ebb: function 
> amdgpu_device_xgmi_reset_func [amdgpu]
>    kworker/32:0H-175   [032] .... 33153.792087: 
> workqueue_execute_start: work struct 00000000e67113aa: function 
> amdgpu_device_xgmi_reset_func [amdgpu]
>    kworker/32:1H-551   [032] .... 33154.310948: workqueue_execute_end: 
> work struct 00000000e43c1ebb
>    kworker/32:0H-175   [032] .... 33154.311043: workqueue_execute_end: 
> work struct 00000000e67113aa
>
> Andrey
>
> On 12/3/19 5:06 AM, Ma, Le wrote:
>
>     [AMD Official Use Only - Internal Distribution Only]
>
>     Hi Andrey,
>
>     You can try the XGMI system below:
>
>     IP: 10.67.69.53
>
>     U/P: jenkins/0
>
>     The original drm-next kernel is installed.
>
>     Regards,
>
>     Ma Le
>
>     *From:*Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>     <mailto:Andrey.Grodzovsky@amd.com>
>     *Sent:* Tuesday, December 3, 2019 6:05 AM
>     *To:* Ma, Le <Le.Ma@amd.com> <mailto:Le.Ma@amd.com>;
>     amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>     *Cc:* Chen, Guchun <Guchun.Chen@amd.com>
>     <mailto:Guchun.Chen@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
>     <mailto:Tao.Zhou1@amd.com>; Deucher, Alexander
>     <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com>;
>     Li, Dennis <Dennis.Li@amd.com> <mailto:Dennis.Li@amd.com>; Zhang,
>     Hawking <Hawking.Zhang@amd.com> <mailto:Hawking.Zhang@amd.com>
>     *Subject:* Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset
>     support for XGMI
>
>     On 12/2/19 6:42 AM, Ma, Le wrote:
>
>         [AMD Official Use Only - Internal Distribution Only]
>
>         *From:*Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>         <mailto:Andrey.Grodzovsky@amd.com>
>         *Sent:* Saturday, November 30, 2019 12:22 AM
>         *To:* Ma, Le <Le.Ma@amd.com> <mailto:Le.Ma@amd.com>;
>         amd-gfx@lists.freedesktop.org
>         <mailto:amd-gfx@lists.freedesktop.org>
>         *Cc:* Chen, Guchun <Guchun.Chen@amd.com>
>         <mailto:Guchun.Chen@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
>         <mailto:Tao.Zhou1@amd.com>; Deucher, Alexander
>         <Alexander.Deucher@amd.com>
>         <mailto:Alexander.Deucher@amd.com>; Li, Dennis
>         <Dennis.Li@amd.com> <mailto:Dennis.Li@amd.com>; Zhang, Hawking
>         <Hawking.Zhang@amd.com> <mailto:Hawking.Zhang@amd.com>
>         *Subject:* Re: [PATCH 07/10] drm/amdgpu: add concurrent baco
>         reset support for XGMI
>
>         On 11/28/19 4:00 AM, Ma, Le wrote:
>
>             -----Original Message-----
>             From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>             <mailto:Andrey.Grodzovsky@amd.com>
>             Sent: Wednesday, November 27, 2019 11:46 PM
>             To: Ma, Le <Le.Ma@amd.com> <mailto:Le.Ma@amd.com>;
>             amd-gfx@lists.freedesktop.org
>             <mailto:amd-gfx@lists.freedesktop.org>
>             Cc: Chen, Guchun <Guchun.Chen@amd.com>
>             <mailto:Guchun.Chen@amd.com>; Zhou1, Tao
>             <Tao.Zhou1@amd.com> <mailto:Tao.Zhou1@amd.com>; Deucher,
>             Alexander <Alexander.Deucher@amd.com>
>             <mailto:Alexander.Deucher@amd.com>; Li, Dennis
>             <Dennis.Li@amd.com> <mailto:Dennis.Li@amd.com>; Zhang,
>             Hawking <Hawking.Zhang@amd.com> <mailto:Hawking.Zhang@amd.com>
>             Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco
>             reset support for XGMI
>
>             On 11/27/19 4:15 AM, Le Ma wrote:
>
>             > Currently each XGMI node reset wq does not run in
>             parrallel because
>
>             > same work item bound to same cpu runs in sequence. So
>             change to bound
>
>             > the xgmi_reset_work item to different cpus.
>
>             It's not the same work item, see more bellow
>
>             >
>
>             > XGMI requires all nodes enter into baco within very
>             close proximity
>
>             > before any node exit baco. So schedule the
>             xgmi_reset_work wq twice
>
>             > for enter/exit baco respectively.
>
>             >
>
>             > The default reset code path and methods do not change
>             for vega20 production:
>
>             >    - baco reset without xgmi/ras
>
>             >    - psp reset with xgmi/ras
>
>             >
>
>             > To enable baco for XGMI/RAS case, both 2 conditions
>             below are needed:
>
>             >    - amdgpu_ras_enable=2
>
>             >    - baco-supported smu firmware
>
>             >
>
>             > The case that PSP reset and baco reset coexist within an
>             XGMI hive is
>
>             > not in the consideration.
>
>             >
>
>             > Change-Id: I9c08cf90134f940b42e20d2129ff87fba761c532
>
>             > Signed-off-by: Le Ma <le.ma@amd.com <mailto:le.ma@amd.com>>
>
>             > ---
>
>             > drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +
>
>             > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 78
>             ++++++++++++++++++++++++++----
>
>             >   2 files changed, 70 insertions(+), 10 deletions(-)
>
>             >
>
>             > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>
>             > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>
>             > index d120fe5..08929e6 100644
>
>             > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>
>             > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>
>             > @@ -998,6 +998,8 @@ struct amdgpu_device {
>
>             > int                                           pstate;
>
>             >          /* enable runtime pm on the device */
>
>             > bool                            runpm;
>
>             > +
>
>             > + bool                                        in_baco;
>
>             >   };
>
>             >
>
>             >   static inline struct amdgpu_device
>             *amdgpu_ttm_adev(struct
>
>             > ttm_bo_device *bdev) diff --git
>
>             > a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>
>             > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>
>             > index bd387bb..71abfe9 100644
>
>             > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>
>             > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>
>             > @@ -2654,7 +2654,13 @@ static void
>             amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>
>             >          struct amdgpu_device *adev =
>
>             > container_of(__work, struct amdgpu_device, xgmi_reset_work);
>
>             >
>
>             > - adev->asic_reset_res =  amdgpu_asic_reset(adev);
>
>             > +      if (amdgpu_asic_reset_method(adev) ==
>             AMD_RESET_METHOD_BACO)
>
>             > + adev->asic_reset_res = (adev->in_baco == false) ?
>
>             > + amdgpu_device_baco_enter(adev->ddev) :
>
>             > + amdgpu_device_baco_exit(adev->ddev);
>
>             > +      else
>
>             > + adev->asic_reset_res = amdgpu_asic_reset(adev);
>
>             > +
>
>             >          if (adev->asic_reset_res)
>
>             > DRM_WARN("ASIC reset failed with error, %d for drm dev, %s",
>
>             >                                 adev->asic_reset_res,
>             adev->ddev->unique); @@ -3796,6 +3802,7 @@
>
>             > static int amdgpu_do_asic_reset(struct amdgpu_hive_info
>             *hive,
>
>             >          struct amdgpu_device *tmp_adev = NULL;
>
>             >          bool need_full_reset = *need_full_reset_arg,
>             vram_lost = false;
>
>             >          int r = 0;
>
>             > +      int cpu = smp_processor_id();
>
>             >
>
>             >          /*
>
>             >           * ASIC reset has to be done on all HGMI hive
>             nodes ASAP @@
>
>             > -3803,21 +3810,24 @@ static int
>             amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>
>             >           */
>
>             >          if (need_full_reset) {
>
>             > list_for_each_entry(tmp_adev, device_list_handle,
>             gmc.xgmi.head) {
>
>             > -                               /* For XGMI run all
>             resets in parallel to speed up the process */
>
>             > +                              /*
>
>             > +                              * For XGMI run all resets
>             in parallel to speed up the
>
>             > +                              * process by scheduling
>             the highpri wq on different
>
>             > +                              * cpus. For XGMI with
>             baco reset, all nodes must enter
>
>             > +                              * baco within close
>             proximity before anyone exit.
>
>             > +                              */
>
>             >                                if
>             (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
>
>             > -                                           if
>             (!queue_work(system_highpri_wq, &tmp_adev->xgmi_reset_work))
>
>             Note that tmp_adev->xgmi_reset_work (the work item) is per
>             device in XGMI hive and not the same work item. So I don't
>             see why you need to explicitly queue them on different
>             CPUs, they should run in parallel already.
>
>             Andrey
>
>             [Le]: It’s also beyond my understanding that the 2 node
>             reset work items scheduled to same cpu does not run in
>             parallel. But from the experiment result in my side, the
>             2nd work item always run after 1st work item finished.
>             Based on this result, I changed to queue them on different
>             CPUs to make sure more XGMI nodes case to run in parallel,
>             because baco requires all nodes enter baco within very
>             close proximity.
>
>             The experiment code is as following for your reference.
>             When card0 worker running, card1 worker is not observed to
>             run.
>
>         The code bellow will only test that they don't run
>         concurrently - but this doesn't mean they don't run on
>         different CPUs and threads,I don't have an XGMI setup at hand
>         to test this theory but what if there is some locking
>         dependency between them that serializes their execution ? Can
>         you just add a one line print inside
>         amdgpu_device_xgmi_reset_func that prints CPU id, thread
>         name/id and card number ?
>
>         Andrey
>
>         [Le]: I checked if directly use queue_work() several times,
>         the same CPU thread will be used. And the worker per CPU will
>         execute the item one by one. Our goal here is to make the
>         xgmi_reset_func run concurrently for XGMI BACO case. That’s
>         why I schedule them on different CPUs to run parallelly. And I
>         can share the XGMI system with you if you’d like to verify more.
>
>     I tried today to setup XGMI 2P setup to test this but weren't able
>     to load with the XGMI bridge in place (maybe faulty bridge) - so
>     yea - maybe leave me your setup before your changes (the original
>     code) so i can try to open some kernel traces that show CPU id and
>     thread id to check this. It's just so weird that system_highpri_wq
>     which is documented to be multi-cpu and multi-threaded wouldn't
>     queue those work items to different cpus and worker threads.
>
>     Andrey
>
>             +atomic_t card0_in_baco = ATOMIC_INIT(0);
>
>             +atomic_t card1_in_baco = ATOMIC_INIT(0);
>
>             +
>
>             static void amdgpu_device_xgmi_reset_func(struct
>             work_struct *__work)
>
>             {
>
>             struct amdgpu_device *adev =
>
>             container_of(__work, struct amdgpu_device, xgmi_reset_work);
>
>             + printk("lema1: card 0x%x goes into reset wq\n",
>             adev->pdev->bus->number);
>
>             + if (adev->pdev->bus->number == 0x7) {
>
>             + atomic_set(&card1_in_baco, 1);
>
>             + printk("lema1: card1 in baco from card1 view\n");
>
>             + }
>
>             +
>
>             if (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)
>
>                            adev->asic_reset_res = (adev->in_baco ==
>             false) ?
>
>             amdgpu_device_baco_enter(adev->ddev) :
>
>             @@ -2664,6 +2673,23 @@ static void
>             amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>
>             if (adev->asic_reset_res)
>
>             DRM_WARN("ASIC reset failed with error, %d for drm dev, %s",
>
>             adev->asic_reset_res, adev->ddev->unique);
>
>             +
>
>             + if (adev->pdev->bus->number == 0x4) {
>
>             + atomic_set(&card0_in_baco, 1);
>
>             +        printk("lema1: card0 in baco from card0 view\n");
>
>             +
>
>             + while (true)
>
>             + if (!!atomic_read(&card1_in_baco))
>
>             + break;
>
>             + printk("lema1: card1 in baco from card0 view\n");
>
>             +     }
>
>             +
>
>             + if (adev->pdev->bus->number == 0x7) {
>
>             + while (true)
>
>             + if (!!atomic_read(&card0_in_baco))
>
>             + break;
>
>             + printk("lema1: card0 in baco from card1 view\n");
>
>             + }
>
>             > +                                          if
>             (!queue_work_on(cpu, system_highpri_wq,
>
>             > +    &tmp_adev->xgmi_reset_work))
>
>             >                                                        r
>             = -EALREADY;
>
>             > +                                          cpu =
>             cpumask_next(cpu, cpu_online_mask);
>
>             >                                } else
>
>             >                                            r =
>             amdgpu_asic_reset(tmp_adev);
>
>             > -
>
>             > -                               if (r) {
>
>             > - DRM_ERROR("ASIC reset failed with error, %d for drm
>             dev, %s",
>
>             > - r, tmp_adev->ddev->unique);
>
>             > +                              if (r)
>
>             >                                            break;
>
>             > -                               }
>
>             >                      }
>
>             >
>
>             > -                   /* For XGMI wait for all PSP resets
>             to complete before proceed */
>
>             > +                  /* For XGMI wait for all work to
>             complete before proceed */
>
>             >                      if (!r) {
>
>             > list_for_each_entry(tmp_adev, device_list_handle,
>
>             >     gmc.xgmi.head) {
>
>             > @@ -3826,11 +3836,59 @@ static int
>             amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>
>             >                                                        r
>             = tmp_adev->asic_reset_res;
>
>             > if (r)
>
>             > break;
>
>             > + if(AMD_RESET_METHOD_BACO ==
>
>             > +    amdgpu_asic_reset_method(tmp_adev))
>
>             > + tmp_adev->in_baco = true;
>
>             >                                            }
>
>             >                                }
>
>             >                      }
>
>             > -       }
>
>             >
>
>             > +                  /*
>
>             > +                  * For XGMI with baco reset, need exit
>             baco phase by scheduling
>
>             > +                  * xgmi_reset_work one more time. PSP
>             reset skips this phase.
>
>             > +                  * Not assume the situation that PSP
>             reset and baco reset
>
>             > +                  * coexist within an XGMI hive.
>
>             > +                  */
>
>             > +
>
>             > +                  if (!r) {
>
>             > +                              cpu = smp_processor_id();
>
>             > + list_for_each_entry(tmp_adev, device_list_handle,
>
>             > +     gmc.xgmi.head) {
>
>             > +                                          if
>             (tmp_adev->gmc.xgmi.num_physical_nodes > 1
>
>             > + && AMD_RESET_METHOD_BACO ==
>
>             > + amdgpu_asic_reset_method(tmp_adev)) {
>
>             > + if (!queue_work_on(cpu,
>
>             > + system_highpri_wq,
>
>             > +             &tmp_adev->xgmi_reset_work))
>
>             > + r = -EALREADY;
>
>             > + if (r)
>
>             > + break;
>
>             > + cpu = cpumask_next(cpu, cpu_online_mask);
>
>             > +                                          }
>
>             > +                              }
>
>             > +                  }
>
>             > +
>
>             > +                  if (!r) {
>
>             > + list_for_each_entry(tmp_adev, device_list_handle,
>
>             > +     gmc.xgmi.head) {
>
>             > +                                          if
>             (tmp_adev->gmc.xgmi.num_physical_nodes > 1
>
>             > + && AMD_RESET_METHOD_BACO ==
>
>             > + amdgpu_asic_reset_method(tmp_adev)) {
>
>             > + flush_work(&tmp_adev->xgmi_reset_work);
>
>             > +                                                      r
>             = tmp_adev->asic_reset_res;
>
>             > + if (r)
>
>             > + break;
>
>             > + tmp_adev->in_baco = false;
>
>             > +                                          }
>
>             > +                              }
>
>             > +                  }
>
>             > +
>
>             > +                  if (r) {
>
>             > +                              DRM_ERROR("ASIC reset
>             failed with error, %d for drm dev, %s",
>
>             > +                                          r,
>             tmp_adev->ddev->unique);
>
>             > +                              goto end;
>
>             > +                  }
>
>             > +      }
>
>             >
>
>             > list_for_each_entry(tmp_adev, device_list_handle,
>             gmc.xgmi.head) {
>
>             >                      if (need_full_reset) {
>

--------------D09511E636D64ADDBEA6A351
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 12/4/19 2:09 AM, Ma, Le wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CH2PR12MB4278F9759EF24F29A85D7D23F65D0@CH2PR12MB4278.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Segoe UI Emoji";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:14.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
span.EmailStyle21
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle22
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle23
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle24
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="msipheadera92e061b" style="margin:0in;margin-bottom:.0001pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
            Official Use Only - Internal Distribution Only]</span><o:p></o:p></p>
        <p class="MsoNormal"><span style="color:windowtext"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext"><o:p>&nbsp;</o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span style="color:windowtext"> Grodzovsky, Andrey
                <a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky@amd.com">&lt;Andrey.Grodzovsky@amd.com&gt;</a>
                <br>
                <b>Sent:</b> Wednesday, December 4, 2019 2:44 AM<br>
                <b>To:</b> Ma, Le <a class="moz-txt-link-rfc2396E" href="mailto:Le.Ma@amd.com">&lt;Le.Ma@amd.com&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Zhou1, Tao
                <a class="moz-txt-link-rfc2396E" href="mailto:Tao.Zhou1@amd.com">&lt;Tao.Zhou1@amd.com&gt;</a>; Deucher, Alexander
                <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Li, Dennis
                <a class="moz-txt-link-rfc2396E" href="mailto:Dennis.Li@amd.com">&lt;Dennis.Li@amd.com&gt;</a>; Zhang, Hawking
                <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><br>
                <b>Cc:</b> Chen, Guchun <a class="moz-txt-link-rfc2396E" href="mailto:Guchun.Chen@amd.com">&lt;Guchun.Chen@amd.com&gt;</a><br>
                <b>Subject:</b> Re: [PATCH 07/10] drm/amdgpu: add
                concurrent baco reset support for XGMI<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p style="margin-left:.5in">Thanks Ma, this was very helpful as
          I am sill not able to setup XGMI hive with latest FW and
          VBIOS.<o:p></o:p></p>
        <p style="margin-left:.5in">I traced the workqueue subsystem
          (full log attached). Specifically here is the life cycle of
          our 2 work items executing amdgpu_device_xgmi_reset_func
          bellow<o:p></o:p></p>
        <p><span style="font-size:12.0pt;color:#203864">[Le]: Thanks
            Andrey for the deep debug. Your feedback gave me a more
            profound understanding on this case. My comments split as
            below.<o:p></o:p></span></p>
        <p style="margin-left:.5in">You were right to note they both run
          on came CPU (32) but they are executed by different threads.
          Also as you see by workqueue_execute_start/end timestamps they
          actually ran in parallel and not one after another even while
          being assigned to the same CPU and that because of thread
          preemption (there is at least
          psp_v11_0_mode1_reset-&gt;msleep(500)) which yields the CPU
          and hence allows the second work to run &#43; I am sure that on
          preemptive kernel one reset work would be preempted at some
          point anyway&nbsp; and let the other run. <o:p></o:p></p>
        <p><span style="font-size:12.0pt;color:#203864">[Le]: Yes, from
            the trace log, the xgmi_reset_func items are assigned to
            different work threads bound to one same CPU. And you are
            right that cpu preemption will happen when msleep called
            which yield the CPU to allow second work to run. That’s a
            great founding</span><span style="font-size:12.0pt;font-family:&quot;Segoe UI
            Emoji&quot;,sans-serif;color:#203864">😊</span><span style="font-size:12.0pt;color:#203864">. But it’s not a
            <b>real</b> parallel run to me because second work can only
            preempt to run when first work go to sleep. I made an
            experiment here to change this unique msleep to udelay, then
            second work item will run after first item finished in a
            serial execuation.</span></p>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>I would expect in kernel compiled with preemption support that a
      running thread would be interrupted to let others run even when he
      is not voluntarily yields the CPU so this is strange.</p>
    <p> <br>
    </p>
    <blockquote type="cite" cite="mid:CH2PR12MB4278F9759EF24F29A85D7D23F65D0@CH2PR12MB4278.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p><span style="font-size:12.0pt;color:#203864"><o:p></o:p></span></p>
        <p style="margin-left:.5in">Now you had issues with BACO reset
          while the test I ran on your system is mode1 reset and so I
          assumed that maybe BACO has some non preempt-able busy wait
          which doesn't give a chance to second work item's thread to
          run on that CPU before the first finished - but from looking
          in the code I see smu_v11_0_baco_enter-&gt;msleep(10) so even
          in that case the first reset work item was supposed to yield
          CPU after BACO ENTER sent to SMU and let the other reset work
          do the same to the second card and so i don't see how even in
          this case there is a serial execution ?<o:p></o:p></p>
        <p><span style="font-size:12.0pt;color:#203864">[Le]: VG20 uses
            old powerplay framework (</span><span style="color:#203864">smu_v11_0_baco_enter-&gt;msleep(10)
            in swSMU framework</span><span style="font-size:12.0pt;color:#203864">), so no msleep and
            no CPU preemption. BACO reset has Enter/Exit 2 phases. We
            expect all the XGMI nodes enter BACO simultaneously instead
            of one after one as a serial execution, then exit BACO
            simultaneously.</span></p>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Well, we always can add something like bellow to force each XGMI
      reset work to let others run before going into BACO exit. We can
      also guarantee that all of the reset works will execute BACO ENTER
      before proceeding to BACO EXIT by using some kind of semaphore
      barrier along the line of this -
<a class="moz-txt-link-freetext" href="https://stackoverflow.com/questions/47522174/reusable-barrier-implementation-using-posix-semaphores">https://stackoverflow.com/questions/47522174/reusable-barrier-implementation-using-posix-semaphores</a>.
      This will also solve the #XGMI_NODES &gt; #CPUs use case.<br>
    </p>
    <p><br>
    </p>
    <p>diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
      b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
      index 48649f5..3e91e54 100644<br>
      --- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
      &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
      @@ -531,6 &#43;531,8 @@ static int soc15_asic_baco_reset(struct
      amdgpu_device *adev)<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs-&gt;set_asic_baco_state(pp_handle,
      1))<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EIO;<br>
      &nbsp;<br>
      &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yield();<br>
      &#43;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* exit BACO state */<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs-&gt;set_asic_baco_state(pp_handle,
      0))<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EIO;<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:CH2PR12MB4278F9759EF24F29A85D7D23F65D0@CH2PR12MB4278.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p><span style="font-size:12.0pt;color:#203864"><o:p></o:p></span></p>
        <p style="margin-left:.5in">P.S How you solution solves the case
          where the XGMI hive is bigger then number of CPUs on the
          system ? Assuming that what you say is correct and there is a
          serial execution when on the same CPU, if they hive is bigger
          then number of CPUs you will eventually get back to sending
          reset work to a CPU already executing BACO ENTER (or EXIT) for
          another device and will get the serialization problem anyway.
          <o:p></o:p></p>
        <p><span style="font-size:12.0pt;color:#203864">[Le]: Yeah, I
            also considered the situation that XGMI hive bigger than CPU
            NR. I think it’s an extreme situation and should not exist.
            However, assuming it exists, many work items scatter in
            several CPUs will be executed faster than bound to one same
            CPU, isn’t it ?</span></p>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>AFAIK it's enough for even single one node in the hive to to fail
      the enter the BACO state on time to fail the entire hive reset
      procedure, no ?</p>
    <p>Any way - I see our discussion blocks your entire patch set - I
      think you can go ahead and commit yours way (I think you got an RB
      from Hawking) and I will look then and see if I can implement my
      method and if it works will just revert your patch.<br>
    </p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:CH2PR12MB4278F9759EF24F29A85D7D23F65D0@CH2PR12MB4278.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p><span style="font-size:12.0pt;color:#203864"><o:p></o:p></span></p>
        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cat-3002&nbsp; [032] d... 33153.791829:
          workqueue_queue_work: work struct=00000000e43c1ebb
          function=amdgpu_device_xgmi_reset_func [amdgpu]
          workqueue=0000000080331d91 req_cpu=8192 cpu=32<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cat-3002&nbsp; [032] d... 33153.791829:
          workqueue_activate_work: work struct 00000000e43c1ebb<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cat-3002&nbsp; [032] dN.. 33153.791831:
          workqueue_queue_work: work struct=00000000e67113aa
          function=amdgpu_device_xgmi_reset_func [amdgpu]
          workqueue=0000000080331d91 req_cpu=8192 cpu=32<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cat-3002&nbsp; [032] dN.. 33153.791832:
          workqueue_activate_work: work struct 00000000e67113aa<br>
          &nbsp;&nbsp; kworker/32:1H-551&nbsp;&nbsp; [032] .... 33153.791834:
          workqueue_execute_start: work struct 00000000e43c1ebb:
          function amdgpu_device_xgmi_reset_func [amdgpu]<br>
          &nbsp;&nbsp; kworker/32:0H-175&nbsp;&nbsp; [032] .... 33153.792087:
          workqueue_execute_start: work struct 00000000e67113aa:
          function amdgpu_device_xgmi_reset_func [amdgpu]<br>
          &nbsp;&nbsp; kworker/32:1H-551&nbsp;&nbsp; [032] .... 33154.310948:
          workqueue_execute_end: work struct 00000000e43c1ebb<br>
          &nbsp;&nbsp; kworker/32:0H-175&nbsp;&nbsp; [032] .... 33154.311043:
          workqueue_execute_end: work struct 00000000e67113aa<o:p></o:p></p>
        <p>Andrey<o:p></o:p></p>
        <p><o:p>&nbsp;</o:p></p>
        <p><o:p>&nbsp;</o:p></p>
        <div>
          <p class="MsoNormal">On 12/3/19 5:06 AM, Ma, Le wrote:<o:p></o:p></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="msipheadera92e061b" style="margin:0in;margin-bottom:.0001pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
              Official Use Only - Internal Distribution Only]</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="color:windowtext">&nbsp;</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">Hi Andrey,</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">&nbsp;</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">You can try the
              XGMI system below:</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              IP: 10.67.69.53</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              U/P: jenkins/0</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">&nbsp;</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">The original
              drm-next kernel is installed.</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">&nbsp;</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">Regards,</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">Ma Le</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">&nbsp;</span><o:p></o:p></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span style="color:windowtext"> Grodzovsky, Andrey
                  <a href="mailto:Andrey.Grodzovsky@amd.com" moz-do-not-send="true">&lt;Andrey.Grodzovsky@amd.com&gt;</a>
                  <br>
                  <b>Sent:</b> Tuesday, December 3, 2019 6:05 AM<br>
                  <b>To:</b> Ma, Le <a href="mailto:Le.Ma@amd.com" moz-do-not-send="true">&lt;Le.Ma@amd.com&gt;</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                    amd-gfx@lists.freedesktop.org</a><br>
                  <b>Cc:</b> Chen, Guchun <a href="mailto:Guchun.Chen@amd.com" moz-do-not-send="true">&lt;Guchun.Chen@amd.com&gt;</a>;
                  Zhou1, Tao
                  <a href="mailto:Tao.Zhou1@amd.com" moz-do-not-send="true">&lt;Tao.Zhou1@amd.com&gt;</a>;
                  Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">
                    &lt;Alexander.Deucher@amd.com&gt;</a>; Li, Dennis <a href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">&lt;Dennis.Li@amd.com&gt;</a>;
                  Zhang, Hawking
                  <a href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">&lt;Hawking.Zhang@amd.com&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH 07/10] drm/amdgpu: add
                  concurrent baco reset support for XGMI</span><o:p></o:p></p>
            </div>
          </div>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p>&nbsp;<o:p></o:p></p>
          <div>
            <p class="MsoNormal">On 12/2/19 6:42 AM, Ma, Le wrote:<o:p></o:p></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="msipheadera92e061b" style="margin:0in;margin-bottom:.0001pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
                Official Use Only - Internal Distribution Only]</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext">&nbsp;</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">&nbsp;</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:windowtext">&nbsp;</span><o:p></o:p></p>
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span style="color:windowtext"> Grodzovsky, Andrey
                    <a href="mailto:Andrey.Grodzovsky@amd.com" moz-do-not-send="true">&lt;Andrey.Grodzovsky@amd.com&gt;</a>
                    <br>
                    <b>Sent:</b> Saturday, November 30, 2019 12:22 AM<br>
                    <b>To:</b> Ma, Le <a href="mailto:Le.Ma@amd.com" moz-do-not-send="true">&lt;Le.Ma@amd.com&gt;</a>;
                    <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                      amd-gfx@lists.freedesktop.org</a><br>
                    <b>Cc:</b> Chen, Guchun <a href="mailto:Guchun.Chen@amd.com" moz-do-not-send="true">&lt;Guchun.Chen@amd.com&gt;</a>;
                    Zhou1, Tao
                    <a href="mailto:Tao.Zhou1@amd.com" moz-do-not-send="true">&lt;Tao.Zhou1@amd.com&gt;</a>;
                    Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">
                      &lt;Alexander.Deucher@amd.com&gt;</a>; Li, Dennis
                    <a href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">&lt;Dennis.Li@amd.com&gt;</a>;
                    Zhang, Hawking
                    <a href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">&lt;Hawking.Zhang@amd.com&gt;</a><br>
                    <b>Subject:</b> Re: [PATCH 07/10] drm/amdgpu: add
                    concurrent baco reset support for XGMI</span><o:p></o:p></p>
              </div>
            </div>
            <p class="MsoNormal">&nbsp;<o:p></o:p></p>
            <p>&nbsp;<o:p></o:p></p>
            <div>
              <p class="MsoNormal">On 11/28/19 4:00 AM, Ma, Le wrote:<o:p></o:p></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">-----Original Message-----<br>
                From: Grodzovsky, Andrey <a href="mailto:Andrey.Grodzovsky@amd.com" moz-do-not-send="true">&lt;Andrey.Grodzovsky@amd.com&gt;</a>
                <br>
                Sent: Wednesday, November 27, 2019 11:46 PM<br>
                To: Ma, Le <a href="mailto:Le.Ma@amd.com" moz-do-not-send="true">&lt;Le.Ma@amd.com&gt;</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                  amd-gfx@lists.freedesktop.org</a><br>
                Cc: Chen, Guchun <a href="mailto:Guchun.Chen@amd.com" moz-do-not-send="true">&lt;Guchun.Chen@amd.com&gt;</a>;
                Zhou1, Tao
                <a href="mailto:Tao.Zhou1@amd.com" moz-do-not-send="true">&lt;Tao.Zhou1@amd.com&gt;</a>;
                Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">
                  &lt;Alexander.Deucher@amd.com&gt;</a>; Li, Dennis <a href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">&lt;Dennis.Li@amd.com&gt;</a>;
                Zhang, Hawking
                <a href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">&lt;Hawking.Zhang@amd.com&gt;</a><br>
                Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent
                baco reset support for XGMI<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">On 11/27/19 4:15 AM, Le Ma wrote:<o:p></o:p></p>
              <p class="MsoPlainText">&gt; Currently each XGMI node
                reset wq does not run in parrallel because
                <o:p></o:p></p>
              <p class="MsoPlainText">&gt; same work item bound to same
                cpu runs in sequence. So change to bound
                <o:p></o:p></p>
              <p class="MsoPlainText">&gt; the xgmi_reset_work item to
                different cpus.<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">It's not the same work item, see
                more bellow<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; XGMI requires all nodes enter
                into baco within very close proximity
                <o:p></o:p></p>
              <p class="MsoPlainText">&gt; before any node exit baco. So
                schedule the xgmi_reset_work wq twice
                <o:p></o:p></p>
              <p class="MsoPlainText">&gt; for enter/exit baco
                respectively.<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; The default reset code path
                and methods do not change for vega20 production:<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp; - baco reset without
                xgmi/ras<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp; - psp reset with xgmi/ras<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; To enable baco for XGMI/RAS
                case, both 2 conditions below are needed:<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp; - amdgpu_ras_enable=2<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp; - baco-supported smu
                firmware<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; The case that PSP reset and
                baco reset coexist within an XGMI hive is
                <o:p></o:p></p>
              <p class="MsoPlainText">&gt; not in the consideration.<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; Change-Id:
                I9c08cf90134f940b42e20d2129ff87fba761c532<o:p></o:p></p>
              <p class="MsoPlainText">&gt; Signed-off-by: Le Ma &lt;<a href="mailto:le.ma@amd.com" moz-do-not-send="true"><span style="color:windowtext;text-decoration:none">le.ma@amd.com</span></a>&gt;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; ---<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;
                drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#43;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;
                drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 78
                &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; 2 files changed, 70
                insertions(&#43;), 10 deletions(-)<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></p>
              <p class="MsoPlainText">&gt; index d120fe5..08929e6 100644<o:p></o:p></p>
              <p class="MsoPlainText">&gt; ---
                a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&#43;&#43;
                b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></p>
              <p class="MsoPlainText">&gt; @@ -998,6 &#43;998,8 @@ struct
                amdgpu_device {<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable runtime pm
                on the device */<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; runpm;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_baco;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; };<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; static inline struct
                amdgpu_device *amdgpu_ttm_adev(struct
                <o:p></o:p></p>
              <p class="MsoPlainText">&gt; ttm_bo_device *bdev) diff
                --git <o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p></o:p></p>
              <p class="MsoPlainText">&gt; index bd387bb..71abfe9 100644<o:p></o:p></p>
              <p class="MsoPlainText">&gt; ---
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&#43;&#43;
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p></o:p></p>
              <p class="MsoPlainText">&gt; @@ -2654,7 &#43;2654,13 @@ static
                void amdgpu_device_xgmi_reset_func(struct work_struct
                *__work)<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device
                *adev =<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                container_of(__work, struct amdgpu_device,
                xgmi_reset_work);<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
              <p class="MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;asic_reset_res =&nbsp; amdgpu_asic_reset(adev);<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                (amdgpu_asic_reset_method(adev) ==
                AMD_RESET_METHOD_BACO)<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;asic_reset_res = (adev-&gt;in_baco == false) ?<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                amdgpu_device_baco_enter(adev-&gt;ddev) :<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                amdgpu_device_baco_exit(adev-&gt;ddev);<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;asic_reset_res = amdgpu_asic_reset(adev);<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                (adev-&gt;asic_reset_res)<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                DRM_WARN(&quot;ASIC reset failed with error, %d for drm dev,
                %s&quot;,<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;adev-&gt;asic_reset_res,
                adev-&gt;ddev-&gt;unique); @@ -3796,6 &#43;3802,7 @@
                <o:p></o:p></p>
              <p class="MsoPlainText">&gt; static int
                amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device
                *tmp_adev = NULL;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_full_reset
                = *need_full_reset_arg, vram_lost = false;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int cpu =
                smp_processor_id();<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* ASIC reset has to
                be done on all HGMI hive nodes ASAP @@
                <o:p></o:p></p>
              <p class="MsoPlainText">&gt; -3803,21 &#43;3810,24 @@ static
                int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;*/<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (need_full_reset)
                {<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                list_for_each_entry(tmp_adev, device_list_handle,
                gmc.xgmi.head) {<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For XGMI run all
                resets in parallel to speed up the process */<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For XGMI run all resets
                in parallel to speed up the<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * process by scheduling
                the highpri wq on different<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * cpus. For XGMI with
                baco reset, all nodes must enter<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * baco within close
                proximity before anyone exit.<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                (tmp_adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1) {<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                (!queue_work(system_highpri_wq,
                &amp;tmp_adev-&gt;xgmi_reset_work))<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">Note that
                tmp_adev-&gt;xgmi_reset_work (the work item) is per
                device in XGMI hive and not the same work item. So I
                don't see why you need to explicitly queue them on
                different CPUs, they should run in parallel already.<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">Andrey<o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">[Le]:
                  It’s also beyond my understanding that the 2 node
                  reset work items scheduled to same cpu does not run in
                  parallel. But from the experiment result in my side,
                  the 2nd work item always run after 1st work item
                  finished. Based on this result, I changed to queue
                  them on different CPUs to make sure more XGMI nodes
                  case to run in parallel, because baco requires all
                  nodes enter baco within very close proximity.
                </span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&nbsp;</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">The
                  experiment code is as following for your reference.
                  When card0 worker running, card1 worker is not
                  observed to run.</span><o:p></o:p></p>
            </blockquote>
            <p>&nbsp;<o:p></o:p></p>
            <p>The code bellow will only test that they don't run
              concurrently - but this doesn't mean they don't run on
              different CPUs and threads,I don't have an XGMI setup at
              hand to test this theory but what if there is some locking
              dependency between them that serializes their execution ?
              Can you just add a one line print inside <span style="color:#203864">
                amdgpu_device_xgmi_reset_func </span>that prints CPU
              id, thread name/id and card number ?<o:p></o:p></p>
            <p>Andrey<o:p></o:p></p>
            <p><span style="color:#203864">[Le]: I checked if directly
                use queue_work() several times, the same CPU thread will
                be used. And the worker per CPU will execute the item
                one by one. Our goal here is to make the xgmi_reset_func
                run concurrently for XGMI BACO case. That’s why I
                schedule them on different CPUs to run parallelly. And I
                can share the XGMI system with you if you’d like to
                verify more.</span><o:p></o:p></p>
          </blockquote>
          <p>&nbsp;<o:p></o:p></p>
          <p>I tried today to setup XGMI 2P setup to test this but
            weren't able to load with the XGMI bridge in place (maybe
            faulty bridge) - so yea - maybe leave me your setup before
            your changes (the original code) so i can try to open some
            kernel traces that show CPU id and thread id to check this.
            It's just so weird that system_highpri_wq which is
            documented to be multi-cpu and multi-threaded wouldn't queue
            those work items to different cpus and worker threads.<o:p></o:p></p>
          <p>Andrey<o:p></o:p></p>
          <p>&nbsp;<o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p class="MsoPlainText"><span style="color:#203864">&nbsp;</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;atomic_t
                  card0_in_baco = ATOMIC_INIT(0);</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;atomic_t
                  card1_in_baco = ATOMIC_INIT(0);</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">static
                  void amdgpu_device_xgmi_reset_func(struct work_struct
                  *__work)</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">{</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  struct amdgpu_device *adev =</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  container_of(__work, struct amdgpu_device,
                  xgmi_reset_work);</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&nbsp;</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  printk(&quot;lema1: card 0x%x goes into reset wq\n&quot;,
                  adev-&gt;pdev-&gt;bus-&gt;number);</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  if (adev-&gt;pdev-&gt;bus-&gt;number == 0x7) {</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  atomic_set(&amp;card1_in_baco, 1);</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  printk(&quot;lema1: card1 in baco from card1 view\n&quot;);</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  }</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  if (amdgpu_asic_reset_method(adev) ==
                  AMD_RESET_METHOD_BACO)</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;adev-&gt;asic_reset_res
                  = (adev-&gt;in_baco == false) ?</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  amdgpu_device_baco_enter(adev-&gt;ddev) :</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">@@
                  -2664,6 &#43;2673,23 @@ static void
                  amdgpu_device_xgmi_reset_func(struct work_struct
                  *__work)</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  if (adev-&gt;asic_reset_res)</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  DRM_WARN(&quot;ASIC reset failed with error, %d for drm
                  dev, %s&quot;,</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  adev-&gt;asic_reset_res, adev-&gt;ddev-&gt;unique);</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  if (adev-&gt;pdev-&gt;bus-&gt;number == 0x4) {</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  atomic_set(&amp;card0_in_baco, 1);</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printk(&quot;lema1: card0 in baco from card0
                  view\n&quot;);</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  while (true)</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  if (!!atomic_read(&amp;card1_in_baco))</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  break;</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  printk(&quot;lema1: card1 in baco from card0 view\n&quot;);</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;
                  &nbsp;&nbsp;&nbsp;&nbsp;}</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  if (adev-&gt;pdev-&gt;bus-&gt;number == 0x7) {</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  while (true)</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  if (!!atomic_read(&amp;card0_in_baco))</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  break;</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  printk(&quot;lema1: card0 in baco from card1 view\n&quot;);</span><o:p></o:p></p>
              <p class="MsoPlainText"><span style="color:#203864">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  }</span><o:p></o:p></p>
              <p class="MsoPlainText">&nbsp;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                (!queue_work_on(cpu, system_highpri_wq,<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp; &amp;tmp_adev-&gt;xgmi_reset_work))<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r
                = -EALREADY;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu =
                cpumask_next(cpu, cpu_online_mask);<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                amdgpu_asic_reset(tmp_adev);<o:p></o:p></p>
              <p class="MsoPlainText">&gt; -<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                DRM_ERROR(&quot;ASIC reset failed with error, %d for drm dev,
                %s&quot;,<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                r, tmp_adev-&gt;ddev-&gt;unique);<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
              <p class="MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For
                XGMI wait for all PSP resets to complete before proceed
                */<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For
                XGMI wait for all work to complete before proceed */<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)
                {<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                list_for_each_entry(tmp_adev, device_list_handle,<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;gmc.xgmi.head) {<o:p></o:p></p>
              <p class="MsoPlainText">&gt; @@ -3826,11 &#43;3836,59 @@
                static int amdgpu_do_asic_reset(struct amdgpu_hive_info
                *hive,<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r
                = tmp_adev-&gt;asic_reset_res;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                if (r)<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                break;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                if(AMD_RESET_METHOD_BACO ==<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp; amdgpu_asic_reset_method(tmp_adev))<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                tmp_adev-&gt;in_baco = true;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
              <p class="MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For XGMI
                with baco reset, need exit baco phase by scheduling<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *
                xgmi_reset_work one more time. PSP reset skips this
                phase.<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Not
                assume the situation that PSP reset and baco reset<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * coexist
                within an XGMI hive.<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu = smp_processor_id();<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                list_for_each_entry(tmp_adev, device_list_handle,<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp; gmc.xgmi.head) {<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                (tmp_adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                &amp;&amp; AMD_RESET_METHOD_BACO ==<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                amdgpu_asic_reset_method(tmp_adev)) {<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                if (!queue_work_on(cpu,<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                system_highpri_wq,<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;tmp_adev-&gt;xgmi_reset_work))<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                r = -EALREADY;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                if (r)<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                break;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                cpu = cpumask_next(cpu, cpu_online_mask);<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                list_for_each_entry(tmp_adev, device_list_handle,<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp; gmc.xgmi.head) {<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                (tmp_adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                &amp;&amp; AMD_RESET_METHOD_BACO ==<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                amdgpu_asic_reset_method(tmp_adev)) {<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                flush_work(&amp;tmp_adev-&gt;xgmi_reset_work);<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r
                = tmp_adev-&gt;asic_reset_res;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                if (r)<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                break;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                tmp_adev-&gt;in_baco = false;<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;ASIC reset
                failed with error, %d for drm dev, %s&quot;,<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r,
                tmp_adev-&gt;ddev-&gt;unique);<o:p></o:p></p>
              <p class="MsoPlainText">&gt;
                &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto end;<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
              <p class="MsoPlainText">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                list_for_each_entry(tmp_adev, device_list_handle,
                gmc.xgmi.head) {<o:p></o:p></p>
              <p class="MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                (need_full_reset) {<o:p></o:p></p>
            </blockquote>
          </blockquote>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>

--------------D09511E636D64ADDBEA6A351--

--===============1238137983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1238137983==--
