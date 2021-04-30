Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7809CC43461
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 13:06:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E18561483
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 13:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E18561483
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99D256E170;
	Fri, 30 Apr 2021 13:06:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD486E170
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 13:06:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wp3AdT0rJETBMM9wWrSUEY01KGNO92X9t4PXCy6r3auCd3JyLWDn5um6WwzZYUdcwbfXA/XloaUQtN5sK8a6D31bRclBlQoTo2KcbGe0xXs41VN5jE1UXYQ+jOZFWquY2yygSVQdIx4POEaWHLn0G5NMIu+mShUffjDidBLN2rkl+e7AWjOSvkR+FRDkQXz3HI+hIQX+6bpCnXhkJ1RZX4y9PRs0KHWyljnQHaPXMJRBEn7H4khaaCKFIBZD7zvOBpzo0gO8lKI/w1P8Lg9BlKRh7hY8TrjLVDvvjO5rMv+88+d7QdN84h7gHHJazC9i6Q/EXJfHbVujP88GclxDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QC1LPHGzE3xt9hPpUmVmQoHADlShI04dDzoLG9tCpM=;
 b=ASF+WolfBOCVI9WKqtiwOtP3jwLyNGN2NcnNHg5EMv0W1WfHhMQVxXBJyHKGXOT0aFnxJl+sj0aHAHI0YQTcPHlg6LjHgnt9owkvkjVtAHbPtOUSVfgtFl7RwdMsLioEOjmb+V7HdxL3iChMOlCw7bghq8LnaP52vRioFP7dMFPMOdB3d5OkqRaGZugCX5xB1AizpvWY2WT4XKHYvmsaFizEhx9byQLhS6boZG2WtPlz/VYhIw2q4YB6NpSKgHhjQwElyppZVaLOr4JV/ew2skLZKhD2yzZMuRbJvloUgEsmc8iRLBmEpF+MTpD+2W0G7cXAhBZNEFbl/Fr3alww8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QC1LPHGzE3xt9hPpUmVmQoHADlShI04dDzoLG9tCpM=;
 b=gwM6fNtPyBZqicXLNhH3WQ/jyzppP8qHpzdJMsHdQa5Q1hqlctjEzzFI+HG1C1VH41MX/Vl5yKA61oTX5Q1lfgp7fbcxp6RawlWVImD7C4WWB4E9CsGWBuRzsguWkFz/bzkQIO+HeUz+F9RrfpZxlTttDEqS4TE4aUEyFLDTiQM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20; Fri, 30 Apr 2021 13:06:51 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101%7]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 13:06:51 +0000
Date: Fri, 30 Apr 2021 09:06:48 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>
Subject: Re: [PATCH 1/1] drm/amdkfd: Make svm_migrate_put_sys_page static
Message-ID: <20210430130648.onvjew5m2cpv6zw4@outlook.office365.com>
References: <20210430090953.31524-1-Felix.Kuehling@amd.com>
In-Reply-To: <20210430090953.31524-1-Felix.Kuehling@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:af63:9755:c34f:ce56]
X-ClientProxiedBy: YT1PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::11) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:af63:9755:c34f:ce56)
 by YT1PR01CA0132.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend
 Transport; Fri, 30 Apr 2021 13:06:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 578b54dc-1737-43f7-fc44-08d90bd8d1b5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB359519A1880C86ADE9BBB827985E9@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bcs59wCxbQ7bNx/CV9fSOcF9fT24G0qG4LBFJpAS4V5Lba1JMS34edOfKqGO816XgZzjYhSJNBgNWbnOH9mpjHUgjLVqrxg2QFdLbcaoIN8VCjRWUFV98JZGGe8TEMzkjvL9hsbpB324qbk4CRndOYaRVgoQ91Tr6I/0OK0hIyc9QBftU5t9od5KkTlTnK3QqpIfANgMyWgsr+Pyj8/Mqvu72l8hbVdDW223Cs2ClpchRt07UF11NhPUGSpca331W2RCbfHC9OKqSl40Ru93kLrOwwBezH3DPEuuWdaERaL4ZPwI8MHUfO/PRKHQB4JRDQiYBWHDa2wXt+DEE3DLuHF9seP2ic/7dkuuH1SsI7zx4QjForMztYq4s5On8KWTR43SMugDuHQVE+EW8lt93k0S92lk6cUHftGePvlrcUa7pm72wJmhqK7QzDI2A2iCD9Cgv9M0+yD+4qohhRh6++nhi9BKXwSJ751+CIdy+yVhprUq2UEHmwRFjAmxsL/9lbbXn40jrLKtFpUuNChTyWTpXR9oTaynH9i+LfcvL1Yqs5mz6IlVbz0I6iukoFaetrfuqud9iBdE+obtx0yeMRX62tIrJPr7I0QhVBX/1m08HNOA7fugDgVPkAytd56cleCtT4pTv1O0z/xz7omLTZ1lb6/29ARdaQ0ZZ3JzGAWz5TUdH9B1RWxr+AnnkM2+MHMdm7cvy1cah1Wx0I1ns9rdrY5exj+1nMvnVockhj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(966005)(52116002)(6506007)(55016002)(16526019)(186003)(66476007)(66946007)(7696005)(478600001)(66556008)(4326008)(6862004)(45080400002)(44144004)(8936002)(316002)(6636002)(9686003)(38100700002)(83380400001)(86362001)(2906002)(5660300002)(8676002)(1076003)(21480400003)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Q3cOLha3aRL7MEOsD17G8hI+kyu/4e772I1Efio4hZymbuj3JptfQh3JPT73?=
 =?us-ascii?Q?vXd/JFoFCMD5ZJQ4cZ9msNOINr3vxfUatSV3Ub+61vSjriGcTFOQaqFRUL+4?=
 =?us-ascii?Q?AJvF/QWF+AzXLdsLIgh0xVozD5bHHfBUiPxTcuotj/JHT9iD4PsCn2lbOx+m?=
 =?us-ascii?Q?KcICyQiHzK2I6sm43b5D6Z+J/zFKfoYXOspfgCDBaqvbhCLJqn9SYzexzBNs?=
 =?us-ascii?Q?Q2YqpCRsDVAcQuUjIMhouSliYwHhTctHregzP7B8lAM2aM+zX6WlECoa+vjR?=
 =?us-ascii?Q?fL9xzi8P+YKCNxyIvHIXWKGeQNMwso6PErr4m5otKOYXMm08eZcJ3l+G9tr9?=
 =?us-ascii?Q?TkXomQ71i3MzrgdFKMxOq1kg4pNqszQl+ijnsyKK8m2aIAm+Kf8mQfLvO++x?=
 =?us-ascii?Q?dsj/EsrKrAkDyegopb/Cus6EjMfXHOB6TPJbQohicbHRqDvihrfsc5rocUP0?=
 =?us-ascii?Q?kq3ytwM+fP32L2a3WpLWUjMZ7XcR6HG69/Aa+ox6Vx+kLH7mGmTV84aP5j7m?=
 =?us-ascii?Q?YY/WNpfj1t89ZNnm0Wt58O6WoGvkwEK+sStD7IwK6uoJr0CI0tX6RzRItcNn?=
 =?us-ascii?Q?xd35NPoRMeuQfha5SrTXFK/eL6k3YQZzMBQpaXinZG3h/U4ENSzCdPoS/v22?=
 =?us-ascii?Q?cD6gO9QyTw2dPDUr2K5JsKbVjgpUg/jHsnG3TgXqIxPfOyVOzA5y17Gjhf55?=
 =?us-ascii?Q?BnnNXn4dT+BGkhp8mwde3rQ3kE4F/V6JbjO53vm4g9+OP6iJzfJ22fbgjx20?=
 =?us-ascii?Q?R0afRT4+AvClc4JJKTG1R3nH3imegSvcUfvBlqQtURGMGCqye6bQBNGC++8o?=
 =?us-ascii?Q?m6xusuqY0qTTaKFGCzRIwKqscuemn/L3aoOrHv7VFtCwZ0FCbfEnTRCKIG8N?=
 =?us-ascii?Q?cUHXwRPZM8eV+1ora0sJOwkJp8cwN5Y6HAliqvJQImfXLSrzgXn16YH5mq+e?=
 =?us-ascii?Q?fafzp7dOLNGLZPqouvH+tEJLMnFsN4TZm9unr/6tCqZ2ZBGlKfjDgLK/D2V+?=
 =?us-ascii?Q?aUBprKGQRtkHkPpV98uqONjRiPSDPBVieOoWwLfHzL8QvuZPpNbdkheqaRHq?=
 =?us-ascii?Q?OnSWZV0SKvtztCmiXWAmfVZ1d63LJQU61/HbqUCaIskp+g8cRFYgeI2MiYYV?=
 =?us-ascii?Q?7oUbSFAYZjduqjTzZVbX4iBrWHUmvz6jHSd0Qryb0RLj0hJyQFh8IlF68okQ?=
 =?us-ascii?Q?Ih1g0sjpc4bkqNaFMLtnnfy8S1DabYwpYh6heFhO7l5xKw5Ece67KZvFk+bU?=
 =?us-ascii?Q?2lHcYPV0lzwpJB+hh/qwa0FcKH5oWpnPueV7H15zwTK+wPNPmnmzD0LTdB7t?=
 =?us-ascii?Q?2IYVEYaprhDzqGxLcKISwKTRglgJPb4Ri7BkzMdEawQyfa+uatm/barzEsW9?=
 =?us-ascii?Q?Ew5Q8DsM4dZkLEmAOYsyqBT7Q0gE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 578b54dc-1737-43f7-fc44-08d90bd8d1b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 13:06:51.2999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLpMelG/Ylub/umLdZNelaK8jfAHmFTxaf1lX0/ctpYt6pr4eEAYdG6pI/0jjdcmyoXbb/SUllZbdiNjkUuDAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
Cc: kernel test robot <lkp@intel.com>, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============1646303205=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1646303205==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yl2spdb3ntl7bfkd"
Content-Disposition: inline

--yl2spdb3ntl7bfkd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Lgtm

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

On 04/30, Felix Kuehling wrote:
> This function is only used in this source file.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_migrate.c
> index 6b810863f6ba..bc2fc528ad58 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -281,7 +281,7 @@ svm_migrate_get_sys_page(struct vm_area_struct *vma, =
unsigned long addr)
>  	return page;
>  }
> =20
> -void svm_migrate_put_sys_page(unsigned long addr)
> +static void svm_migrate_put_sys_page(unsigned long addr)
>  {
>  	struct page *page;
> =20
> --=20
> 2.31.1
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CRodr=
igo.Siqueira%40amd.com%7Cf8bfc52427f04e97f82708d90bb7c197%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637553706127947374%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s=
data=3DsOUEQXslNYh%2FYoiG2sXzBmmxoLHOMet0HOTJwdtx6y4%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--yl2spdb3ntl7bfkd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmCMAOMACgkQWJzP/com
vP9u1RAAzOOMdRS/ufctC6Co0p2x9dytqt0EUjmMXi5bR3FJ9yz7C9dKn5SwRDfI
+VA0vpA/jNWRR6KyHoukania78p/0j+JFzRx4Ca/A9oV1U6j9rHyqsYkNenRHC15
ciXhRJAEFiONib1z8tl8Wnq/3Ogf0IdQyEZKPmhK3Fnto9FMMJGq6BEvxNHGz4PH
wX/JJuJIgJwDhIp8eWi6cjX1s32PjeruvCRL8iRidKDlA7IK0xeBBfRrQAkd3270
5wkM8j9deWhzwNYdUVSmm6cgnUNRIXS1YSKiIXm0fy2ALJ0OHMVbGhUeGI3hgT13
rYMw2Gup9CuQeHa0ffIvRUkCkkKrdj5du/hzlj6ssSbX0wV4ZfXiVu1F+btOMccS
xZb9W1EZN62azDNXe9JOm5yTnQGjGq7ETbxUIpBdicanR4B65DNzPARwPIr22fSg
K7tamMmf1r2M8AuFL+a87pJXc5t3BYQLHPUOSpVRt+a/KyYIwrJ6dOP5Zlrq5sYn
hhWUdNr4poQkSq13B/IHl2m81EburmyrxkvrlsVTJu/nrOFK2mXMe2GHGnKwdUBJ
s/tba/8r3vR5xB4xJpzl3JB/9xTqexpkF0HwskA+aPLG4h6Xsn7/9fUKDCsUyH3M
BgOz9Q6gaiTcR/4VRuUw5efT+yUKsMHYJuOeB2r4SjFLdt6N2aE=
=Mf2T
-----END PGP SIGNATURE-----

--yl2spdb3ntl7bfkd--

--===============1646303205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1646303205==--
