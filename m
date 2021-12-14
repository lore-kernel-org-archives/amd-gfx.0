Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD4DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 05:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2561D10ED35;
	Tue, 14 Dec 2021 05:59:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86C0B10ED35
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 05:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRFssaE8uGMiR7E3Vwdl/mDNms5orjwLA30fM1jHjqnOOSn339V2Fx1l4UY3uWNfCdOJ5Pxwe0iOVL5LWwN8xlMh+c7+y2UcGAlHVpVZY9xrlovmwmwZlU4UCbSZsRSGYytyzO/Q8OBVSXbcGvE5dToMvZCM4FPNSzzUVsjxsIDK53dT9LAI6tTUtpXRcJ9/oUmZQbRYOFpA2RUtLvMGW9wyZjwmwMGfYdge5evp7b2/h+Ny8lizydVm9tVgAajk4wh+cH91Bo8JoUhHzHxmvYMfiPLnfRWVj1WL1YAvb3oY9f/3FuOrMY/PicXoaWwc+S2l8SVyouM+ezK26nRcEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPoW2zK9GDuyfRnrqiLtBrvzV60N+keJaElzHe6ZJSk=;
 b=mNjF4o+Hx3eMWbGvcQ2CRvYzdjaDtqAmpPiZuIIDU+WoSloUp5kee/EI0AFd67GFAp3sxg2ZW+mnlHqFGLsZ4xVq7UCbjxHqfzHLUI1AF9SCZJ4ewLrKG732+EP1l8IH4Tb/AkRNAdXrycAVmZZCOw+fgD0zRgFm98VGZNRBNfpX7FPeFq0MqoC231pg4QG9QkrjsscmfIwLkZHxgY6OWsbkBfeEK+RPGM/SWKEjmBs3AfKVtp6Af5TTqyqLymvI6QJt2rXzYv/OfuNmGQvTrF+N0TKv/dqmbojfBUPbVHUwbYe51lf7WLQVcFGCDOtRFTlkoqAvCEBeG0cTpCgsvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPoW2zK9GDuyfRnrqiLtBrvzV60N+keJaElzHe6ZJSk=;
 b=AORHmwYzeRMlOAIbbSgfEECPAL1m9Czx1Cz/IGyhMulNoMHwUcgUzMP+UHa0URoFutLeEIaJaJpKrba+ZYopswQlPSvQbx0Ca5p3cDvbp8IobrDq3TKuNiSWhM6h/NMAm4aHHVkktyTJPi7Bq8KJnoztanuMpqodOC/ApVTa5nk=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Tue, 14 Dec 2021 05:59:52 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 05:59:52 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "Gong, Curry" <Curry.Gong@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
 powergating is explicitly enabled
Thread-Topic: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
 powergating is explicitly enabled
Thread-Index: AQHX7brzHYmPYDzJVEu2BZp1426D3KwsOEyAgAPqpgCAAE8sAIABDtRQ
Date: Tue, 14 Dec 2021 05:59:51 +0000
Message-ID: <DM6PR12MB2619D50306A965F94357A555E4759@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <1639136511-6357-1-git-send-email-curry.gong@amd.com>
 <f1f996f4-0bc3-aa01-f9da-3664b14f7861@amd.com>
 <BN7PR12MB2641CA6290B6CEFB4A5016EF9D749@BN7PR12MB2641.namprd12.prod.outlook.com>
 <826e98e0-5e6a-cc87-0690-b444e34bb367@amd.com>
In-Reply-To: <826e98e0-5e6a-cc87-0690-b444e34bb367@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-14T05:59:48Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5f90fcf5-e9ad-4f4b-a878-6e8a5ba75970;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc1b29bf-e223-43fc-983b-08d9bec6f1e6
x-ms-traffictypediagnostic: DM6PR12MB3082:EE_
x-microsoft-antispam-prvs: <DM6PR12MB30829B9469E36651F2502665E4759@DM6PR12MB3082.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A7BhszfnJ7mgQ6VAg01bt1fJ2QW2bWMM8wJTTvrC+SJ7GEg9l4MRpDo8Oo1Nw7vOTXSTCmQVyeXUOrJ6q3k0BLFtex2CNjAo5qWw48iSWIPCk7twoYPCxrOHKyaWK3v2DlTLO1gMOaLU+zzC64gcQHC4nxtiih5Rz6PwjL/tovqErlmdneWdCwAm/LGooFwVZxDpQcw7/1Y72Kjy+kxBZbzC39Wc7HoznKldAXtfoEzb/iZ7tti/yunR5Na6aLqNR24EgLAGv0S2sPZV463lZOoGcWzPp+BVX2u7XWkmpON+WdXN4FP640GkDj0ST+eZabdnudV+cWG/8bFZZ5aDq9OBoTUoPyN7UMSZjEZ6yIirQWFnnA2e4jyd0q0C716ovpSCUZ4S1dnLhB/Lnf2IAS9CUOnZ9bh3CxjMo0l+QEIJ2yPFGMPEWk7H37v+3YDbykOW8J2y97zHdUa6oNQ0MaHAYViXLmyDwZvZFzVyimzI9KVEGYx8ocfxiIgP7JVOV7qRNotp0jTgbSc307bORRXGxpznD4ZCd5sMTcCjVDMwo8K0RU+UeFfjDyThjvT0RsXs6i0JJOWBALmCD4pIhOVA9w2mruhZBu2gBgMcnR0273qYg8zf65ARKXc6VRwe7zk+H/hHkucVj5ReKoPVWngS0mQ2YyNoCUbUqudB2w59DpGSgIWr6+Hdc4Z/bchtAS7hMpZ+PuGXfTLZ+f3jZg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(7696005)(83380400001)(15650500001)(9686003)(38100700002)(5660300002)(33656002)(122000001)(8936002)(8676002)(110136005)(38070700005)(4001150100001)(26005)(316002)(76116006)(52536014)(64756008)(71200400001)(6506007)(66556008)(53546011)(66946007)(66476007)(66446008)(86362001)(54906003)(4326008)(186003)(55016003)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8DOvImjR9c12AEF7Zd+aUFvEgWMwU305P7z8tPNU5rLlfVTFjLSQWmX1bxqR?=
 =?us-ascii?Q?g59T8XGDZBz/VPw7uW9AIYY1TW3CacwOaEgjxgMcPjysBmcFm4x1ACWP3sLn?=
 =?us-ascii?Q?McdEFLH+kPPuVdgJyjYCXosuDHwHHLW2S4479ZJkhG9FXC1+kBk0KXxttPo9?=
 =?us-ascii?Q?ScbGpOhJGXpwobSUoXNAGb60Yafx+8HgCRAD3K1rncSsi1GcB1i16i0O2SHg?=
 =?us-ascii?Q?yNtgBaaVE1Km57F7pI7dNpL5LKjnQSJDD0M7gw9UPhqNvyqJ6+Bhl4vccT7C?=
 =?us-ascii?Q?McaLYBPWmAwJhHGob2azARFV37Czlm1pDMyJCOfZBjEoEZtAwO/6r8nKe9xk?=
 =?us-ascii?Q?ZzbRK0rw9Pj9OP0uw46p8U1QMYQnmEnCdACTFLEpP2+VmDhGmeFSXlpled3Q?=
 =?us-ascii?Q?Jp8jctCIa8vBzEMzsd35PGImrPUxV9sDqPxzYBGGULIOvO8yDn2FuG7wGe0Y?=
 =?us-ascii?Q?31k12oTecFal86QF0+I0VmF37O+5uexsKvhU/ZAdF0iKWTZeYt09W3pc/1+4?=
 =?us-ascii?Q?10F/Wk4EEcXia9UUjk2p+AS9j48VltdjhNUCdfJgsgpw8lt/eU4ORL8dcrN5?=
 =?us-ascii?Q?fQG3vpMhuaegddtK6KyTwSRbpryP1pM2JJgEsokNwl6zGolMpAFeEADQgfTl?=
 =?us-ascii?Q?F7wpcYNisey9ujax5eezv3Q4HLatvJo1dKJexl9IUkyauB98byFKC3PR/ywu?=
 =?us-ascii?Q?tHdfm2UlmptR1V4X4gRHWKWA5JI7nMRvjot9pmjMQAkBi9AzTNj+23rh1N34?=
 =?us-ascii?Q?cL2HPpcYE6NoX2Rcq8NQv4xT3/VhC5/Dkl+txJ8X6mg/n/kaKfyOxHt/Zu4v?=
 =?us-ascii?Q?ognuL06r9As6J3XOPfj7KpcZL+kMRhdQJXAYo8c35svkekEl/KolmW7omN0e?=
 =?us-ascii?Q?R8nUM4klLU7iZXuiNeVA+4Sr2WQrF9Lgf3D32WkBjusDQ5k6VP7DtK/wVenZ?=
 =?us-ascii?Q?QXINau2WlNyLFMjY0HgcOF1rmmuXRgdoj4DaZ1ttpk4vmpFwu7fCI9arf1yV?=
 =?us-ascii?Q?9GUvoBUVc64KT2+Q6SOyEkBiEpwhlkfLBAfWdBfOtxiD5joRavTbMAGBZ+Ce?=
 =?us-ascii?Q?XP6trlNoRrnU/aRmR+v549LM7wKgvxRAhZXRqqa4aanQupQCrEbVhc1s9y8P?=
 =?us-ascii?Q?yVVrnB+7Z94iC0PvU2Ng/jmqeaXs4JySEBq/MRalFGGtIBXXANeqyC+pvDHR?=
 =?us-ascii?Q?vKlS4jacEIQAxVrEBfgg4uWFEr8ipJAb+Zn+OwbAgHEiHXUb3rd0NnXLnjrp?=
 =?us-ascii?Q?A6wb5Yn0iPeZxgjl0jDQvwmarqL7qqx96o06uF68kGFl5dts0VB9KuJi3CoG?=
 =?us-ascii?Q?OorAIlyxUoxgckj8aoA4LSKmsptSxEq6AA6y+mgvcxlpBWvj79LsTGqzvGkN?=
 =?us-ascii?Q?mTzwrBZyXe6ueO9YBoOCLQwDoCtO3lhKzmXFfFONjgh3CXu9R/brOmm5TQZg?=
 =?us-ascii?Q?Hy1GDiUS5pESz/VrWRRZBAvfYrfndxkZSEp8TUKnx2VkDzMDD5beBeET5HBW?=
 =?us-ascii?Q?zD3zmVGLrryCPFxcRiIiKczxWqRjN+miN3tVzG9aCbMLUuy1ZkZND58gDA9e?=
 =?us-ascii?Q?7mZDMcbdLXKPseURI9I=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB2619D50306A965F94357A555E4759DM6PR12MB2619namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1b29bf-e223-43fc-983b-08d9bec6f1e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 05:59:51.8820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JF9XJ6Y5pVgQAA1uSsWt+GjgOAKu8nMs9YMpjtQoN+G23FansAYtbIztmAqaanVq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3082
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

--_000_DM6PR12MB2619D50306A965F94357A555E4759DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]



From: Zhu, James <James.Zhu@amd.com>
Sent: Monday, December 13, 2021 9:39 PM
To: Gong, Curry <Curry.Gong@amd.com>; Zhu, James <James.Zhu@amd.com>; amd-g=
fx@lists.freedesktop.org
Cc: Liu, Leo <Leo.Liu@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended, powe=
rgating is explicitly enabled


Hi Curry, Evan,

It seems vcn1.0 power gate sequence are special.

if the original solution is thread safe, then the following solution will b=
e thread safe also.
static int vcn_v1_0_hw_fini(void *handle)
{
    struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

    cancel_delayed_work_sync(&adev->vcn.idle_work);

    if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
        (adev->vcn.cur_state !=3D AMD_PG_STATE_GATE &&
         RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
+        if (adev->pm.dpm_enabled)
+            amdgpu_dpm_enable_uvd(adev, false);
+        else
+            vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
[Quan, Evan] Considering adev->pm.dpm_enabled is always true, "vcn_v1_0_set=
_powergating_state(adev, AMD_PG_STATE_GATE); " will become dead code.
Also, the vcn_v1_0_hw_fini is also used in other scenarios(except the suspe=
nd/resume discussed here). So, it seems quite risky compared with Curry's o=
riginal patch.
Before we can come up with a better idea, I would suggest to land Curry's o=
riginal patch as a quick fix.

BR
Evan

    }

Best Regards!

James
On 2021-12-13 3:55 a.m., Gong, Curry wrote:

[AMD Official Use Only]

Hi James:

With the following patch, an error will be reported when the driver is load=
ed
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1202,6 +1204,9 @@ static int vcn_v1_0_stop(struct amdgpu_device *adev)
        else
                r =3D vcn_v1_0_stop_spg_mode(adev);

c
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
From: Zhu, James <James.Zhu@amd.com><mailto:James.Zhu@amd.com>
Sent: Saturday, December 11, 2021 5:07 AM
To: Gong, Curry <Curry.Gong@amd.com><mailto:Curry.Gong@amd.com>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Liu, Leo <Leo.Liu@amd.com><mailto:Leo.Liu@amd.com>; Zhu, James <James.Z=
hu@amd.com><mailto:James.Zhu@amd.com>; Quan, Evan <Evan.Quan@amd.com><mailt=
o:Evan.Quan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com><mailto=
:Alexander.Deucher@amd.com>
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

--_000_DM6PR12MB2619D50306A965F94357A555E4759DM6PR12MB2619namp_
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
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhu, James &lt;James.Zhu@amd.com&gt; <b=
r>
<b>Sent:</b> Monday, December 13, 2021 9:39 PM<br>
<b>To:</b> Gong, Curry &lt;Curry.Gong@amd.com&gt;; Zhu, James &lt;James.Zhu=
@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Liu, Leo &lt;Leo.Liu@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.c=
om&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspende=
d, powergating is explicitly enabled<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p>Hi Curry, Evan,<o:p></o:p></p>
<p>It seems vcn1.0 power gate sequence are special.<o:p></o:p></p>
<p>if the original solution is thread safe, then the following solution wil=
l be thread safe also.
<o:p></o:p></p>
<p class=3D"MsoNormal">static int vcn_v1_0_hw_fini(void *handle) <br>
{ <br>
&nbsp;&nbsp; &nbsp;struct amdgpu_device *adev =3D (struct amdgpu_device *)h=
andle; <br>
&nbsp;<br>
&nbsp;&nbsp; &nbsp;cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work); <=
br>
&nbsp;<br>
&nbsp;&nbsp; &nbsp;if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) || =
<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;vcn.cur_state !=3D AMD_PG_S=
TATE_GATE &amp;&amp; <br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;RREG32_SOC15(VCN, 0, mmUVD_STAT=
US))) { <br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm_enabled) <br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; amdgpu_dpm_enable=
_uvd(adev, false); <br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; else <br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; vcn_v1_0_set_powe=
rgating_state(adev, AMD_PG_STATE_GATE); <o:p></o:p></p>
<p class=3D"MsoNormal"><b><i>[Quan, Evan] </i></b><i>Considering adev-&gt;p=
m.dpm_enabled is always true, &#8220;</i>vcn_v1_0_set_powergating_state(ade=
v, AMD_PG_STATE_GATE); &#8220; will become dead code.<o:p></o:p></p>
<p class=3D"MsoNormal">Also, the vcn_v1_0_hw_fini is also used in other sce=
narios(except the suspend/resume discussed here). So, it seems quite risky =
compared with Curry&#8217;s original patch.<o:p></o:p></p>
<p class=3D"MsoNormal">Before we can come up with a better idea, I would su=
ggest to land Curry&#8217;s original patch as a quick fix.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BR<o:p></o:p></p>
<p class=3D"MsoNormal">Evan<o:p></o:p></p>
<p class=3D"MsoNormal"><br>
&nbsp;&nbsp; &nbsp;}<o:p></o:p></p>
<p>Best Regards!<o:p></o:p></p>
<p>James<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">On 2021-12-13 3:55 a.m., Gong, Curry wrote:<o:p></o:=
p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">Hi James:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">With the following patch, an error will be reported when the driver is=
 loaded</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c</span><o:p=
></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">@@ -1202,6 +1204,9 @@ static int vcn_v1_0_stop(struct =
amdgpu_device *adev)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else</span>=
<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D vcn_v1_0_stop_spg_mode(adev);</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal">c <o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">}</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">$ dmesg</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181081] INFO: task kworker/3:2:223 blocked=
 for more than 120 seconds.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181150]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE=
&nbsp;&nbsp;&nbsp;&nbsp; 5.11.0-41-generic #45~20.04.1-Ubuntu</span><o:p></=
o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181208] &quot;echo 0 &gt; /proc/sys/kernel=
/hung_task_timeout_secs&quot; disables this message.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181266] task:kworker/3:2&nbsp;&nbsp;&nbsp;=
&nbsp; state:D stack:&nbsp;&nbsp; &nbsp;0 pid:&nbsp; 223 ppid:&nbsp;&nbsp;&=
nbsp;&nbsp; 2 flags:0x00004000</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181276] Workqueue: events vcn_v1_0_idle_wo=
rk_handler [amdgpu]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181612] Call Trace:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181618]&nbsp; __schedule+0x44c/0x8a0</span=
><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181627]&nbsp; schedule+0x4f/0xc0</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181631]&nbsp; schedule_preempt_disabled+0x=
e/0x10</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181636]&nbsp; __mutex_lock.isra.0+0x183/0x=
4d0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181643]&nbsp; __mutex_lock_slowpath+0x13/0=
x20</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181648]&nbsp; mutex_lock+0x32/0x40</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.181652]&nbsp; amdgpu_dpm_set_powergating_b=
y_smu+0x9c/0x180 [amdgpu]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.182055]&nbsp; amdgpu_dpm_enable_uvd+0x38/0=
x110 [amdgpu]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.182454]&nbsp; vcn_v1_0_set_powergating_sta=
te+0x2e7e/0x3cf0 [amdgpu]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.182776]&nbsp; amdgpu_device_ip_set_powerga=
ting_state+0x6c/0xc0 [amdgpu]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.183028]&nbsp; smu10_powergate_vcn+0x2a/0x8=
0 [amdgpu]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.183361]&nbsp; pp_set_powergating_by_smu+0x=
c5/0x2b0 [amdgpu]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.183699]&nbsp; amdgpu_dpm_set_powergating_b=
y_smu+0xb6/0x180 [amdgpu]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184040]&nbsp; amdgpu_dpm_enable_uvd+0x38/0=
x110 [amdgpu]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184391]&nbsp; vcn_v1_0_idle_work_handler+0=
xe1/0x130 [amdgpu]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184667]&nbsp; process_one_work+0x220/0x3c0=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184674]&nbsp; worker_thread+0x4d/0x3f0</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184677]&nbsp; ? process_one_work+0x3c0/0x3=
c0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184680]&nbsp; kthread+0x12b/0x150</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184685]&nbsp; ? set_kthread_struct+0x40/0x=
40</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184690]&nbsp; ret_from_fork+0x22/0x30</spa=
n><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184699] INFO: task kworker/2:2:233 blocked=
 for more than 120 seconds.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184739]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE=
&nbsp;&nbsp;&nbsp;&nbsp; 5.11.0-41-generic #45~20.04.1-Ubuntu</span><o:p></=
o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184782] &quot;echo 0 &gt; /proc/sys/kernel=
/hung_task_timeout_secs&quot; disables this message.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184825] task:kworker/2:2&nbsp;&nbsp;&nbsp;=
&nbsp; state:D stack:&nbsp;&nbsp;&nbsp; 0 pid:&nbsp; 233 ppid:&nbsp;&nbsp;&=
nbsp;&nbsp; 2 flags:0x00004000</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.184831] Workqueue: events amdgpu_device_de=
layed_init_work_handler [amdgpu]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185085] Call Trace:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185087]&nbsp; __schedule+0x44c/0x8a0</span=
><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185092]&nbsp; schedule+0x4f/0xc0</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185095]&nbsp; schedule_timeout+0x202/0x290=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185099]&nbsp; ? sched_clock_cpu+0x11/0xb0<=
/span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185105]&nbsp; wait_for_completion+0x94/0x1=
00</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185110]&nbsp; __flush_work+0x12a/0x1e0</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185113]&nbsp; ? worker_detach_from_pool+0x=
c0/0xc0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185119]&nbsp; __cancel_work_timer+0x10e/0x=
190</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185123]&nbsp; cancel_delayed_work_sync+0x1=
3/0x20</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185126]&nbsp; vcn_v1_0_ring_begin_use+0x20=
/0x70 [amdgpu]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185401]&nbsp; amdgpu_ring_alloc+0x48/0x60 =
[amdgpu]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185640]&nbsp; amdgpu_ib_schedule+0x493/0x6=
00 [amdgpu]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.185884]&nbsp; amdgpu_job_submit_direct+0x3=
c/0xd0 [amdgpu]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.186186]&nbsp; amdgpu_vcn_dec_send_msg+0x10=
5/0x210 [amdgpu]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.186460]&nbsp; amdgpu_vcn_dec_ring_test_ib+=
0x69/0x110 [amdgpu]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.186734]&nbsp; amdgpu_ib_ring_tests+0xf5/0x=
160 [amdgpu]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.186978]&nbsp; amdgpu_device_delayed_init_w=
ork_handler+0x15/0x30 [amdgpu]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.187206]&nbsp; process_one_work+0x220/0x3c0=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.187210]&nbsp; worker_thread+0x4d/0x3f0</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.187214]&nbsp; ? process_one_work+0x3c0/0x3=
c0</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.187217]&nbsp; kthread+0x12b/0x150</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.187221]&nbsp; ? set_kthread_struct+0x40/0x=
40</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:8.0pt;font-family:&quot;Ari=
al&quot;,sans-serif">[&nbsp; 363.187226]&nbsp; ret_from_fork+0x22/0x30</spa=
n><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">BR</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">Curry Gong</span><o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhu, James <a href=3D"mailto:James.Zhu@=
amd.com">&lt;James.Zhu@amd.com&gt;</a>
<br>
<b>Sent:</b> Saturday, December 11, 2021 5:07 AM<br>
<b>To:</b> Gong, Curry <a href=3D"mailto:Curry.Gong@amd.com">&lt;Curry.Gong=
@amd.com&gt;</a>;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Cc:</b> Liu, Leo <a href=3D"mailto:Leo.Liu@amd.com">&lt;Leo.Liu@amd.com&=
gt;</a>; Zhu, James
<a href=3D"mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>; Quan, E=
van <a href=3D"mailto:Evan.Quan@amd.com">
&lt;Evan.Quan@amd.com&gt;</a>; Deucher, Alexander <a href=3D"mailto:Alexand=
er.Deucher@amd.com">
&lt;Alexander.Deucher@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspende=
d, powergating is explicitly enabled<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">On 2021-12-10 6:41 a.m., chen gong wrote:<o:p></o:p>=
</p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre>Play a video on the raven (or PCO, raven2) platform, and then do the S=
3<o:p></o:p></pre>
<pre>test. When resume, the following error will be reported:<o:p></o:p></p=
re>
<pre>&nbsp;<o:p></o:p></pre>
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
<pre>&nbsp;<o:p></o:p></pre>
<pre>[why]<o:p></o:p></pre>
<pre>When playing the video: The power state flag of the vcn block is set t=
o<o:p></o:p></pre>
<pre>POWER_STATE_ON.<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>When doing suspend: There is no change to the power state flag of the<=
o:p></o:p></pre>
<pre>vcn block, it is still POWER_STATE_ON.<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
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
<pre>&nbsp;<o:p></o:p></pre>
<pre>[how]<o:p></o:p></pre>
<pre>In the suspend function of the vcn block, explicitly change the power<=
o:p></o:p></pre>
<pre>state flag of the vcn block to POWER_STATE_OFF.<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
<pre>Signed-off-by: chen gong <a href=3D"mailto:curry.gong@amd.com">&lt;cur=
ry.gong@amd.com&gt;</a><o:p></o:p></pre>
<pre>---<o:p></o:p></pre>
<pre> drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 7 +++++++<o:p></o:p></pre>
<pre> 1 file changed, 7 insertions(+)<o:p></o:p></pre>
<pre>&nbsp;<o:p></o:p></pre>
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
<pre>&nbsp;<o:p></o:p></pre>
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
</blockquote>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB2619D50306A965F94357A555E4759DM6PR12MB2619namp_--
