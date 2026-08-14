Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7FAC5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 17:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF2C10E190;
	Fri, 14 Aug 2026 17:25:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3acan72S";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011059.outbound.protection.outlook.com
 [40.93.194.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1FD710E190
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 17:25:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXwg415tYUrh+wZw/xd/80DCjtpUzF50Ydjwq3AEeNR7U4Yv4I151prg9SNgpaAVntnSNVeUMRHPatXQx//k06behvWPh/sbfOoSJv2W6KUwnkPng2LI3BjLIsabRY6KOKkIgER0OeFPf6Oyg0m7ueC/HoO619FKc1lNgufXUV15SLlhlRdvJ4b0j/TkUnYtc3VWWtoN5PvrFqffwVdsZaznQenRu0k60774re3JLzC9flm9q9codD4w1nVAKkYVnnHrO/9z2eaur8pNcQiHssF5MqqCd/zh4oacl/9mNqlOU+r+eimPBOym0sQoHhKkEQCgMZ+hgVFNVjl0UbCJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1XhMs8TAQ7m555jVrQJhNTssNd2Lvb2+6e8Ca04E9Q=;
 b=H2H29nffSrU+UTt8nrDtx5+SxcFDrzRq2wGCKvbd3opCt10RxY/6znloS6RIy53bAOkPYu0FF0nqaXq5PtaQetU2iWNzOVyvNe1dliTk7mjl+R1f1VZZylyFAQrY6AgPXjhAaF6x/uCjYxTArY/QOACIpKWG1kBlgW0OlqINdXdpjI6WwR4ec7eSijDBMLTfOtpzt4uCchpR8fkMuuazXLdB03JT7kGY3M+YDy/vaj9Y8/GIHiY8jtmPhAqbAvNhVA+vRGEFIG1AjAU5GmJaBuXNzjn/ckqrGTQH773SJ6GnNOn4fHDUrlmrxyYpr+2pcWk2oX3x6N5+DL8sYOZE4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1XhMs8TAQ7m555jVrQJhNTssNd2Lvb2+6e8Ca04E9Q=;
 b=3acan72SklcVM2VqC1madaF46hk4EM/AJDVogaAWKYMLEhv03IDa9pbHIXZs0Sjxo2p51WNvFuYBZ3wvktTeo3S950C1TafqMfn8m5bbkeVd7svDEtX0viZQFtZ2aaG8CvLP1RAfdJTuWyAEwfMruM/fNENXW6rmgr8EXeYGP6s=
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 17:25:48 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 17:25:46 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Hosur, Priya"
 <Priya.Hosur@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
CC: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Gopalakrishnan,
 Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue
 unmap
Thread-Topic: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue
 unmap
Thread-Index: AQHdLAimb22PfBCNZEqhjo73LVXY17adu+i/gAAFTwCAAAoVJg==
Date: Fri, 14 Aug 2026 17:25:46 +0000
Message-ID: <SA0PR12MB7091F549BC02FFD7312367AF97DA2@SA0PR12MB7091.namprd12.prod.outlook.com>
References: <20260814161841.5906-1-Priya.Hosur@amd.com>
 <20260814161841.5906-3-Priya.Hosur@amd.com>
 <SA0PR12MB7091D3AE34006DC6797EECD197DA2@SA0PR12MB7091.namprd12.prod.outlook.com>
 <DS5PPF78FC67EBA848622BC6037F917872992DA2@DS5PPF78FC67EBA.namprd12.prod.outlook.com>
In-Reply-To: <DS5PPF78FC67EBA848622BC6037F917872992DA2@DS5PPF78FC67EBA.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-14T16:47:49.7760000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB7091:EE_|DM4PR12MB6541:EE_
x-ms-office365-filtering-correlation-id: c699ef4a-7141-4ddb-5ca7-08defa2913f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|921020|38070700021|56012099006|10067099003|4143699003|11063799006|8096899003|18002099003|22082099003;
x-microsoft-antispam-message-info: q3OAK/JwdqtJb6GD+ZZ0cesVkxUogV6UCgfNm8K55ijv0OZ7Aopz+0/AzxLdaWKs7y6ZVJlCsZhzz1q8db0EfvgF4cIlD0MMPglEV5CSset48LHI0pydeRCrkEhtxqblPZOycldnK63JDnqdgRsSxDWiQ4sQ8g40y3n5mWjAKRY+jIs+aVo8vABzQpvPpI62wVqoIgGeT9dIc7jFI3ocszbOGRmFJMBBdc/xEAhZRvkimRfa3r2mjFXlEt38OApzQQJR4FiEwwY9Ap5jM3sUM0HgVw35IO4U/FaiqluQhWn+QPwyXAvYpVM7mLlK+KrryK/ysEXwa7/bxHD+vBjRJbTsiI8Xts+um7UaSF1XoNwCTAIrsd0qRnrF5K7+0pu29z3T19PtkzipW+AHFtGOsBpnPZxfvsMo8sZt4KfbA7KGkxamwnAHHzfgzc0f5EO7jcFbJokPY3uzHu0isiQ768ZNBb3EmlBKu1qEfyLUD+8TGcq5pIsl4QLoc9vv+kNobZfKe0mc9ih+ma9rjGyXfnzx06mAAT+mCV/5EO/GSUrwD7CMlGPkwnD0oHj2wwbV+pmmpkwtkN+CqTlfLcK9cciqGju+sYtgBs8RtRS0Lm0dm18DdhMlPC7sILX+h7b4OYjWIIsLtTlfG7UgVNbkkll+JSssd7GKbEyA/kGstw4Llzsnv7EF5ljtUQaiswbEEnYpm02L6znjjqnQeR3HIS9R0p30hpN/HlbqLR9OlSE+R92moS3Zfe6STIQDpgUO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(921020)(38070700021)(56012099006)(10067099003)(4143699003)(11063799006)(8096899003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j86QEvP/r+IhpYKMViTXPkDPV3LjuEEiyTQ/Nkp+wFmeF48r18vc6RaZypiq?=
 =?us-ascii?Q?/exfTNCKZk7ieJh9lT3M6937dQXsfAw5RtXjvCL+AGpM8qQun6FlZxwDcT2v?=
 =?us-ascii?Q?ALE4L9nNZ4quleuefsG+IFG3Nzz4mpMXgR6RM2bkyxILArzANG1ZqDF57FzU?=
 =?us-ascii?Q?YrAQRlU9sWPDfOSWSHbCAY79K5MNew/ohn7EHN0dPlCXjPtmAGd+pxZmTnLG?=
 =?us-ascii?Q?gCcW69WO743Spa+r4iSswIv0nSINuf3Bfy6KEfVC8TGB1kZifp1ci7xx7oSV?=
 =?us-ascii?Q?dNv4Rwy73P8sPgyY1NIhcMQiQbVQ8Z50E8sucwj9m7Y8uRCJM1PwfoAae2yn?=
 =?us-ascii?Q?L314MtmDIMh0OZEUCtfLXL5DDqYwC0OY+WHWj5+7V2uSsGKl3PfLuPWyUvBu?=
 =?us-ascii?Q?+o4mdDSSPAPh3QCTOcZPTqTloKdYXB/3NJ18WEKDVJvTLS5+RWYk7y2lqje9?=
 =?us-ascii?Q?oVf9XU5LsIAp5vhLpLI1Wz/60xX/o1kVj1GvuJiUwpWFFQEjxQbBHsmhe2rf?=
 =?us-ascii?Q?p99E4Sr+nltK127hM05DXeWyA0DhjnHPrna1g5A+MNVOMm2aY8cmNRnrx7KU?=
 =?us-ascii?Q?wk6YiYzJVtuMAhXdMI2stNnAyAWQvClavUM7O3mz/A1ThWtCi1YRdfFMQLg8?=
 =?us-ascii?Q?pTewS/4azZd0/+fNa5ihraHaSoRUegiscaaKnPByQROrJBioH6UI3LhBhlMy?=
 =?us-ascii?Q?VI5r56StuFeMhqJB2EgJQ/1Neg1btpiWyoip2y87NyN+yANjOgDdYoyG8Sgw?=
 =?us-ascii?Q?VFXHfbv2W9cR7FFrVtJVU6P3y+c1XyePVpOfTOM9WUNqqNbNJB4iiOrMlxfc?=
 =?us-ascii?Q?ZriNEuK/MY3p++M6/vcpXstQLg4l7xm9IwnfdTyZP+Yh0ToqvTEX8FgoQyB1?=
 =?us-ascii?Q?Mznchl1A2aA67Amd9petYBo1/rcwMH4JzVCuZEgSMzH2wXV/ggsfvXJfDrQ3?=
 =?us-ascii?Q?PcoFK5NFvZ9mKDzxhsMHA8rKW26mwJx6uJTMjrE9idqhLRaysBcFmmqGKYIf?=
 =?us-ascii?Q?0IYZNlWc6Xl+s1LR2OXZyHu2u7sl9vfCXmfUoCdQTqX64CsYD2V8t2p4+OF2?=
 =?us-ascii?Q?yn0vcltEykDCFbG/OE+0SwINIKIcB9CIue85THvZNKiXuAwT+6lOgmQBJYcN?=
 =?us-ascii?Q?MLM5Al6E5HemBwNkpb/kLp3jCojw3Pt2hdiQT2M+Zm6fNnJHozGD0cJsqo/Q?=
 =?us-ascii?Q?h74/w4DnIPwKcqdbleCDDrRwW3tGFl01RuwB1M5wvQg9mW8C+21pBOUXYqpO?=
 =?us-ascii?Q?IMitK8AxDDcNMjisnkyfSoVU3jsZ2m8Qe5T9Ig6PQt+nN9fLYVVujffJEHxu?=
 =?us-ascii?Q?HfjR7M+B/qE1cQYX9F4OhffpABY0imxZuAai11Zgl/ySZgR6U3XoyvStJPZT?=
 =?us-ascii?Q?jt4PKi62cFvNXPNLd8OCJKg34QAwrC2IXSXMsjOn2MMVVfTypIDwI6J0BqO7?=
 =?us-ascii?Q?NlRPyIIS6+yOs9wAnmKOOd26aBTPrGd1cfW3RJYhUknNmvByqkjSPsUPRb+k?=
 =?us-ascii?Q?iKuPDSINKHXaIzq1CW/kjHcRkDkMi6a+ZSgZJDvVPs+76lTq8OvCHtB9W1jj?=
 =?us-ascii?Q?urp5+ZGniA1MNaNJIDbztWkZuOpDAWiixqlXWrqyXy9c16DZDYFPqodP/xYp?=
 =?us-ascii?Q?PoiKZyEQdYyTMeunqh3WuliOaCrHRloAMPEShzFj/EX8e8tl0QqCFBx45GEZ?=
 =?us-ascii?Q?3QgEmKshTQ3d5wXpRbTkNELREkuqFGzZ0bkU18mfRbCH8SxxR5deVVJQRtvA?=
 =?us-ascii?Q?eC7KPu5isw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA0PR12MB7091F549BC02FFD7312367AF97DA2SA0PR12MB7091namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c699ef4a-7141-4ddb-5ca7-08defa2913f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 17:25:46.8109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G09/Vadf7lMY8gactb56Z1rhEKuKZn1xvM4zQwEh2x2WpaQTzNr6atTyPs5m1Qlg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541
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

--_000_SA0PR12MB7091F549BC02FFD7312367AF97DA2SA0PR12MB7091namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Thanks for the details. Didn't realise that it is one by one removal. I tho=
ught it was something like unmap-all for a PAS id.

Thanks,
Lijo
________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Friday, 14 August 2026 22:17:50
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Hosur, Priya <Priya.Hosur@amd.com>; a=
md-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher, Alex=
ander <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Li=
u, Shaoyun <Shaoyun.Liu@amd.com>; Limonciello, Mario <Mario.Limonciello@amd=
.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veera=
badhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue =
unmap

AMD General

We don't need to flush TLBs after every queue unmap. We only need to do it =
if there is an expectation that memory access is quiesced after unmapping. =
In the case of KFD, we are doing it when we're unmapping all queues, e.g. i=
n MMU notifiers, evictions or when the debugger needs to stop the queues an=
d look at memory contents. We only need one TLB flush after unmapping many =
queues.

Therefore, MES should flush TLBs after every queue unmap. OTOH, MES must fl=
ush TLBs by itself when it switches VMIDs. This is not under driver control=
.

I don't know what the requirements are for quiescing memory access after un=
mapping amdgpu user mode queues.

Regards,
  Felix
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, August 14, 2026 12:29
To: Hosur, Priya <Priya.Hosur@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>;=
 Khatri, Sunil <Sunil.Khatri@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.=
com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Limonciello, Mario <Mario.Limonci=
ello@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veera=
badhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Hosur, Priya <Priya.=
Hosur@amd.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue =
unmap


AMD General

Hi,

Shouldn't this be a FW fix?

Thanks,
Lijo
________________________________
From: Priya Hosur <Priya.Hosur@amd.com>
Sent: Friday, 14 August 2026 21:48:40
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com=
>; Kuehling, Felix <Felix.Kuehling@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.=
com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Limonciello, Mario <Mario.Limonciel=
lo@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veera=
badhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Hosur, Priya <Priya.=
Hosur@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue unma=
p

Similar to the KFD fix, MES does not perform heavy-weight TLB
invalidation after unmapping user queues. Add
amdgpu_gmc_flush_gpu_tlb_pasid() after MES unmap succeeds in
amdgpu_userq_unmap_helper() to ensure in-flight memory accesses
complete before memory is freed or migrated.

Change-Id: I94fe2c84547723b6b73816ce8d727a54bd773a6a
Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c
index 6d3ed55e9ab4..9fcf15d69b7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -375,6 +375,12 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_use=
rmode_queue *queue)
                 } else {
                         trace_amdgpu_userq_state_changed(queue, AMDGPU_USE=
RQ_STATE_UNMAPPED);
                         queue->state =3D AMDGPU_USERQ_STATE_UNMAPPED;
+                       /*
+                        * Heavy-weight TLB flush after MES unmaps queue to=
 ensure
+                        * in-flight memory accesses complete before memory=
 is freed/migrated.
+                        * MES does not do this automatically unlike HWS.
+                        */
+                       amdgpu_gmc_flush_gpu_tlb_pasid(adev, queue->vm->pas=
id, 2, true, 0);
                 }
         }

--
2.43.0


--_000_SA0PR12MB7091F549BC02FFD7312367AF97DA2SA0PR12MB7091namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Thanks for the details. Didn't realise that it is one by one removal. I tho=
ught it was something like unmap-all for a PAS id.</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system=
, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(33, 33, 33);" =
id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Thanks,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Lijo</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Friday, 14 August 2026 22:17:50<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Hosur, Priya &lt;Priya.H=
osur@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedeskt=
op.org&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Khatri, S=
unil &lt;Sunil.Khatri@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;=
;
 Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> Vishwakarma, Pratik &lt;Pratik.Vishwakarma@amd.com&gt;; Gopalakr=
ishnan, Veerabadhran (Veera) &lt;Veerabadhran.Gopalakrishnan@amd.com&gt;<br=
>
<b>Subject:</b> Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user=
 queue unmap</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div>
<div style=3D"font-family:Calibri; text-align:left; color:rgb(0,0,255); mar=
gin-left:5pt; font-size:10pt">
AMD General</div>
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
We don't need to flush TLBs after every queue unmap. We only need to do it =
if there is an expectation that memory access is quiesced after unmapping. =
In the case of KFD, we are doing it when we're unmapping all queues, e.g. i=
n MMU notifiers, evictions or when
 the debugger needs to stop the queues and look at memory contents. We only=
 need one TLB flush after unmapping many queues.</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
Therefore, MES should flush TLBs after every queue unmap. OTOH, MES must fl=
ush TLBs by itself when it switches VMIDs. This is not under driver control=
.</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
I don't know what the requirements are for quiescing memory access after un=
mapping amdgpu user mode queues.</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
Regards,</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
&nbsp; Felix</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lazar, Lijo &lt;Lij=
o.Lazar@amd.com&gt;<br>
<b>Sent:</b> Friday, August 14, 2026 12:29<br>
<b>To:</b> Hosur, Priya &lt;Priya.Hosur@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Alexander &lt;Alexa=
nder.Deucher@amd.com&gt;; Khatri, Sunil &lt;Sunil.Khatri@amd.com&gt;; Kuehl=
ing, Felix &lt;Felix.Kuehling@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd=
.com&gt;;
 Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> Vishwakarma, Pratik &lt;Pratik.Vishwakarma@amd.com&gt;; Gopalakr=
ishnan, Veerabadhran (Veera) &lt;Veerabadhran.Gopalakrishnan@amd.com&gt;; H=
osur, Priya &lt;Priya.Hosur@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user=
 queue unmap</font>
<div>&nbsp;</div>
</div>
<div>
<p align=3D"Left" style=3D"font-family:Calibri; font-size:10pt; color:#0000=
FF; margin:5pt; font-style:normal; font-weight:normal; text-decoration:none=
">
AMD General<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family:Aptos,Aptos_MSFontService,-apple-sys=
tem,Roboto,Arial,Helvetica,sans-serif; font-size:12pt; color:rgb(33,33,33)"=
>
Hi,</div>
<div dir=3D"auto" style=3D"font-family:Aptos,Aptos_MSFontService,-apple-sys=
tem,Roboto,Arial,Helvetica,sans-serif; font-size:12pt; color:rgb(33,33,33)"=
>
<br>
</div>
<div dir=3D"auto" style=3D"font-family:Aptos,Aptos_MSFontService,-apple-sys=
tem,Roboto,Arial,Helvetica,sans-serif; font-size:12pt; color:rgb(33,33,33)"=
>
Shouldn't this be a FW fix?</div>
<div id=3D"x_x_ms-outlook-mobile-body-separator-line" data-applydefaultfont=
styles=3D"true" dir=3D"auto" style=3D"font-family:Aptos,Aptos_MSFontService=
,-apple-system,Roboto,Arial,Helvetica,sans-serif; font-size:12pt">
<div dir=3D"auto" style=3D"font-family:Aptos,Aptos_MSFontService,-apple-sys=
tem,Roboto,Arial,Helvetica,sans-serif; font-size:12pt">
<br>
</div>
</div>
<div id=3D"x_x_ms-outlook-mobile-signature" dir=3D"auto" style=3D"font-fami=
ly:Aptos,Aptos_MSFontService,-apple-system,Roboto,Arial,Helvetica,sans-seri=
f; font-size:12pt; color:rgb(33,33,33)">
<div dir=3D"auto" style=3D"font-family:Aptos,Aptos_MSFontService,-apple-sys=
tem,Roboto,Arial,Helvetica,sans-serif; font-size:12pt; color:rgb(33,33,33)"=
>
Thanks,</div>
<div dir=3D"auto" style=3D"font-family:Aptos,Aptos_MSFontService,-apple-sys=
tem,Roboto,Arial,Helvetica,sans-serif; font-size:12pt; color:rgb(33,33,33)"=
>
Lijo</div>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif=
" color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Priya Hosur &lt;P=
riya.Hosur@amd.com&gt;<br>
<b>Sent:</b> Friday, 14 August 2026 21:48:40<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Khatri, Sunil &l=
t;Sunil.Khatri@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;;=
 Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.c=
om&gt;;
 Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> Vishwakarma, Pratik &lt;Pratik.Vishwakarma@amd.com&gt;; Gopalakr=
ishnan, Veerabadhran (Veera) &lt;Veerabadhran.Gopalakrishnan@amd.com&gt;; H=
osur, Priya &lt;Priya.Hosur@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user que=
ue unmap</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_x_BodyFragment"><font size=3D"2"><span style=3D"font-size:1=
1pt">
<div class=3D"x_x_PlainText">Similar to the KFD fix, MES does not perform h=
eavy-weight TLB<br>
invalidation after unmapping user queues. Add<br>
amdgpu_gmc_flush_gpu_tlb_pasid() after MES unmap succeeds in<br>
amdgpu_userq_unmap_helper() to ensure in-flight memory accesses<br>
complete before memory is freed or migrated.<br>
<br>
Change-Id: I94fe2c84547723b6b73816ce8d727a54bd773a6a<br>
Signed-off-by: Priya Hosur &lt;Priya.Hosur@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++<br>
&nbsp;1 file changed, 6 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c<br>
index 6d3ed55e9ab4..9fcf15d69b7b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
@@ -375,6 +375,12 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_use=
rmode_queue *queue)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace=
_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue=
-&gt;state =3D AMDGPU_USERQ_STATE_UNMAPPED;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Heavy-we=
ight TLB flush after MES unmaps queue to ensure<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * in-fligh=
t memory accesses complete before memory is freed/migrated.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * MES does=
 not do this automatically unlike HWS.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_flush=
_gpu_tlb_pasid(adev, queue-&gt;vm-&gt;pasid, 2, true, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_SA0PR12MB7091F549BC02FFD7312367AF97DA2SA0PR12MB7091namp_--
