Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1204C43217
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 16:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 164C010E1A3;
	Fri, 10 Dec 2021 16:06:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48BAF10E1A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 16:06:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrHWtbO/Hwxdmnt0MSC+Ft81HCPBKZaHrPraLrpf2YsVZKa3289a1odpXH8/bAXBDxStpVLtR3TBiIdGHwcb52TuIIPPLBMlXW7t5ShY8DYC09D4FykOwIovYAoHlcua90P/YGetdmD34wnSgofhhp1rNa+VoK7AEwdHjc5Ihx9TwEeDRwDSRshO6/7ATOGdFoLxdHAoFynoqZzCNRzZBHP3bxk76mBebdzAwQpFWHytJLnt/bzQBbjyhsaqQtb3XO0QcRG1T43nLym1XPZ4rf01npFd6ngcvaxqRuvmtobI+HhV/1B+dIns5ZpYjpZpKIM5tgSzF3efWMSkzmcNzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VGbpJnMMNuMZp1dLLW9Ffc3BT6Qmhwk2rFm8/t9vBw=;
 b=CpWHZE2VM9PeM99LXj9V9pmcGtlVyYt7WWBoVLBxObhvchFNUJhgoTnN6VxIvcUPhsCfHn+ljAcGwVP2sw5fl14ZkVMFWj05Xr9oXZ2x7TXkjuhG2SMWyeK/MJRtc0elOChHj/Z1dRPAzkCCmgV+gjQBTNzuT2KbKpv8g5M2rDWaY3MeIQ/Qpwrq/a1dljp41PbnGIo86b+ZH+rumHZH0pWehYUKK8yU3r+eOKOZLAcFZnqzzqLV+e8FMiK5kcnoKDowt6CHb/T+YoLVAnc9vWmYxBnUH12l6THWOkqTMHcwxjsXq/YTUuVWuRnZfwiHA0Rlp+PN7bGuIKc9/aps2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VGbpJnMMNuMZp1dLLW9Ffc3BT6Qmhwk2rFm8/t9vBw=;
 b=nrTymHy+BU6gbKYkIgd870LGpl1hNVfcJ39Kfnaxhsuo9cfJ1LPCXGJb4B9HkQ2mxU+2n84kZZO+YY6C/ZrBd2q68yyyWIdW3GQSqj1+WssSi2o8n3zDspRY372ZXf3z5fD9OZw6ucRtruVF0mBHzyopYrMRypbsxau875OPWEA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1867.namprd12.prod.outlook.com (2603:10b6:3:10d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Fri, 10 Dec 2021 16:06:29 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4778.015; Fri, 10 Dec 2021
 16:06:29 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Gong, Curry" <Curry.Gong@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
 powergating is explicitly enabled
Thread-Topic: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
 powergating is explicitly enabled
Thread-Index: AQHX7brzHYmPYDzJVEu2BZp1426D3Kwr21oA
Date: Fri, 10 Dec 2021 16:06:29 +0000
Message-ID: <DM6PR12MB2619D53D25DD05BC41D5A4A5E4719@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <1639136511-6357-1-git-send-email-curry.gong@amd.com>
In-Reply-To: <1639136511-6357-1-git-send-email-curry.gong@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-10T16:06:25Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=04533596-518f-4842-bf74-1ba8fd166d2e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cfa00c2-fdcf-4ac7-8420-08d9bbf706da
x-ms-traffictypediagnostic: DM5PR12MB1867:EE_
x-microsoft-antispam-prvs: <DM5PR12MB186785E5B1BB72229EBECC31E4719@DM5PR12MB1867.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7QvMSCR5Nx/z7XU8HPaGhF7kFHNXpEP0btOCsHpVBEmhoHJGh9kfjTPbuHIlo+dVxNj4IdNEP4Xp5ZkHnx1SpEigZZL3HdFlHAwrwHRY/yxrDT4FculPrDXIlfFiWqvXsUd+gVyST8TD71K18d8G03HXBNMgfVOrq/RFnDMKlCHrmPOYwbndhKgIyA49OPTtmpchEzJ6+4eccmXfVQ8wt819+C61YuG0PVHPr0sRhlFKfgnwSIFhy1TMo89w2hopMgiVpLY7jcWPO2sHHucLjB0oPnrHTsf5dlbP+VddL5wja8+8D53UqqZi4fpRkSuVE0CI/IJrefZlgblXyhLNePy6AC7BtuDwAlMiU03oS7CTnaq1Y9b2cN6hah5U75MQh0MrU5nVe7RfMB8yGZIUsDQOMIH2g1cIv0gmKqKBUjzwXeXpWh+Sr0bs4QjJw6tQNwv+v4F9UthzXI7SDnokgCAqnRAJFUrtLhef7BbVAwJGIoDG/ELIYGWgFcKxmje5+KOBmM+mh6y/91AUuwWyDTtSS8+lZWX5OSyDBk7OkK56ylGZvxPx24q2RzYvGrTohIbBZdnbZ7wIwlmDU1TrXyw9hpi50NEZMQwKzZZOna2CIy8TdhMbUwsXSKb1QX1KlnLNBCKSk4sOGs7iga0ABbFxHJ+8UUHGo1m2NIQXtuWaImjy1eWRWupf1B2bwMEQ8yjRHHGMwyOVUMYNRRqcQw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(84040400005)(66556008)(8936002)(55016003)(2906002)(53546011)(66476007)(6506007)(71200400001)(66946007)(64756008)(7696005)(52536014)(316002)(966005)(83380400001)(76116006)(86362001)(66446008)(54906003)(110136005)(6636002)(4326008)(9686003)(8676002)(38100700002)(15650500001)(122000001)(26005)(33656002)(38070700005)(508600001)(5660300002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tqsV0ZioUrpXj45a7n06J+wWnyJG2cqf3Alg+gGS8SfCIz2I+hWdKsGHH5fr?=
 =?us-ascii?Q?AXYTywe+ot7a6KM7njTM0nrwNIq+LM48CAo1LnVk8Yp+cpu2XVdKibmOWP5I?=
 =?us-ascii?Q?Cioz4VWCRlIikyp6iqsm58Wbo1HXF9Y6EIp1HfBN9OTANWFfAJSIcHxcsfs9?=
 =?us-ascii?Q?Mq/h2LHSS5zEJKnA5hpai51/kX1JaLXRVD7rIWXyAppDZbSyrtGOCQ7L5Dm6?=
 =?us-ascii?Q?yDnZh6Rzu8/+7Vz0oiLq0qN6MlaSoAIe8cZ/zI6Lrf3HPdvV3EVRbqnSIN1H?=
 =?us-ascii?Q?15d+tBnTDQFxFBFwmrtq+ELjqv/FaMjxmLECWFN5XRaxVX0fDGhoizR/6bnZ?=
 =?us-ascii?Q?GqgL9xZKrmU++hP5iFmvbj5BGFC/LI+D1JDGeyYJPYNmN2ShQAXxXeFbiGyl?=
 =?us-ascii?Q?3bJHHwBZ+1+76xdMc5zyus7mr8Yw7LVDWzDva9IeWdtgVnG6G3UbpdCgX6I/?=
 =?us-ascii?Q?cr9LxsADnXCs8Jq0sEjfidnpHNGgeAo402Q/42+w+JyI2+7bsyejqrd87Xen?=
 =?us-ascii?Q?Dog9th8kagjWeZUxAsk02zHZ28o5J6RpErcywUOKbWY/JtZb6kwTrTvcb3rd?=
 =?us-ascii?Q?bPw2GDLzdiMttR1KWbqFvBE3gWn9Tzh0meHoiYdehAJ+k+2zcUn1AaR/8XeS?=
 =?us-ascii?Q?6zVcRDziwvseUtx78T0sM/YCFYi/t1MSuFgrDaaOCdasZNuYQOO3qz6LE9+Y?=
 =?us-ascii?Q?eH5862T4mJLBZgcAPYcsK4JzNLLAaPnZdketf9EmsJkjGVupcnulsSUPG4Bu?=
 =?us-ascii?Q?t7i6PeB8UpRC3YGo/FL8K1pvxfC+dYzZOW8BBj6wpAw45Eb2EI3Pb2lgMi0a?=
 =?us-ascii?Q?8oktdDmYwm+l2jsK4gC4GUtnEvRkG+7HLRraZ+C8bk3nevkaR9HOpa/afQ3D?=
 =?us-ascii?Q?8gY0qMlrK+T4omfCw1zuC1mMD544RWLF5l3/YPko0434PSSh8ToSFbYiwUU/?=
 =?us-ascii?Q?0R3BPRWgZLLUM8DYGzpgwqceCCDw7rMuxinCmkYxYvUuHaM1tkw6SrEUCNH3?=
 =?us-ascii?Q?WcUYcESUqwvtZNSwORKcR7VATfIUs2NZuwMIhPxlFicunbr7fHyyd059majf?=
 =?us-ascii?Q?hNv9rvGGzhS6NNY2sfpDejhf+nmOXThfEfqYEpqd5fU/i5MUoRept80KwR4b?=
 =?us-ascii?Q?RGE1gVqotKYgtNZKNRSw28LMJoXyEI17UTLq9tOUOvP3MbsMtplWT77hJjt3?=
 =?us-ascii?Q?HA6aSArQFm8PH3geiUQIdQX49XVF5UKwd4e8R+0wNaRnc61Qa2cfMbl3+ylh?=
 =?us-ascii?Q?EngtUfhlLoBvK5SkbwckAvfNdLYfeyzdBhap7kA9opzNrI78G70qBa6qkrKo?=
 =?us-ascii?Q?vN8lj8BQKpVSocD/rPuf4CjENfxKa6mJCWuQw9OVgOmh2GgmOeevC0blNJPi?=
 =?us-ascii?Q?gnkcxR9ANrLUS26FAqvHtc6/ww4nhE5Xgs2pZDL/SqVSnDwmBf57pHb36FYy?=
 =?us-ascii?Q?i2aJm2LPXiSGqW5g9bK5vecKuGXA3bbItp4Q92k0+MvLG+xK8qh/McJ11ypX?=
 =?us-ascii?Q?msYV8D6LCwumfGUL8XNea+GyRmJeFTsSyljuCbKYY7XevEpDwiQj/Jh4JPrA?=
 =?us-ascii?Q?XPKIFeZCGLag5h7TYWA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfa00c2-fdcf-4ac7-8420-08d9bbf706da
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 16:06:29.4167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQLQoXe8YtAm8OdL+cUUrQlhaAjqG5Q7/GOMVe6zocIqL4IY++xxWUy8AzR12Cnn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1867
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
Cc: "Zhu, James" <James.Zhu@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Gong,
 Curry" <Curry.Gong@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Curry,

Some nitpicks below. With them fixed, the patch is reviewed-by: Evan Quan <=
evan.quan@amd.com>

@Deucher, Alexander this should be able address the issue reported by https=
://gitlab.freedesktop.org/drm/amd/-/issues/1828. Can you help to confirm th=
is?

BR
Evan
> -----Original Message-----
> From: chen gong <curry.gong@amd.com>
> Sent: Friday, December 10, 2021 7:42 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liu, Leo <Leo.Liu@amd.com>; Zhu, James <James.Zhu@amd.com>; Quan,
> Evan <Evan.Quan@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Gong, Curry <Curry.Gong@amd.com>
> Subject: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
> powergating is explicitly enabled
>=20
> Play a video on the raven (or PCO, raven2) platform, and then do the S3
> test. When resume, the following error will be reported:
>=20
> amdgpu 0000:02:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR*
> ring
> vcn_dec test failed (-110)
> [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP
> block
> <vcn_v1_0> failed -110
> amdgpu 0000:02:00.0: amdgpu: amdgpu_device_ip_resume failed (-110).
> PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -110
>=20
> [why]
> When playing the video: The power state flag of the vcn block is set to
> POWER_STATE_ON.
>=20
> When doing suspend: There is no change to the power state flag of the
> vcn block, it is still POWER_STATE_ON.
>=20
> When doing resume: Need to open the power gate of the vcn block and set
> the power state flag of the VCN block to POWER_STATE_ON.
> But at this time, the power state flag of the vcn block is already
> POWER_STATE_ON. The power status flag check in the "8f2cdef
> drm/amd/pm:
> avoid duplicate powergate/ungate setting" patch will return the
> amdgpu_dpm_set_powergating_by_smu function directly.
> As a result, the gate of the power was not opened, causing the
> subsequent ring test to fail.
Better to update this as some descriptions  below:
adev-> vcn.idle_work will be triggered when the VCN ring idle for 1S. And w=
e rely on it to do the VCN gate(power down).
However, if the VCN ring is still using on suspend kicked, there will be no=
 chance for adev->vcn.idle_work to do the VCN gate.
That will make driver wrongly treat VCN as ungated(power on) and prevent fu=
rther VCN ungate(power on) operation(which is actually needed) on resume.
>=20
> [how]
> In the suspend function of the vcn block, explicitly change the power
> state flag of the vcn block to POWER_STATE_OFF.
Maybe some descriptions as below is better:
Manually do the VCN gate(power down) in the suspend routine if adev->vcn.id=
le_work does not(have no chance) do that.=20
>=20
> Signed-off-by: chen gong <curry.gong@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index d54d720..d73676b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -246,6 +246,13 @@ static int vcn_v1_0_suspend(void *handle)
>  {
>  	int r;
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +	bool cancel_success;
This seems not a good naming since the cancel always succeed. The differenc=
e is whether the idle_work get actually executed.
 Better to rename it as "idle_work_unexecuted" or just "vcn_not_gated"?
> +
> +	cancel_success =3D cancel_delayed_work_sync(&adev-
> >vcn.idle_work);
> +	if (cancel_success) {
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_uvd(adev, false);
> +	}
>=20
>  	r =3D vcn_v1_0_hw_fini(adev);
>  	if (r)
> --
> 2.7.4
