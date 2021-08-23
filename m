Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9964EC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 08:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597C361368
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 08:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 597C361368
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E60158861A;
	Mon, 23 Aug 2021 08:01:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4744E8861A
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 08:01:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9ciZenhcqPIIkIuHZJmDfsH2FTq2P4I5qPNETfazp+o0OMIUB1MxYCd4sTt98q4jYHuIAzkDiE4kCrqgIEv5snv1BOK95RQl5bzqajhb3KznBIDaNKmTiovm705sVoKIxBC1P2DFDoID0X6Kptno87k5+WRc9CeBLtao53GhVOPfydqHnqp5Wq/+lzyOLnkMyXlzQ/w1Gfar50Q3rA892jJoI3ISuq15+yhWd9ZI+/bSyJuvlZovy1NFIKnLjkZiFOYY2k9rzNA3stW8iyG1AzpX718iAz1Emj2PBpKTh8GrBleQsTBam1JfBnFSD0A0OB304Hno6HWuMjVmhkCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEY+snjxSdo1tH8JgygcS6XVKUIvJhCnvuyPkRrpVVc=;
 b=JNeqPg6TZXEmP7b5kTE++bjU8eMqIPr/+jRVbTSGVMM4m8/k+eeVDtHColxFq0Om5k9iAkYnKPmIKJV2+3gYBJDKfdjmWkYkn8w+6vJotgYTePLsvzP90zuEbTEnHgAIQhDGvRlmNIk69NaXzsdokKcs5rC7j37Fg3/OdANxZiEXUN/qH00cers7hySpWfqa8WQ5HQ4zTGrzRnzRQAnSin3uEmvG8TXfqcmBDbFbx2AG/ZGLwIFRB7V/J/1OSXhYV3/teK/aJmsBsuXlv6hRXmxz73pvOi30Fg3QftmOvy7q9uEIHI3Q0qqKVMP31SHPf4IyK7ETemeY+kY2JvNajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEY+snjxSdo1tH8JgygcS6XVKUIvJhCnvuyPkRrpVVc=;
 b=Xyez40Lw/bwmCnWog+GlYcQSGF+bO7rJ/8niUR3iG0uY1mjV6RMpVmQjwaGGLL3hMW5fyigtzJAa153EHx/RFIXD2637qblXobwAFIm0/Azocyc8p1PkDThRpl36SycXfnqtjEqRqg1YIxGPwwgfpr9JNY46tcqdrQjiLIFedbQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.21; Mon, 23 Aug 2021 08:01:38 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4415.024; Mon, 23 Aug 2021
 08:01:38 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhu, James"
 <James.Zhu@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: correct clock/power gating sequence on
 UVD/VCE suspend/resume
Thread-Topic: [PATCH 1/4] drm/amdgpu: correct clock/power gating sequence on
 UVD/VCE suspend/resume
Thread-Index: AQHXl9XZTncbZwDv7Ei1f9pXoG41vKuAufvg
Date: Mon, 23 Aug 2021 08:01:38 +0000
Message-ID: <DM6PR12MB26197FB870F6DA6F6E8C966BE4C49@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210823041737.48921-1-evan.quan@amd.com>
In-Reply-To: <20210823041737.48921-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-23T08:01:35Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3750fbcd-3ffc-48e7-b21f-377b31b2dfea;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c0678e5-eb13-4dde-c752-08d9660c3c41
x-ms-traffictypediagnostic: DM6PR12MB4219:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB42197FB6E916990E1E3B7D0CE4C49@DM6PR12MB4219.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yjvfdFyhbxjdkVQYn6P3IpU5i91q6VfeFoffbiSayC/0giJFJoUp3EJN2H7VlG95HbY+R8npC3Y3juinnu7ahmcl4tkNuk7vQSJzyOBvETcT8UHq/ET6YHACoRb3Z16lzkLKwM8OXrbvmV+Ow5dd4/IHvSVeMSeKIgR6k5XkFC7QmKEiv8BuMRFCrsxhkBMNsnzrVSZzM6Yclv0E6fX8ecWSSPlBSrrtEAj+LVRNHvv4ws0l+SmDlZDxrL1ZJrRpPac463nNmaT2hAKXPDL2wAWX/3G08B1uisgzSv9jmA6tQxUTIyIkEpFO4SM0rkmjXZe7KRnmUyP/boIglFtQGO0GFYdlvqZaFYH0Opm9xH+Q5UvxpEUikN3MwoXzCUzsyoMvbrxPWNhmoUiaMT1msFf+LogmqYYGrpk03iZ3FyBb98F3zuV2m++uwTuCvsiFuuORDLeDpNUX/dVOE4XqjCyEV+LbuFmFSAKVioJBUt/mIErlwwAb08yy82USbtwVEF8vobZcJGZ9/4kpevBxn+EUdcOHp5Dc1PZBUMI1P2KUiiEydvcad/oSMcu1sHwt5qAUh02R3r6OEGcgeKhkuMkwEFpaIweWtFJiG0I1NIN7rPjWQ3VuWXx2Wx2K2Jf52ydno8M2X13svQ69PT+UGyz9pY5+7nVf/gAFtHTZMn1/wRSvJJe3tM35S0JkOwXVRXyft18sMYTVk3viT/zX0A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(66476007)(66946007)(66446008)(76116006)(86362001)(15650500001)(8936002)(66556008)(186003)(478600001)(64756008)(8676002)(26005)(53546011)(4326008)(2906002)(9686003)(33656002)(71200400001)(6916009)(316002)(5660300002)(52536014)(38070700005)(6506007)(7696005)(55016002)(54906003)(38100700002)(122000001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bh1ejZH/1+DEijzNfY/6TlKlvk/k0qiipzGlUiAhfTS3yEF+75A7vRoFsifQ?=
 =?us-ascii?Q?dMGLotvmxBu2qBWydyfUu0v/bZhCJAdiBRI9ZdCx/YeGOMyUsZBPDal1E7KD?=
 =?us-ascii?Q?Mrg0ZyZhSaBUI1g8F3tFTM2zd50PKVbp10pTmp/IK9+vqtQmn7syuHwr9eoj?=
 =?us-ascii?Q?uWrKky4kuQRa4BeNnbfkofxaJwoe+Vuw7mmm5Rbg4nrm1UIAzfPkvvL6eEWw?=
 =?us-ascii?Q?ynAfzOpJkMhi72AXdUfuxBKiotIwdnfpuTHgvhZBDKbjw54G7mevIgB8zPMD?=
 =?us-ascii?Q?5zHQ6uKYdRCqYw3TFAsjS5kUZlncwi6TxP4/J9rEDR8dj8eP5OMzLsSKayCB?=
 =?us-ascii?Q?quKHcinuRkXxk1y/+G4FPm4/Kadi3SfCdlhvJjhutgsvfFTJOBAR2ZJlLfJ7?=
 =?us-ascii?Q?mpQ+drgBjwlY5NsV8O+meFnkSFkWjJSAcmVYMiNu9wTekAuW2pv1lp3jmQuI?=
 =?us-ascii?Q?yLCCAu/s7U4Y5quhKEAzVeIhcwi/uCc5y9KBCjAySD7A19dIyWNk0t+SK/K7?=
 =?us-ascii?Q?X6VYnEZrSM+VvtVbgdcNWBwYRW+x4CqUta2JGIRZbCV25pai6a9YXr6RDIW0?=
 =?us-ascii?Q?meKmd2kmmFCvcitRQ8WXx3W2Lxhs3IrYN401Bgl7f2LRxz6NTK1RPBzDb+1D?=
 =?us-ascii?Q?KxOafWszacJCZgz+0fcwib6tMBCZofGsLcfZT+sCGAUcnRUSXDiYjoJzB9um?=
 =?us-ascii?Q?AbArpgdnPpv0e5bn53XmqZUa+3LppFXhsbHhxJk/7HjFre5v3Clt39SfGC28?=
 =?us-ascii?Q?3wbPS+COHeEpoUom5B2slYU2UF9GFchhDV849rhHygE4yFyoxlZtH31vdl06?=
 =?us-ascii?Q?I6VqN3pfAcFBRyDlhQ7fXQwdUF8pTPQNU6jt3TmmDl14tLc8E7ypC0gkbji3?=
 =?us-ascii?Q?Iq8RNNcyiD5HYk+lQEzXFYNUpkjeeKH4lEWKEaep1kS4a6zXBItQpfoCX51V?=
 =?us-ascii?Q?G1/i49FA/c2Z9fUNd6W4ooCuM+1vtiG1CyYieshsuVOq+sv/YdVA5VIYqRsE?=
 =?us-ascii?Q?G5mIpQE0YwO76NHArkqUa37DwkGG4pXeWMG4OtwcYAPhw7Zdf7LcqFwFFg3/?=
 =?us-ascii?Q?oAFBydZY91ODKREy1bg78X9zkum+si51jJkU9tU0vb3f151TGyHBu6Pcx9CC?=
 =?us-ascii?Q?g3k8Lj0wE0IzSI3np47gW6TDMcOIRMDsYR+Uo6+DpkI90jDwYMwfG6IMRVm8?=
 =?us-ascii?Q?7Stnq6dpFyGlH0d7Cnhebvy82tFaCmGOqrT2Clii2p4PeHMbwZFJdVzs5M3g?=
 =?us-ascii?Q?oPlO8rObAR9cLPBbfmc996R2fPmu9o8eXvoeHEWk7yk9ZnYHkdrw8t+7sN04?=
 =?us-ascii?Q?gqsNkG/7ibEoOp82GF7rbmXk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0678e5-eb13-4dde-c752-08d9660c3c41
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 08:01:38.4101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: awAcgvKwlfZQ5v+hjRVf5JaveFWVVniM5BiP9PlNJAsChisHM06k4IzxqKTPmtH5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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

[AMD Official Use Only]

Have to drop this patch as the following errors were observed with it.
[   87.420822] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   88.443029] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   89.465386] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   90.487629] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   91.510380] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   92.533782] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   93.557400] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   94.580708] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   95.603832] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   96.627727] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   96.657453] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, gi=
ving up!!!
[   96.665892] [drm:amdgpu_device_ip_set_powergating_state [amdgpu]] *ERROR=
* set_powergating_state of IP block <uvd_v6_0> failed -1
[   97.697422] amdgpu 0000:02:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ER=
ROR* IB test failed on uvd (-110).
[   98.721432] amdgpu 0000:02:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ER=
ROR* IB test failed on uvd_enc0 (-110).
[   99.745407] amdgpu 0000:02:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ER=
ROR* IB test failed on uvd_enc1 (-110).
[   99.857784] [drm:amdgpu_device_delayed_init_work_handler [amdgpu]] *ERRO=
R* ib ring test failed (-110).

BR
Evan
> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Monday, August 23, 2021 12:18 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
> <Guchun.Chen@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhu, James
> <James.Zhu@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: [PATCH 1/4] drm/amdgpu: correct clock/power gating sequence on
> UVD/VCE suspend/resume
>=20
> The clocks should be gated before power. And reverse sequence should be
> used on ungating.
>=20
> Change-Id: Iab09f1f616560ff1083b75e95bfc6433d05d7f98
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |  8 +++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |  8 +++----
>  .../powerplay/hwmgr/smu7_clockpowergating.c   | 24 +++++++++----------
>  .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 24 +++++++++-------
> ---
>  4 files changed, 32 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 445480b50f48..859840ac5f0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -1238,10 +1238,10 @@ static void
> amdgpu_uvd_idle_work_handler(struct work_struct *work)
>  		} else {
>  			amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>  			/* shutdown the UVD block */
> -			amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_UVD,
> -
> AMD_PG_STATE_GATE);
>  			amdgpu_device_ip_set_clockgating_state(adev,
> AMD_IP_BLOCK_TYPE_UVD,
>=20
> AMD_CG_STATE_GATE);
> +			amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_UVD,
> +
> AMD_PG_STATE_GATE);
>  		}
>  	} else {
>  		schedule_delayed_work(&adev->uvd.idle_work,
> UVD_IDLE_TIMEOUT); @@ -1262,10 +1262,10 @@ void
> amdgpu_uvd_ring_begin_use(struct amdgpu_ring *ring)
>  			amdgpu_dpm_enable_uvd(adev, true);
>  		} else {
>  			amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
> -			amdgpu_device_ip_set_clockgating_state(adev,
> AMD_IP_BLOCK_TYPE_UVD,
> -
> AMD_CG_STATE_UNGATE);
>  			amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_UVD,
>=20
> AMD_PG_STATE_UNGATE);
> +			amdgpu_device_ip_set_clockgating_state(adev,
> AMD_IP_BLOCK_TYPE_UVD,
> +
> AMD_CG_STATE_UNGATE);
>  		}
>  	}
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 7ad83da613ed..21b4fc48d33f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -344,10 +344,10 @@ static void amdgpu_vce_idle_work_handler(struct
> work_struct *work)
>  			amdgpu_dpm_enable_vce(adev, false);
>  		} else {
>  			amdgpu_asic_set_vce_clocks(adev, 0, 0);
> -			amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_VCE,
> -
> AMD_PG_STATE_GATE);
>  			amdgpu_device_ip_set_clockgating_state(adev,
> AMD_IP_BLOCK_TYPE_VCE,
>=20
> AMD_CG_STATE_GATE);
> +			amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_VCE,
> +
> AMD_PG_STATE_GATE);
>  		}
>  	} else {
>  		schedule_delayed_work(&adev->vce.idle_work,
> VCE_IDLE_TIMEOUT); @@ -376,10 +376,10 @@ void
> amdgpu_vce_ring_begin_use(struct amdgpu_ring *ring)
>  			amdgpu_dpm_enable_vce(adev, true);
>  		} else {
>  			amdgpu_asic_set_vce_clocks(adev, 53300, 40000);
> -			amdgpu_device_ip_set_clockgating_state(adev,
> AMD_IP_BLOCK_TYPE_VCE,
> -
> AMD_CG_STATE_UNGATE);
>  			amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_VCE,
>=20
> AMD_PG_STATE_UNGATE);
> +			amdgpu_device_ip_set_clockgating_state(adev,
> AMD_IP_BLOCK_TYPE_VCE,
> +
> AMD_CG_STATE_UNGATE);
>=20
>  		}
>  	}
> diff --git
> a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
> index f2bda3bcbbde..e1f85f777eac 100644
> ---
> a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
> +++
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
> @@ -118,22 +118,22 @@ void smu7_powergate_uvd(struct pp_hwmgr
> *hwmgr, bool bgate)
>  	data->uvd_power_gated =3D bgate;
>=20
>  	if (bgate) {
> -		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
> -						AMD_IP_BLOCK_TYPE_UVD,
> -						AMD_PG_STATE_GATE);
>  		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
>  				AMD_IP_BLOCK_TYPE_UVD,
>  				AMD_CG_STATE_GATE);
> +		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
> +						AMD_IP_BLOCK_TYPE_UVD,
> +						AMD_PG_STATE_GATE);
>  		smu7_update_uvd_dpm(hwmgr, true);
>  		smu7_powerdown_uvd(hwmgr);
>  	} else {
>  		smu7_powerup_uvd(hwmgr);
> -		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
> -				AMD_IP_BLOCK_TYPE_UVD,
> -				AMD_CG_STATE_UNGATE);
>  		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>  						AMD_IP_BLOCK_TYPE_UVD,
>  						AMD_PG_STATE_UNGATE);
> +		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
> +				AMD_IP_BLOCK_TYPE_UVD,
> +				AMD_CG_STATE_UNGATE);
>  		smu7_update_uvd_dpm(hwmgr, false);
>  	}
>=20
> @@ -146,22 +146,22 @@ void smu7_powergate_vce(struct pp_hwmgr
> *hwmgr, bool bgate)
>  	data->vce_power_gated =3D bgate;
>=20
>  	if (bgate) {
> -		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
> -						AMD_IP_BLOCK_TYPE_VCE,
> -						AMD_PG_STATE_GATE);
>  		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
>  				AMD_IP_BLOCK_TYPE_VCE,
>  				AMD_CG_STATE_GATE);
> +		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
> +						AMD_IP_BLOCK_TYPE_VCE,
> +						AMD_PG_STATE_GATE);
>  		smu7_update_vce_dpm(hwmgr, true);
>  		smu7_powerdown_vce(hwmgr);
>  	} else {
>  		smu7_powerup_vce(hwmgr);
> -		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
> -				AMD_IP_BLOCK_TYPE_VCE,
> -				AMD_CG_STATE_UNGATE);
>  		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>  						AMD_IP_BLOCK_TYPE_VCE,
>  						AMD_PG_STATE_UNGATE);
> +		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
> +				AMD_IP_BLOCK_TYPE_VCE,
> +				AMD_CG_STATE_UNGATE);
>  		smu7_update_vce_dpm(hwmgr, false);
>  	}
>  }
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> index b94a77e4e714..a6147db548ca 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> @@ -1957,22 +1957,22 @@ static void smu8_dpm_powergate_uvd(struct
> pp_hwmgr *hwmgr, bool bgate)
>  	data->uvd_power_gated =3D bgate;
>=20
>  	if (bgate) {
> -		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
> -						AMD_IP_BLOCK_TYPE_UVD,
> -						AMD_PG_STATE_GATE);
>  		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
>  						AMD_IP_BLOCK_TYPE_UVD,
>  						AMD_CG_STATE_GATE);
> +		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
> +						AMD_IP_BLOCK_TYPE_UVD,
> +						AMD_PG_STATE_GATE);
>  		smu8_dpm_update_uvd_dpm(hwmgr, true);
>  		smu8_dpm_powerdown_uvd(hwmgr);
>  	} else {
>  		smu8_dpm_powerup_uvd(hwmgr);
> -		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
> -						AMD_IP_BLOCK_TYPE_UVD,
> -						AMD_CG_STATE_UNGATE);
>  		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>  						AMD_IP_BLOCK_TYPE_UVD,
>  						AMD_PG_STATE_UNGATE);
> +		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
> +						AMD_IP_BLOCK_TYPE_UVD,
> +						AMD_CG_STATE_UNGATE);
>  		smu8_dpm_update_uvd_dpm(hwmgr, false);
>  	}
>=20
> @@ -1983,24 +1983,24 @@ static void smu8_dpm_powergate_vce(struct
> pp_hwmgr *hwmgr, bool bgate)
>  	struct smu8_hwmgr *data =3D hwmgr->backend;
>=20
>  	if (bgate) {
> -		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
> -					AMD_IP_BLOCK_TYPE_VCE,
> -					AMD_PG_STATE_GATE);
>  		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
>  					AMD_IP_BLOCK_TYPE_VCE,
>  					AMD_CG_STATE_GATE);
> +		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
> +					AMD_IP_BLOCK_TYPE_VCE,
> +					AMD_PG_STATE_GATE);
>  		smu8_enable_disable_vce_dpm(hwmgr, false);
>  		smu8_dpm_powerdown_vce(hwmgr);
>  		data->vce_power_gated =3D true;
>  	} else {
>  		smu8_dpm_powerup_vce(hwmgr);
>  		data->vce_power_gated =3D false;
> -		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
> -					AMD_IP_BLOCK_TYPE_VCE,
> -					AMD_CG_STATE_UNGATE);
>  		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>  					AMD_IP_BLOCK_TYPE_VCE,
>  					AMD_PG_STATE_UNGATE);
> +		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
> +					AMD_IP_BLOCK_TYPE_VCE,
> +					AMD_CG_STATE_UNGATE);
>  		smu8_dpm_update_vce_dpm(hwmgr);
>  		smu8_enable_disable_vce_dpm(hwmgr, true);
>  	}
> --
> 2.29.0
