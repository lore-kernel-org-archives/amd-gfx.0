Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849AFC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 10:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D7AA10E5B3;
	Mon, 13 Dec 2021 10:09:58 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE8C110E5B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 10:09:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4ASrH+V7fi/rlcJLmQN4N4SoK44e/Rnnvwrh1Fd5/dhQ1HLxK+7vWp2e+qtiqyMBDktXVmgtNTvftQrymRK5AJI9iO/89sBVYbxsRq7LvbWBUFiSlgMeU7xINuA7VVPeAPVim78CTdbmiAsR48QaD5HxvoR/F+7YFZILVWA8CUXHMIVevvPjQOORlpvwE5DESnvooHHSPA01Pa/19310mW5kCzRZT348tnU/FeCVK8y6qZKyRGEnRqyUpINtY9Vcf4SF4Wc/T1lEhN1LrRe1SKR0j+CRLAaOOxEGqJKhlCv85WhsPrPkiMnU1S+AN1E59oQ3QmXP+PaT57QCC0rTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbTiqhNCH5LjYFnJMpRRGfFbDZVZn2a081zZwdC4tKY=;
 b=NAEJIASR1UhNXbytaNFwazxlS+eMAJyXGU3wJ7koviBb7dWwMeVWYRvaRSeFSjLvPh/ilGhrfesnRXiZ5XD1l+MsyTpdhsdAYLt1WmF7PjAXALP0pOE7A60upFGqZGiq7RfzAYvrQKXbgLu6nFcqEOmpZByHmigdhIZYryWUeDekEWGusCNcOsf8jqL5GU+WuSt6one1Wr7LcBfVXdC1K7eORBV+168QJvCeRGRgrDIX8Ncpi2JD8kUJwUVBzdjg6xkzi//cN8Fa2GQR9iDMuqYiqtwL8QrzwFityiM3hRu2dZohMwDCqbtx9fMKkLtPUjOnPEE++Ltuxv9OSD3J0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbTiqhNCH5LjYFnJMpRRGfFbDZVZn2a081zZwdC4tKY=;
 b=XrCqv+ihjblGrmNqvGb+jS3GPgFYd/uACjVgFAO2HcPHc2EBZVyP7GT7oWfuMT04ntnVelO/N6U3WjvX4PAW7XlXRS1OZhDU6Ist75g4lVwdqCQv/BR3KeXw3tJcLkam3NjOrId/972b2VPaTPZkkOdnCa6IqPWNJ5Nz3hacHXM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1868.namprd12.prod.outlook.com (2603:10b6:3:106::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Mon, 13 Dec 2021 10:09:54 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 10:09:54 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Gong, Curry" <Curry.Gong@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
 powergating is explicitly enabled
Thread-Topic: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
 powergating is explicitly enabled
Thread-Index: AQHX7brzHYmPYDzJVEu2BZp1426D3KwsOEyAgAPqpgCAABJigA==
Date: Mon, 13 Dec 2021 10:09:54 +0000
Message-ID: <DM6PR12MB26195CF890DDA7CAC7826D37E4749@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <1639136511-6357-1-git-send-email-curry.gong@amd.com>
 <f1f996f4-0bc3-aa01-f9da-3664b14f7861@amd.com>
 <BN7PR12MB2641CA6290B6CEFB4A5016EF9D749@BN7PR12MB2641.namprd12.prod.outlook.com>
In-Reply-To: <BN7PR12MB2641CA6290B6CEFB4A5016EF9D749@BN7PR12MB2641.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-13T10:09:51Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=461271d4-98e7-4434-9d69-4e6444126f10;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db57e79c-5884-4300-277a-08d9be20b5bd
x-ms-traffictypediagnostic: DM5PR12MB1868:EE_
x-microsoft-antispam-prvs: <DM5PR12MB18682D35459CA8BAC25A494EE4749@DM5PR12MB1868.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TKP+ZgR95lykkW7lB3tRqAK9pcAiBE3lYKIJ1ftt5Cufi48FRH65RJDFI372IF5hHiIvSivq7GRchjItzz9ypPp2ldHFI+i51v9aI6iqnytXlu0nZCEIdiwqoL2y+RzcrhWtGlu50VTETK9y4cKxHcNczL+sQqNKmLjVQ55rNy7KI/vx5lU/9BUn8D9ng0XUgwQ+OVb03rTgesG4DcLMXiEePnD45nk4GdqvG2rtX1da+waAnFhlLjR7DmLGIMM5VvgkmDMOD2YIU+qvxLd6KL7bZH1XIBN8ffsfYNrIWBpGw13Wi4PxqiqDpcJn4biOaWCsg/K7dIQqtPDjO03toIZY8thhXIZnouBKS9XRAo3OQav5BkJrz8b2nMkNd/R2dmglFg6NccRO88DskkvttYEWoxZp89zvCB7TZGHlLjGuaObiJwmdcqAC1fNMR4Opo3DITvRa9X1Zuvb45ezkUPqavccWQVqZCw3eewwnHtQj26cUBRFyWOIDnUhCLT+ZdP8HrOVG/QzhOsl75F/BefvExrzGHwOS/iLx3x4PZ2n81i3w5e1xD1470d8jVTv9uhyW3Oaod648pgVxxTxKn+r8WKo10xkyUYeFn1yEOfiowsLJ11ewWV3lzhNMuTPiBt9MohJqOkTBZYmgOKSj9/i+gaHQObfMu9JXrcLXRhkTaxAPeZekvHv/Ol8rMeEQ7gFHWqW75LXRfD4cf81Xgg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(66446008)(2906002)(71200400001)(186003)(64756008)(26005)(6506007)(86362001)(9686003)(4001150100001)(38100700002)(66556008)(122000001)(66476007)(66946007)(76116006)(316002)(33656002)(53546011)(52536014)(38070700005)(5660300002)(8936002)(83380400001)(8676002)(110136005)(7696005)(54906003)(508600001)(15650500001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rMKqLk6G5nKxTFc4hM5+qkyuVt91SMCqWfHKFq7xiU+5nUyXeXbhbB+4PhNM?=
 =?us-ascii?Q?DdA8tV/uTess1bpRU6S15iB2YyKGonVBbd9N4fe5cBxAlzznAdXLx6oXVkOy?=
 =?us-ascii?Q?qwIOXko7nEFn8pSUcH6L/XSWtPgVPM/enhyUKqzFfvTTyzlzDIbN3N7kzkaI?=
 =?us-ascii?Q?gZJAU09402i3/2BlLfFE2G7M+ahhmqH3jWnA4GO1NbSct2cHWXlU7A0e411c?=
 =?us-ascii?Q?dV3fakyDoGgrfIDFhnsH61sSi5901IYVTpjV4hghPu+R23i6hnzOLuX4wmAl?=
 =?us-ascii?Q?60gu+WfWglaNUqrabkFDfKGvWzDXSFrBUTiuC2VtO7lYX3NU9m9XDxNNTsg2?=
 =?us-ascii?Q?CQKNIFI1CRVS4IJuskHzTeJMcLD7pGs+LBHUoCV4YROwWqIkpZRW0W6iqKvj?=
 =?us-ascii?Q?g3WU/+VLvcaBcHCSjG5DxciECEBxe+mTEAN2edyI9IWCwEBP9qNHwt9sxYd/?=
 =?us-ascii?Q?g64NwtoMT60Cjhrhjq0iikr/7wMH+2o0Fyz6uRWweH/WLqWPGmoan9Aykr4Y?=
 =?us-ascii?Q?nSFDx7o6y3k0jXJ8IL6Qp5vMbHjO9CQQrx0Gr5fY+ZqjXfA4ihWYU2PBzlzd?=
 =?us-ascii?Q?JLDxJppgBlMjSgmi7wDCpt3OJ7S9vtPIeJayzEC3khdiCpAjNE5vS9UJk9gt?=
 =?us-ascii?Q?FkuVBWs8/oyFYFZ4QW5SAEgb8WCI3HrMhfazcEiRuKP/m5JkCmwRGIGe2dge?=
 =?us-ascii?Q?oDXhvZRmEmhVblPRTgdz7o1nA7/u2EXiYbbv5dB84l1r/GRJ0DUR0fWlHiQF?=
 =?us-ascii?Q?jc7xepXQ7sJpoUmrxM1Zri6ISoAgQXYw8I7CQeAW3zZXAF81tajE+1G77HNU?=
 =?us-ascii?Q?qeBPXbJ1d8m8Lg+M0AdQsilgxeHYyHtAA8HpNQfOx7LwMtenCRMlttdjfxN/?=
 =?us-ascii?Q?j8SdFAvT2lpP6Hbrb6HlgAL6RATIin56Cid2muA7PeAgfj4X2IoudMWMaXSS?=
 =?us-ascii?Q?TXTnOHz8mH9Fcq2jSnsNuJsED4CU4+w4xnIX8ofCaoVOTfXtc27Ey4rBNB4u?=
 =?us-ascii?Q?KtaH4cMQizTOiYM2+5WgXRP7mFqiWByTtisoP1cbD6NaB8r7CKf2zhB+Vpdy?=
 =?us-ascii?Q?5rzgLkrioyjQBne4Zsn3bgGgSBCFMAIefulOGYBuaDYSraZPh1njTo+AvGfV?=
 =?us-ascii?Q?S9vCM354GWvIywJcWHGHH5k8cDQFZX0dfOOQXTk/TjSCWio3iGXtIhJxTrhi?=
 =?us-ascii?Q?Z0xju/Jw+6ZXSf72U7yUZiKDom1jCApwKfgnlWxWwt3VfR892fRTy9vR4sAG?=
 =?us-ascii?Q?OvOOqypH35Bwdz8MNyVWnZvNEagVFRwKkDCjlnqZtqujHlsAaV4OD3ssRA1g?=
 =?us-ascii?Q?59nmz//DqrY69H/XylrsJQkeZXa3EClSFsplj4GAxUEn8c+acD5IsqP6r9th?=
 =?us-ascii?Q?ziue3y3MvYzeeOliWQFL3QQAJNGj7I3o99qVRnlodfNGITDhW4R2oCNKdO15?=
 =?us-ascii?Q?EYp8Aama05aTD4ViuNBK/BKsGMfd7OHyy9T3QAYPRoZ8wJ9baCoUHax3Mk3E?=
 =?us-ascii?Q?dCeNTom65pUa74fC/jAzjR9iQ7m11uz+StmTzTZ7XL59m64VNTuZRl9yY9MW?=
 =?us-ascii?Q?BZQAjFUCPs9XUtVvlAo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB26195CF890DDA7CAC7826D37E4749DM6PR12MB2619namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db57e79c-5884-4300-277a-08d9be20b5bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 10:09:54.5610 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbST8e8HZRaWXe4GvYGuKGCC5gKWXEwA5j5Cp/6U2RINXjlxx4Gc2H6k7UleYXM9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1868
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB26195CF890DDA7CAC7826D37E4749DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Checked the log paste below with Curry. The way to add this fix in vcn_v1_0=
_stop is not workable.
As it will induce a circle calling(below) and lead to dead lock.
VCN ring begin use -> amdgpu_dpm_enable_uvd -> acquire the smu_lock -> smu1=
0_powergate_vcn -> amdgpu_device_ip_set_powergating_state -> vcn_v1_0_stop =
-> amdgpu_dpm_enable_uvd -> try to acquire the smu_lock again -> dead lock

BR
Evan
From: Gong, Curry <Curry.Gong@amd.com>
Sent: Monday, December 13, 2021 4:56 PM
To: Zhu, James <James.Zhu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Liu, Leo <Leo.Liu@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended, powe=
rgating is explicitly enabled


[AMD Official Use Only]

Hi James:

With the following patch, an error will be reported when the driver is load=
ed
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1202,6 +1204,9 @@ static int vcn_v1_0_stop(struct amdgpu_device *adev)
        else
                r =3D vcn_v1_0_stop_spg_mode(adev);

+       if (adev->pm.dpm_enabled)
+               amdgpu_dpm_enable_uvd(adev, false);
+
        return r;
}


$ dmesg
[  363.181081] INFO: task kworker/3:2:223 blocked for more than 120 seconds=
.
[  363.181150]       Tainted: G           OE     5.11.0-41-generic #45~20.0=
4.1-Ubuntu
[  363.181208] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[  363.181266] task:kworker/3:2     state:D stack:    0 pid:  223 ppid:    =
 2 flags:0x00004000
[  363.181276] Workqueue: events vcn_v1_0_idle_work_handler [amdgpu]
[  363.181612] Call Trace:
[  363.181618]  __schedule+0x44c/0x8a0
[  363.181627]  schedule+0x4f/0xc0
[  363.181631]  schedule_preempt_disabled+0xe/0x10
[  363.181636]  __mutex_lock.isra.0+0x183/0x4d0
[  363.181643]  __mutex_lock_slowpath+0x13/0x20
[  363.181648]  mutex_lock+0x32/0x40
[  363.181652]  amdgpu_dpm_set_powergating_by_smu+0x9c/0x180 [amdgpu]
[  363.182055]  amdgpu_dpm_enable_uvd+0x38/0x110 [amdgpu]
[  363.182454]  vcn_v1_0_set_powergating_state+0x2e7e/0x3cf0 [amdgpu]
[  363.182776]  amdgpu_device_ip_set_powergating_state+0x6c/0xc0 [amdgpu]
[  363.183028]  smu10_powergate_vcn+0x2a/0x80 [amdgpu]
[  363.183361]  pp_set_powergating_by_smu+0xc5/0x2b0 [amdgpu]
[  363.183699]  amdgpu_dpm_set_powergating_by_smu+0xb6/0x180 [amdgpu]
[  363.184040]  amdgpu_dpm_enable_uvd+0x38/0x110 [amdgpu]
[  363.184391]  vcn_v1_0_idle_work_handler+0xe1/0x130 [amdgpu]
[  363.184667]  process_one_work+0x220/0x3c0
[  363.184674]  worker_thread+0x4d/0x3f0
[  363.184677]  ? process_one_work+0x3c0/0x3c0
[  363.184680]  kthread+0x12b/0x150
[  363.184685]  ? set_kthread_struct+0x40/0x40
[  363.184690]  ret_from_fork+0x22/0x30
[  363.184699] INFO: task kworker/2:2:233 blocked for more than 120 seconds=
.
[  363.184739]       Tainted: G           OE     5.11.0-41-generic #45~20.0=
4.1-Ubuntu
[  363.184782] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[  363.184825] task:kworker/2:2     state:D stack:    0 pid:  233 ppid:    =
 2 flags:0x00004000
[  363.184831] Workqueue: events amdgpu_device_delayed_init_work_handler [a=
mdgpu]
[  363.185085] Call Trace:
[  363.185087]  __schedule+0x44c/0x8a0
[  363.185092]  schedule+0x4f/0xc0
[  363.185095]  schedule_timeout+0x202/0x290
[  363.185099]  ? sched_clock_cpu+0x11/0xb0
[  363.185105]  wait_for_completion+0x94/0x100
[  363.185110]  __flush_work+0x12a/0x1e0
[  363.185113]  ? worker_detach_from_pool+0xc0/0xc0
[  363.185119]  __cancel_work_timer+0x10e/0x190
[  363.185123]  cancel_delayed_work_sync+0x13/0x20
[  363.185126]  vcn_v1_0_ring_begin_use+0x20/0x70 [amdgpu]
[  363.185401]  amdgpu_ring_alloc+0x48/0x60 [amdgpu]
[  363.185640]  amdgpu_ib_schedule+0x493/0x600 [amdgpu]
[  363.185884]  amdgpu_job_submit_direct+0x3c/0xd0 [amdgpu]
[  363.186186]  amdgpu_vcn_dec_send_msg+0x105/0x210 [amdgpu]
[  363.186460]  amdgpu_vcn_dec_ring_test_ib+0x69/0x110 [amdgpu]
[  363.186734]  amdgpu_ib_ring_tests+0xf5/0x160 [amdgpu]
[  363.186978]  amdgpu_device_delayed_init_work_handler+0x15/0x30 [amdgpu]
[  363.187206]  process_one_work+0x220/0x3c0
[  363.187210]  worker_thread+0x4d/0x3f0
[  363.187214]  ? process_one_work+0x3c0/0x3c0
[  363.187217]  kthread+0x12b/0x150
[  363.187221]  ? set_kthread_struct+0x40/0x40
[  363.187226]  ret_from_fork+0x22/0x30


BR
Curry Gong
From: Zhu, James <James.Zhu@amd.com<mailto:James.Zhu@amd.com>>
Sent: Saturday, December 11, 2021 5:07 AM
To: Gong, Curry <Curry.Gong@amd.com<mailto:Curry.Gong@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Liu, Leo <Leo.Liu@amd.com<mailto:Leo.Liu@amd.com>>; Zhu, James <James.Z=
hu@amd.com<mailto:James.Zhu@amd.com>>; Quan, Evan <Evan.Quan@amd.com<mailto=
:Evan.Quan@amd.com>>; Deucher, Alexander <Alexander.Deucher@amd.com<mailto:=
Alexander.Deucher@amd.com>>
Subject: Re: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended, powe=
rgating is explicitly enabled

On 2021-12-10 6:41 a.m., chen gong wrote:

Play a video on the raven (or PCO, raven2) platform, and then do the S3

test. When resume, the following error will be reported:



amdgpu 0000:02:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring

vcn_dec test failed (-110)

[drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block

<vcn_v1_0> failed -110

amdgpu 0000:02:00.0: amdgpu: amdgpu_device_ip_resume failed (-110).

PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -110



[why]

When playing the video: The power state flag of the vcn block is set to

POWER_STATE_ON.



When doing suspend: There is no change to the power state flag of the

vcn block, it is still POWER_STATE_ON.



When doing resume: Need to open the power gate of the vcn block and set

the power state flag of the VCN block to POWER_STATE_ON.

But at this time, the power state flag of the vcn block is already

POWER_STATE_ON. The power status flag check in the "8f2cdef drm/amd/pm:

avoid duplicate powergate/ungate setting" patch will return the

amdgpu_dpm_set_powergating_by_smu function directly.

As a result, the gate of the power was not opened, causing the

subsequent ring test to fail.



[how]

In the suspend function of the vcn block, explicitly change the power

state flag of the vcn block to POWER_STATE_OFF.



Signed-off-by: chen gong <curry.gong@amd.com><mailto:curry.gong@amd.com>

---

 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 7 +++++++

 1 file changed, 7 insertions(+)



diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v1_0.c

index d54d720..d73676b 100644

--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c

+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c

@@ -246,6 +246,13 @@ static int vcn_v1_0_suspend(void *handle)

 {

  int r;

  struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+ bool cancel_success;

+

+ cancel_success =3D cancel_delayed_work_sync(&adev->vcn.idle_work);

[JZ] Can you refer to vcn_v3_0_stop , and add amdgpu_dpm_enable_uvd(adev, f=
alse); to the end of vcn_v1_0_stop?

See if it also can help.



+ if (cancel_success) {

+        if (adev->pm.dpm_enabled)

+                amdgpu_dpm_enable_uvd(adev, false);

+ }



  r =3D vcn_v1_0_hw_fini(adev);

  if (r)

--_000_DM6PR12MB26195CF890DDA7CAC7826D37E4749DM6PR12MB2619namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
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
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Checked the log paste below with Curry. The way to a=
dd this fix in vcn_v1_0_stop is not workable.
<o:p></o:p></p>
<p class=3D"MsoNormal">As it will induce a circle calling(below) and lead t=
o dead lock.<o:p></o:p></p>
<p class=3D"MsoNormal">VCN ring begin use -&gt; amdgpu_dpm_enable_uvd -&gt;=
 acquire the smu_lock -&gt; smu10_powergate_vcn -&gt; amdgpu_device_ip_set_=
powergating_state -&gt; vcn_v1_0_stop -&gt; amdgpu_dpm_enable_uvd -&gt; try=
 to acquire the smu_lock again -&gt; dead lock<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BR<o:p></o:p></p>
<p class=3D"MsoNormal">Evan<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Gong, Curry &lt;Curry.Gong@amd.com&gt; =
<br>
<b>Sent:</b> Monday, December 13, 2021 4:56 PM<br>
<b>To:</b> Zhu, James &lt;James.Zhu@amd.com&gt;; amd-gfx@lists.freedesktop.=
org<br>
<b>Cc:</b> Liu, Leo &lt;Leo.Liu@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.c=
om&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspende=
d, powergating is explicitly enabled<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">Hi James:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">With the following patch, an error will be reported when the driver is=
 loaded<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">@@ -1202,6 +1204,9 @@ static int vcn_v1_0_stop(struct =
amdgpu_device *adev)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D vcn_v1_0_stop_spg_mode(adev);<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.=
dpm_enabled)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_enable_uvd(adev, false);<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">$ dmesg<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181081] INFO: task kworker/3:2:223 blocked=
 for more than 120 seconds.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181150]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE=
&nbsp;&nbsp;&nbsp;&nbsp; 5.11.0-41-generic #45~20.04.1-Ubuntu<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181208] &quot;echo 0 &gt; /proc/sys/kernel=
/hung_task_timeout_secs&quot; disables this message.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181266] task:kworker/3:2&nbsp;&nbsp;&nbsp;=
&nbsp; state:D stack:&nbsp;&nbsp; &nbsp;0 pid:&nbsp; 223 ppid:&nbsp;&nbsp;&=
nbsp;&nbsp; 2 flags:0x00004000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181276] Workqueue: events vcn_v1_0_idle_wo=
rk_handler [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181612] Call Trace:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181618]&nbsp; __schedule+0x44c/0x8a0<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181627]&nbsp; schedule+0x4f/0xc0<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181631]&nbsp; schedule_preempt_disabled+0x=
e/0x10<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181636]&nbsp; __mutex_lock.isra.0+0x183/0x=
4d0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181643]&nbsp; __mutex_lock_slowpath+0x13/0=
x20<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181648]&nbsp; mutex_lock+0x32/0x40<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181652]&nbsp; amdgpu_dpm_set_powergating_b=
y_smu+0x9c/0x180 [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.182055]&nbsp; amdgpu_dpm_enable_uvd+0x38/0=
x110 [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.182454]&nbsp; vcn_v1_0_set_powergating_sta=
te+0x2e7e/0x3cf0 [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.182776]&nbsp; amdgpu_device_ip_set_powerga=
ting_state+0x6c/0xc0 [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.183028]&nbsp; smu10_powergate_vcn+0x2a/0x8=
0 [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.183361]&nbsp; pp_set_powergating_by_smu+0x=
c5/0x2b0 [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.183699]&nbsp; amdgpu_dpm_set_powergating_b=
y_smu+0xb6/0x180 [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184040]&nbsp; amdgpu_dpm_enable_uvd+0x38/0=
x110 [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184391]&nbsp; vcn_v1_0_idle_work_handler+0=
xe1/0x130 [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184667]&nbsp; process_one_work+0x220/0x3c0=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184674]&nbsp; worker_thread+0x4d/0x3f0<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184677]&nbsp; ? process_one_work+0x3c0/0x3=
c0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184680]&nbsp; kthread+0x12b/0x150<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184685]&nbsp; ? set_kthread_struct+0x40/0x=
40<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184690]&nbsp; ret_from_fork+0x22/0x30<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184699] INFO: task kworker/2:2:233 blocked=
 for more than 120 seconds.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184739]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE=
&nbsp;&nbsp;&nbsp;&nbsp; 5.11.0-41-generic #45~20.04.1-Ubuntu<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184782] &quot;echo 0 &gt; /proc/sys/kernel=
/hung_task_timeout_secs&quot; disables this message.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184825] task:kworker/2:2&nbsp;&nbsp;&nbsp;=
&nbsp; state:D stack:&nbsp;&nbsp;&nbsp; 0 pid:&nbsp; 233 ppid:&nbsp;&nbsp;&=
nbsp;&nbsp; 2 flags:0x00004000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184831] Workqueue: events amdgpu_device_de=
layed_init_work_handler [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185085] Call Trace:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185087]&nbsp; __schedule+0x44c/0x8a0<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185092]&nbsp; schedule+0x4f/0xc0<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185095]&nbsp; schedule_timeout+0x202/0x290=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185099]&nbsp; ? sched_clock_cpu+0x11/0xb0<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185105]&nbsp; wait_for_completion+0x94/0x1=
00<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185110]&nbsp; __flush_work+0x12a/0x1e0<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185113]&nbsp; ? worker_detach_from_pool+0x=
c0/0xc0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185119]&nbsp; __cancel_work_timer+0x10e/0x=
190<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185123]&nbsp; cancel_delayed_work_sync+0x1=
3/0x20<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185126]&nbsp; vcn_v1_0_ring_begin_use+0x20=
/0x70 [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185401]&nbsp; amdgpu_ring_alloc+0x48/0x60 =
[amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185640]&nbsp; amdgpu_ib_schedule+0x493/0x6=
00 [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185884]&nbsp; amdgpu_job_submit_direct+0x3=
c/0xd0 [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.186186]&nbsp; amdgpu_vcn_dec_send_msg+0x10=
5/0x210 [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.186460]&nbsp; amdgpu_vcn_dec_ring_test_ib+=
0x69/0x110 [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.186734]&nbsp; amdgpu_ib_ring_tests+0xf5/0x=
160 [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.186978]&nbsp; amdgpu_device_delayed_init_w=
ork_handler+0x15/0x30 [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.187206]&nbsp; process_one_work+0x220/0x3c0=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.187210]&nbsp; worker_thread+0x4d/0x3f0<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.187214]&nbsp; ? process_one_work+0x3c0/0x3=
c0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.187217]&nbsp; kthread+0x12b/0x150<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.187221]&nbsp; ? set_kthread_struct+0x40/0x=
40<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.187226]&nbsp; ret_from_fork+0x22/0x30</spa=
n><span style=3D"font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">BR<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">Curry Gong<o:p></o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhu, James &lt;<a href=3D"mailto:James.=
Zhu@amd.com">James.Zhu@amd.com</a>&gt;
<br>
<b>Sent:</b> Saturday, December 11, 2021 5:07 AM<br>
<b>To:</b> Gong, Curry &lt;<a href=3D"mailto:Curry.Gong@amd.com">Curry.Gong=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Cc:</b> Liu, Leo &lt;<a href=3D"mailto:Leo.Liu@amd.com">Leo.Liu@amd.com<=
/a>&gt;; Zhu, James &lt;<a href=3D"mailto:James.Zhu@amd.com">James.Zhu@amd.=
com</a>&gt;; Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Quan@=
amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher=
@amd.com">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspende=
d, powergating is explicitly enabled<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">On 2021-12-10 6:41 a.m., chen gong wrote:<o:p></o:p>=
</p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre>Play a video on the raven (or PCO, raven2) platform, and then do the S=
3<o:p></o:p></pre>
<pre>test. When resume, the following error will be reported:<o:p></o:p></p=
re>
<pre><o:p>&nbsp;</o:p></pre>
<pre>amdgpu 0000:02:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ri=
ng<o:p></o:p></pre>
<pre>vcn_dec test failed (-110)<o:p></o:p></pre>
<pre>[drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP blo=
ck<o:p></o:p></pre>
<pre>&lt;vcn_v1_0&gt; failed -110<o:p></o:p></pre>
<pre>amdgpu 0000:02:00.0: amdgpu: amdgpu_device_ip_resume failed (-110).<o:=
p></o:p></pre>
<pre>PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -110<o:p></o:p>=
</pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>[why]<o:p></o:p></pre>
<pre>When playing the video: The power state flag of the vcn block is set t=
o<o:p></o:p></pre>
<pre>POWER_STATE_ON.<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>When doing suspend: There is no change to the power state flag of the<=
o:p></o:p></pre>
<pre>vcn block, it is still POWER_STATE_ON.<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>When doing resume: Need to open the power gate of the vcn block and se=
t<o:p></o:p></pre>
<pre>the power state flag of the VCN block to POWER_STATE_ON.<o:p></o:p></p=
re>
<pre>But at this time, the power state flag of the vcn block is already<o:p=
></o:p></pre>
<pre>POWER_STATE_ON. The power status flag check in the &quot;8f2cdef drm/a=
md/pm:<o:p></o:p></pre>
<pre>avoid duplicate powergate/ungate setting&quot; patch will return the<o=
:p></o:p></pre>
<pre>amdgpu_dpm_set_powergating_by_smu function directly.<o:p></o:p></pre>
<pre>As a result, the gate of the power was not opened, causing the<o:p></o=
:p></pre>
<pre>subsequent ring test to fail.<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>[how]<o:p></o:p></pre>
<pre>In the suspend function of the vcn block, explicitly change the power<=
o:p></o:p></pre>
<pre>state flag of the vcn block to POWER_STATE_OFF.<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Signed-off-by: chen gong <a href=3D"mailto:curry.gong@amd.com">&lt;cur=
ry.gong@amd.com&gt;</a><o:p></o:p></pre>
<pre>---<o:p></o:p></pre>
<pre> drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 7 +++++++<o:p></o:p></pre>
<pre> 1 file changed, 7 insertions(+)<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/a=
md/amdgpu/vcn_v1_0.c<o:p></o:p></pre>
<pre>index d54d720..d73676b 100644<o:p></o:p></pre>
<pre>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<o:p></o:p></pre>
<pre>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<o:p></o:p></pre>
<pre>@@ -246,6 +246,13 @@ static int vcn_v1_0_suspend(void *handle)<o:p></o=
:p></pre>
<pre> {<o:p></o:p></pre>
<pre>&nbsp; int r;<o:p></o:p></pre>
<pre>&nbsp; struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;<=
o:p></o:p></pre>
<pre>+ bool cancel_success;<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+ cancel_success =3D cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_w=
ork);<o:p></o:p></pre>
</blockquote>
<p><span style=3D"color:#288AEB">[JZ] Can you refer to vcn_v3_0_stop , and =
add amdgpu_dpm_enable_uvd(adev, false); to the end of vcn_v1_0_stop?</span>=
<o:p></o:p></p>
<p><span style=3D"color:#288AEB">See if it also can help. </span><o:p></o:p=
></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre><o:p>&nbsp;</o:p></pre>
<pre>+ if (cancel_success) {<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm_enable=
d)<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_enable_uvd(adev, false);<o:p></o:p></pre>
<pre>+ }<o:p></o:p></pre>
<pre> <o:p></o:p></pre>
<pre>&nbsp; r =3D vcn_v1_0_hw_fini(adev);<o:p></o:p></pre>
<pre>&nbsp; if (r)<o:p></o:p></pre>
</blockquote>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB26195CF890DDA7CAC7826D37E4749DM6PR12MB2619namp_--
