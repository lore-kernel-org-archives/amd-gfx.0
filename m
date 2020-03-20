Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BAEC4332E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 16:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2BFD20739
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 16:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DdI+nU4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BFD20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 851EE6E195;
	Fri, 20 Mar 2020 16:09:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C2A6E195
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 16:09:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aullVTL3ohQ0cOyTysz+QTknu8QqaDZFY3xwYbr0HDeuBy1pBc/emitXQfkKSRNoDP0cb9igF63bDWIHZzQ+RMLtNK956eTGG1wSZ8La8Xifv0AfFoCrmMP1cnBbqtnaoG7wHEIPREsKR5Eibea7GtKVkWyF7pGbYd9azpk6UgbmfROPjgThgDEBzIOM11AQz1R/8ILnjOrABqw/Ua+iP2pMU81sT90saDoZn+a3sTjEX+3Nz9QtAX3/ykH1yO5og+C8JdSu+rR4u3tz8FLwgK8vadYd8+KN9pElgJbE9pu62G6XByXAcu7vgR0jAVfN9bcwo6JfqgZc8uUHpJiYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QC9HvXFSUPR2+4VF9zG0OcjVu141tDdnOe2aumok/qk=;
 b=X/XVtydcCPElDXzlZv+7JBcuV7KfgRlvuQA+YUIi8//RNezDfXp1NNUXXAECVN6Gq0ZexecR+Zelpg2eSn9peAa3Izwfwj4KRB4uH6lu6K+Vl38LcxqXv9e90zSngeQEJwMbxSbgQL3Dp48ML57Vgf1v6Bsuwhgbl7SzTmi8nVdM4Y7Hu3M+g3X4vd0/Qi7KAhSsgZkYQKA4hku/NvK9go76IdgVCdAvwHUJXp3VSabqqBPG5gsqhOg0rlpGfMtLRzYLRdyinp6hGR3J/4hjZmYSSNQGTvKOmOXYunsZERMz3Qx9UuRUNwiQE+2UtqmMNhpwZN+aSzjx238H691nVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QC9HvXFSUPR2+4VF9zG0OcjVu141tDdnOe2aumok/qk=;
 b=DdI+nU4X8J56vI7Ml0sIwMbvuKuuqhLYqy3twgVer+aJgRmzEqLNb0ezha2Dm3WN6UfWMnmP3nxluWl7+cxPbiSbsTxJN+7x68lxOQvZtz2DlvjSn93mG2h2nCYbydqouuAoRc0b5HZxKWi5TscRbpbmIu9DIIAV8QGY2wq1GWA=
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4591.namprd12.prod.outlook.com (2603:10b6:806:9d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 16:08:58 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 16:08:58 +0000
From: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/6] drm/amdgpu: ih doorbell size of range changed for
 nbio v7.4
Thread-Topic: [PATCH 1/6] drm/amdgpu: ih doorbell size of range changed for
 nbio v7.4
Thread-Index: AQHV/k30SQE8lee6zU6Y6SzxiB+fTKhRjYmAgAAZH7A=
Date: Fri, 20 Mar 2020 16:08:58 +0000
Message-ID: <SA0PR12MB457651A2AFB664A8BF69B417FDF50@SA0PR12MB4576.namprd12.prod.outlook.com>
References: <20200320002421.14984-1-alex.sierra@amd.com>
 <5e11d408-bb69-9b84-20d3-50c72d8967c7@amd.com>
In-Reply-To: <5e11d408-bb69-9b84-20d3-50c72d8967c7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-20T16:08:56Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a974c70b-8fbc-4d4d-bd3c-00002395886f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-20T16:08:56Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 293dd489-696a-40eb-ade3-00001c75decc
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d209c17-be9b-46a4-51b4-08d7cce8ff6f
x-ms-traffictypediagnostic: SA0PR12MB4591:|SA0PR12MB4591:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR12MB4591D71FB174ED563788BDBAFDF50@SA0PR12MB4591.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(199004)(53546011)(9686003)(66946007)(55016002)(71200400001)(76116006)(186003)(26005)(64756008)(66476007)(66446008)(33656002)(66556008)(6506007)(7696005)(8936002)(110136005)(5660300002)(478600001)(8676002)(81156014)(52536014)(2906002)(81166006)(316002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4591;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rHs2uy5crmhoHhKjWKtvNxrGkQe76ejajYV8zPgsDgqDue/ZyBx6zHJsSnfwycOu42wgfGUfm1ov4oQ+5Hn+CmxSfNr1aoXCb/hhzQA3vvQvDI30A2vGYRvT9j+E+elxephW8ou9zKiO/SsKvOzGBhFOg02RRxDGNQWjv6v5gAkpHDWF7g/6x4+yQ5WBWzKfD+SHOR4+9CVOVRN0XVNPWeijqh+x6BnV8mXfFGQBHdkEqtxkDsqHBV3TCmndcF5wmABSWsIAICR+KmqFlh9AeDIZJMyA3B2d6oiYT+QoT/BSNYlkx7Ka2Hkg+MW+G7Gpbg6HAOQ8FkVjufM4CQi943e0+G0I4adi46aO56z5SbRI5m3iqIIcXsK3T2uda4w2K0dv2wLv3WPgsIIaVgrOHWDIOhAc/YKmL/rmUrQu4d88z8MV99SThnWJwPYEPRdV
x-ms-exchange-antispam-messagedata: ohdYqsagPJwvtFKiD9bsUNjyTDfb4hmnY6A6oHqYrfed7jy36nwQAKhIA44QlQmvIcCI4Vtu21i5vGuW+TpYVMrNJl2+J+9cT6DJP8wMwrQygpcM1FzvpR//IQJNWBlf/EenOJomiS0g0muoDq/jTw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d209c17-be9b-46a4-51b4-08d7cce8ff6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 16:08:58.5332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzhWOC2qV79r83cl3qOBHVzB2k+ThE4iDISmrJ1Kn9D23Mb++XE6UXSalQDeix7Zr12NJdOtUYw/T+oT2jOi2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4591
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

My bad, please ignore this.
I re-sent this in a separate one patch.

Alejandro S

-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com> 
Sent: Friday, March 20, 2020 9:37 AM
To: Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/6] drm/amdgpu: ih doorbell size of range changed for nbio v7.4

On 2020-03-19 20:24, Alex Sierra wrote:
> [Why]
> nbio v7.4 size of ih doorbell range is 64 bit. This requires 2 DWords per register.
>
> [How]
> Change ih doorbell size from 2 to 4. This means two Dwords per ring.
> Current configuration uses two ih rings.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Why is the subject "PATCH 1/6"? It makes me wonder, what are the other 5 patches. Anyway, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c 
> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index 149d386590df..263dbb1f92ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -185,7 +185,7 @@ static void nbio_v7_4_ih_doorbell_range(struct 
> amdgpu_device *adev,
>   
>   	if (use_doorbell) {
>   		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, OFFSET, doorbell_index);
> -		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 2);
> +		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, 
> +BIF_IH_DOORBELL_RANGE, SIZE, 4);
>   	} else
>   		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, 
> BIF_IH_DOORBELL_RANGE, SIZE, 0);
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
