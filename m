Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43148C433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 04:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C1961934
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 04:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C1961934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B05889FAC;
	Wed, 24 Mar 2021 04:22:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8202189FAC
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 04:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=St3+W770dGXsR0xhErspyTeT+hk/sSzlQIjVJq0t15/DazSSll4brzskWxy+Zmst5/VToZkJt+qNtyb2EmC1oM4o4Wz54JnprVKR5bOYP7woxkapDx2D4Vh1kB0/HFu/sjZMO5Pwng4jsQCZ/F1PKEo1DnpSGuaGTPnYW3ly9XjZuvnutubt78oMrno9AAyzm+AyxsIHZARGNml2V9yv1DeXiSTISqsVO7R2ks+FbThmsSov0yR07DopKKmPfuAGly/qInKf+MemMmKdf9u/BqbeIqunXs1sAEoq8kfHWMv7Cj/u3vLaN0OcAlveF/oFJnHx72/8XrBeJno99iGfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4PyLNIvv35tpkrqkFBU+Gr/FgqWulv+k6/a12Tjv5c=;
 b=Z1m8jIZoIuXq+mKo7MhOnzEwD+pmzG8w+EWwyeEJ/i7SUQgUvPpaVdlSfGoZnNmwafzc3dU0R+4nlNaCeZksM17Pn6QIX5ca+pUJDoQPnMbr4fFO/7rxyfBk9pGS50YvoD5jz37glUbCo9LiDVO23mXzRxNGWJw+Stw7xcXX4+Co8PbJuFPvaHM6KSoqSZv8mCir9BEZm7aD2vb1Be0fKLz0jYiHF+Awwp1HcT+3b2MIPOR42Mk6MLjNravRefFu1VFi2G0Xh0G/Wfhvbco0kqDEHwFd6tEsG63pzneFJ3kjzVNNSI4voh0XAfHrxdHbhZwEYZ+sE/nuLfzsxj8/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4PyLNIvv35tpkrqkFBU+Gr/FgqWulv+k6/a12Tjv5c=;
 b=A+vqucYAULC+Ss8Bjo9GaLsATjh14UhFR/QX48Ch1gQi68/CV8YoyCyAj3KEDAMfKX0i6xltWW7QqQl1M4HRMmIDe9dYmuptonXW9lNyu/gT0V+7SGY7xBgMwt4xz6fxKFjdPNP75zjHFEEmIZbGBuvbA7RI/Xs9wBSYSLj43kw=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 04:22:16 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7907:4699:3faa:e290]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7907:4699:3faa:e290%10]) with mapi id 15.20.3977.025; Wed, 24 Mar
 2021 04:22:16 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Chen, Horace" <Horace.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: move vram recover into sriov full access
Thread-Topic: [PATCH] drm/amdgpu: move vram recover into sriov full access
Thread-Index: AQHXIGTD723rTxwY3k6sLyC9v1PJQaqSiXMQ
Date: Wed, 24 Mar 2021 04:22:16 +0000
Message-ID: <DM5PR12MB17080E018632041395FED61F84639@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20210324041826.11083-1-horace.chen@amd.com>
In-Reply-To: <20210324041826.11083-1-horace.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-24T04:22:10Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d266ff77-0494-4e0a-801f-551957216493;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96d0abbc-10f2-4371-be01-08d8ee7c680a
x-ms-traffictypediagnostic: DM6PR12MB4043:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4043486CB8BF1EA3A1DB704C84639@DM6PR12MB4043.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9LU5WiaiEJrgNfW+6OJKQHT6crrlfGVzfFZsEMafXYXKOsOVB9Cydg3ukCMYp0B3OxMNwI4TDy7eGtvTkhqCtiig+VhfKTKflYQbmoOzLNKe8TsVXdnOM6qq7JDMzvURmqeb0x49EZE3gsUS+bhBu56mgy8B03d/5/WVg0rGdCEHEnMzvBCBOOjSnhXJGq0p7Evo7kZUYLPH65q2ukCW5WeMjw+yQIZTvpfypiRvtvofjdv02XnbyknE9SeUG+JvZI8+gzvnEmr+yQQBdOlmSwQqhbcIvzfdWJVew1m5Eh0VXLBEr9jumMVD1Q8pODeeE/EcQEv5zjGuGByM0RkzofEokLouxjU6bUgk6J39j7kNmDgY/gkKwdOhJhOsIRexO//4DeAwo8WTRH5FIh7d7+DeE9yFeQRrQJ6o46cfbb/zkvV33CpFo8slkOmrDNi/PCzrNIW4hY3xvk94sxk1E9ZSzF+NWx7pKSTbXISOej3TFoSiVOkGM9X2yPFrtJskZnKRQTCfXWsT4aSZVDuUOw4Tvtc4dG5jtLVQ8Pl1wmptnwFoa+UGeZGHsxSykvoKEUEDgsxDq2PHFv/yWqzXaHpnJw6SXSuZWtC1OJX9WwVQNCs+QVjv71UTpyoI3fSLLT2kxiocCy15ZVnjKair9mpdHr77pqUMtNkxa6gGOhs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(66446008)(64756008)(76116006)(66556008)(5660300002)(2906002)(66946007)(55016002)(71200400001)(9686003)(186003)(52536014)(66476007)(83380400001)(8676002)(54906003)(8936002)(110136005)(6506007)(7696005)(53546011)(478600001)(4326008)(33656002)(316002)(86362001)(26005)(38100700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eeGDeoPwGRtqL8igjgOMJmD9/GAHmNTjGYCi3AkxAg3vFn6KCPWvdltEM7I9?=
 =?us-ascii?Q?1Eh/RrnvmUeR3Nq9yuKZ9hn6ivK5NT+ujWM3QyOAx5wqbNUA6qcYLH2P2EcH?=
 =?us-ascii?Q?+RU+z7+oPUCerlHVd37bKHpWAKlU/vJaqn3TDxo3FPkg6193jS/jxup9YKLP?=
 =?us-ascii?Q?ykOCDUKJJl7MRBHbtkyxJrpCXsd/8KzTyvlkG5Dr6IoTPMlGd5IrQpngq9xx?=
 =?us-ascii?Q?xsUVgcQ6jbFgIQITIk/z5a5Px/EU1/1Vwl2oEHNrf8tXbENc0hbiBYph4FhP?=
 =?us-ascii?Q?Zule+nuRcEYgKoV1qe5XqSuAx4GjE1zhk9ZjlyGUa7PxYCxACowvH6c0YbQk?=
 =?us-ascii?Q?iOC5S2iy+/IOdfml7Erex5Em24Qk2SZOq8QPL8rQRHZ+ycfCPbvq/Ku9FqPI?=
 =?us-ascii?Q?bIRilRwh1EULEsaQMAuGhC39DX73xKfM1kwplx0iIm2dOqgmr6rxju7LY8jo?=
 =?us-ascii?Q?uUaE5jnB/PzppY/SkPdnwjlgKMNYB1ddm6NnhhIYBBjCdrtu5uYr+PFK4u97?=
 =?us-ascii?Q?lqdYZPVeL324IY0/tLUO3Ob4EuHlEtQvBlErnhhUJymTFJ3W82UpubMg4agN?=
 =?us-ascii?Q?wmgt5Q5qGYaYHsXbFvg5/7PJfUZVy3b4t0UZ9rnEe4UbZXFlKT/QMsIcaxAw?=
 =?us-ascii?Q?h21LQmdj6nSQCZuQIwvT9XaidylXNAZNYybmdeWZqMF+dqbyUlU73mkX7sn8?=
 =?us-ascii?Q?fGQI81EmfbzpiZiepoYfJAJKpeWbz3gHgZGU4RvNZVItHsYg1+jxqqbJx+U4?=
 =?us-ascii?Q?LjytpGFFuwnF+V67mkj9modgXcEQlOW8ecKkWjtiUdJ9HBTPo1UCMRpeK9MO?=
 =?us-ascii?Q?rx+JshTm1Z39REzZTJAz1O3VWJSe0RYFtocxmZFPsSuuvedMtLsHeYWweZnU?=
 =?us-ascii?Q?CrN9SXvQYamv02u1n8v68jh+yI4UHH+YbTcRbx4VTvbFk+NDEhhc1Le3BsRF?=
 =?us-ascii?Q?AYOCRA4c4ywayTYnbKy9IxU2UBG8AQczgX1T/bqLf4gUAAQbcIekuu2U62Kv?=
 =?us-ascii?Q?cLWziZpu/zr0RFjQd6WVIEENp1egKgBdu3IsF3H6ra1KgvX1ykonMxhG5V0/?=
 =?us-ascii?Q?UKh0m06z0whkZKWqJpX75fAeT6e8VVbDJLmTELDs3SBstVXhldzSVjYRPBQZ?=
 =?us-ascii?Q?IfhnqCfSiqCyvjb3RUtIWVJ20sJpYmL0qGgUzQdETHT7MaC4Zj0TZeeyB1Mx?=
 =?us-ascii?Q?LdJDxgMv9SK8YJuFdblCN4tfmh3yyfc+3oJyOj3G4nkV67cXtbWpTmG8FO4C?=
 =?us-ascii?Q?Su2qBaQqvb92U1BODcRfVZhn8t7AQ8dNKsKXPFo1stdt01WcqGPbmOQTRk7F?=
 =?us-ascii?Q?BcUQE9l87zacCn5h6o/jsY/O?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d0abbc-10f2-4371-be01-08d8ee7c680a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 04:22:16.1175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FgvAQf8zJ2xApHi9nxUJ3bjMB4jlOrAyU2cuYLmQ9wyGQjU8E36t4E6U/Y69jKCK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed by: Monk.Liu <monk.liu@amd.com>
------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: Horace Chen <horace.chen@amd.com> 
Sent: Wednesday, March 24, 2021 12:18 PM
To: amd-gfx@lists.freedesktop.org
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Xiaojie Yuan <xiaojie.yuan@amd.com>
Subject: [PATCH] drm/amdgpu: move vram recover into sriov full access

[what]
currently driver recover vram after full access, which may hit a corner case that meanwhile another whole gpu reset may be triggered by another VF, which will cause vram recover fail then fail the whole device reset.

[how]
move the recover vram into full access. So another bad VF will not disturb the recover sequence for this vf.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bcb2c66437a2..23d3bb761319 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4103,11 +4103,11 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	amdgpu_amdkfd_post_reset(adev);
 
 error:
-	amdgpu_virt_release_full_gpu(adev, true);
 	if (!r && adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
 		amdgpu_inc_vram_lost(adev);
 		r = amdgpu_device_recover_vram(adev);
 	}
+	amdgpu_virt_release_full_gpu(adev, true);
 
 	return r;
 }
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
