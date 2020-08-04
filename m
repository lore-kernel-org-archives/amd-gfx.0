Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD1EC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 08:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90BF92086A
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 08:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BKRPwXqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BF92086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B14C89FED;
	Tue,  4 Aug 2020 08:01:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C612E89FED
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 08:01:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWO8obzXjSZ2jAw4bNam+MXdn25ZbEaa3ZxWKi9SEfGGtgDUPbBKigKUS/TFe0XnPYPmOwqrQjKq5WNjr6Kf3VPtMA0b3qEHnvUYPv4a90sj+qO3PyxECegFOKm6SLRpreC6uuZo4QYWn8SCu/uECd+ref4ScYLBZwCAIbJP6uMizt278Pm0l6nz1Ci5LjHjgYVCPDAIaq0aA6LmXuLS8U5NIsaIgazzq/sdLTCpu146xf5fFhJOjeafiLOAR1mYYzT5XGs/QAP44iPTIuJ9Ax6V+0JNXdBl0Hy8PsCqvkVKYhUZQtGFhI7jKv6pBNyWzHdC/2C8iTMKuQ8nzVIlQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRnLMX/m74i31P71B+jlmyZ9cPRrzDWdhdV4SJMoS3E=;
 b=EPc8YQHhkvBMol0ktlofYiAcjf/yvvVB8PzTo6e84GTAGccrp6EqmbVd/K+Jm5m1QiGa/vGVlNUFMboRm+J/QOvALjsqskDLqzFjgScK0xQaP/fAOlDhlGgxcUrwXOZjfw5aK7nv4bLYDsvrcVqilyGrmbmXnfpOeJZZ5OXVhj8AH245IICaoCI8dt55/IM3c110xbN+KkDfAzp9waBnn+3duXPu9HgwW6AElGij4YXcWIbTQNxS+4Wd1TfJQDbbZkd92MaKLi8FN9DjgGMIDKuJfSDzRDR17wf3vAjqNOOL14KVWo4e+EfGKyB2JVNimjeef5SAuvaL/+IkB9RR7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRnLMX/m74i31P71B+jlmyZ9cPRrzDWdhdV4SJMoS3E=;
 b=BKRPwXqFh5tZnyiASYt5RFSdLBg9NL1CIp1v/mz5mAKi5D1Z2vr/AoXnMOqaX0mORZCkcbb9CgS2y7HRtSwRGuM06zOfINKP8muU6YXZpo4nvDt8QE9C2sEbKsYSZIKvqbc83TnBwxvwBI9vYLi6keJzuhAutxwrtCp3loz+MYs=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB3875.namprd12.prod.outlook.com (2603:10b6:a03:1ae::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Tue, 4 Aug
 2020 08:01:29 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::44a4:ed66:ae1a:8cc7]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::44a4:ed66:ae1a:8cc7%3]) with mapi id 15.20.3239.022; Tue, 4 Aug 2020
 08:01:29 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix reload KMD hang on KIQ
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix reload KMD hang on KIQ
Thread-Index: AQHWZw9gOm/6jETzQES/qGGLz6T4k6khttqAgAPtJQCAAd+jgIAAGJdQ
Date: Tue, 4 Aug 2020 08:01:29 +0000
Message-ID: <BY5PR12MB4115C77DCAD6DEFAFAA67E4F8F4A0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <1596181868-28879-1-git-send-email-Monk.Liu@amd.com>
 <a1c5e0a7-d392-8774-d6a1-decb4f9c3235@amd.com>
 <DM5PR12MB170890EFFDD63DA297CDB254844D0@DM5PR12MB1708.namprd12.prod.outlook.com>
 <DM5PR12MB1708B1EBA4B3F695A808F85B844A0@DM5PR12MB1708.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1708B1EBA4B3F695A808F85B844A0@DM5PR12MB1708.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=926aec95-41fa-483e-8e1a-0000aaad0075;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-03T01:51:20Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3bdbfab-8fd4-49eb-dfdb-08d8384c985d
x-ms-traffictypediagnostic: BY5PR12MB3875:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB38750A7775C1C8B6E3B9552F8F4A0@BY5PR12MB3875.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hdjvkbRXS96Lk12CHu9RuMr2aXZVq1Y/6lBCGJwRRBklKnQw/+E4sJOTtoyTKbmDeD6oxvwzXZIcCh2zKOAoEtaRASIKjGehNSt0hUYNJdRkArX8Hsgoki75gu9ULXXeOhSLb5JNGzWuxXdEtWZYvv12zDnpcoFTyJUSU+GCp8Vf1g/QMHZN2PjpuHtwsisRm522jxqe2RStf3+zUJZu9HYbQLWncGDMMJeZzGkEFwuFBEdjHEdwBQ7yihqtfAnEnGphrmTE1BRwrtTVJ4DtO2se9KN0OVvocjocQNFz9uD/MG4CMWfVq11SMxXn3US1Vh4XWuNMr7TLNH1J/nYrYG48U1SLESkLK5a+srTcP3U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(110136005)(186003)(26005)(52536014)(83380400001)(2906002)(5660300002)(66946007)(8676002)(64756008)(66446008)(66476007)(66556008)(6506007)(45080400002)(478600001)(71200400001)(33656002)(55016002)(86362001)(316002)(8936002)(76116006)(9686003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: lBjG8EI0kWmGAfXPbyHHSO9gc0p2FG/DQW4Du0qQvQRyp3xTxajS2vlzjw+VnGzEdEnQshZ+pPNMTLcuXt2nIbeNhO2uA/8QGMtr0sPlo9KH5gFlH2muoDTQZweYmX436oVTn/bs4lsbTh/iv5db1IUcawnlb3NyEICwHpFWO9r2HOR2LClcbSph7e0FzKSRQAc7XlWktcMOcIiqkSk33YX6hBVta0Sflt4ukvCPUNEQW+RwZvCmokZ7wgy31FdgZUD/JcssyfHUjOpn8c0yr9cxr8DF0D1yX/d9ESv4kpR8uZb+Yn4Nhh+c7jztjVoVLUm8pIYtdD8DqrU5HBH1MiVMnK2B66oeaHih6rDRDTfsjr33AcU6Xb5AkEmeBkDAIVCmGZlkOlOLOpOdn90BROODJtxCEaVP7+Tp8gonT/hQpZF5k0+c4z6+DKypfEE3IT4lQ466KOcHJzbH5ubRL15NcjEeExavdsjVJYxFIOs5/s4ZQpXjTbSor5o+l+Zb0yNlZJzbfahqu+ONax71rsIDAZnAUuTUOfcg7Pkkr/YZSEqunZTPIuaBKsJSSI3lZ48JEJ4/ZobarCtd516ZR0fa/vIxqLYqR56rR/3FmK3wAVvMeAqBJnhjl9JW7pUlMfEOhWo2MYzMiex8Yjt78g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bdbfab-8fd4-49eb-dfdb-08d8384c985d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 08:01:29.5504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vj4d+bj5mbuRoNiqO2fM1MryemBovFUzHXCizOadxeW0tpWwndPzVxm+Xch+Ampa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3875
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu,
>Monk
>Sent: Tuesday, August 4, 2020 2:31 PM
>To: amd-gfx@lists.freedesktop.org
>Subject: RE: [PATCH 1/2] drm/amdgpu: fix reload KMD hang on KIQ
>
>[AMD Official Use Only - Internal Distribution Only]
>
>[AMD Official Use Only - Internal Distribution Only]
>
>Ping ... this is a severe bug fix
>
>_____________________________________
>Monk Liu|GPU Virtualization Team |AMD
>
>
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu,
>Monk
>Sent: Monday, August 3, 2020 9:55 AM
>To: Kuehling, Felix <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org
>Subject: RE: [PATCH 1/2] drm/amdgpu: fix reload KMD hang on KIQ
>
>[AMD Official Use Only - Internal Distribution Only]
>
>[AMD Official Use Only - Internal Distribution Only]
>
>>>In gfx_v10_0_sw_fini the KIQ ring gets freed. Wouldn't that be the
>>>right place to stop the KIQ
>
>KIQ (CPC) will never being stopped (the DISABLE on CPC is skipped for SRIOV )
>for SRIOV in SW_FINI because SRIOV relies on KIQ to do world switch
>
>But this is really a weird bug because even with the same approach it doesn't
>make KIQ (CP) hang on GFX9, only GFX10 need this patch ....
>
>By now I do not have other good explanation or better fix than this one
>
>_____________________________________
>Monk Liu|GPU Virtualization Team |AMD
>
>
>-----Original Message-----
>From: Kuehling, Felix <Felix.Kuehling@amd.com>
>Sent: Friday, July 31, 2020 9:57 PM
>To: Liu, Monk <Monk.Liu@amd.com>; amd-gfx@lists.freedesktop.org
>Subject: Re: [PATCH 1/2] drm/amdgpu: fix reload KMD hang on KIQ
>
>In gfx_v10_0_sw_fini the KIQ ring gets freed. Wouldn't that be the right place
>to stop the KIQ? Otherwise KIQ will hang as soon as someone allocates the
>memory that was previously used for the KIQ ring buffer and overwrites it with
>something that's not a valid PM4 packet.
>
>Regards,
>  Felix
>
>Am 2020-07-31 um 3:51 a.m. schrieb Monk Liu:
>> KIQ will hang if we try below steps:
>> modprobe amdgpu
>> rmmod amdgpu
>> modprobe amdgpu sched_hw_submission=4
>>
>> the cause is that due to KIQ is always living there even after we
>> unload KMD thus when doing the realod of KMD KIQ will crash upon its
>> register programed with different values with the previous
>> configuration (the config like HQD addr, ring size, is easily changed
>> if we alter the sched_hw_submission)
>>
>> the fix is we must inactive KIQ first before touching any of its
>> registgers
>>
>> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index db9f1e8..f571e25 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -6433,6 +6433,9 @@ static int gfx_v10_0_kiq_init_register(struct
>> amdgpu_ring *ring)  struct v10_compute_mqd *mqd = ring->mqd_ptr;  int
>> j;
>>
>> +/* activate the queue */
>> +WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
>> +
Could we move follow to here?
if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1) {
WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
for (j = 0; j < adev->usec_timeout; j++) {
if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1))
break;
udelay(1);
}
>>  /* disable wptr polling */
>>  WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
>>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7CEmily.Deng%40amd.com%7C1236f42617d246b20
>bc108d8384007e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
>C637321194957236933&amp;sdata=0%2BzHvJ1n4TZOYss4v1pR6i8bxq46JE73
>UIi%2B49x9joU%3D&amp;reserved=0
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7CEmily.Deng%40amd.com%7C1236f42617d246b20
>bc108d8384007e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
>C637321194957236933&amp;sdata=0%2BzHvJ1n4TZOYss4v1pR6i8bxq46JE73
>UIi%2B49x9joU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
