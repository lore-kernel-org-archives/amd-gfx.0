Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C18ECE57A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 12:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D2110E465;
	Mon,  9 Sep 2024 12:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FvM0Xh/B";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA0FF10E475
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 12:49:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s10SLFQhH05XS0yCA46AtW4PIpkYAlRtKBqHf5k9nAvV3HEGJ6jWPUEdKyYGt5pAyZ1VCNIWLKbQuEPl9gEJraFYkln4Rxs38Rxxdf4Y+HMEcJYHrDwi5Ny1yfPCsBGIiLoOmxqIRSLWVfb1/3b4qM1bGgOefCEHHpaIwI4ZsLcM3wiH1GKpPkL4GR2vpvr/DhFlWgXviDBYYo4Pr4IBl4RMehD2nZsqzItdnrcGUDfxov0kboNXyG26Gj75iDmcOIn8Rx+05z9MUbBr5FpnS6SHzRquBLfgJNQF75vDuaXgdpXpGpGZ/kwNV46ybCsTRqVcacuEFJqwxM7hQUVMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQ18vzIFbqlIaLocoz4eDfK2CoMjjiIlrbDmZxpACuE=;
 b=tcn7XO76KYC59liuDfUyzrYoPZ5vmg9KUEWDWBKakrYlZLgKG0G9Wwqm4uNXjQMGczBkgxA5tDA2Uus5Lm/AUgrFR7CrJ602JMFRwGetSwwcttJFigURoRXye+Np0T9ZkRvEkXkVerTCtZjLiJLgHiTM6N+Eolc5hykw17YSqimYmzycjqK3K1PYCROOf0P0H/esHE9Y+nLBvYCZq109MA6eXLk61YNcjVm4oABtBnuVjbEzTq6MK8mYWlTHb6jOMOjWOyEl1hVIO5xmmtvgNlejGWE0Grl5BNs+qh1T2VKWz+auG0GXInM8MrAIBLZiFLza/0TIKsEB+YZ1KiBlkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQ18vzIFbqlIaLocoz4eDfK2CoMjjiIlrbDmZxpACuE=;
 b=FvM0Xh/Bizq/mjpzmLlk0tJ3BXlJZpC4giYFfOR2gnub8WMT5Y4jZogcnMvSdFnq8DlpSECRjltCxmuX00JHWNXBgPlyfW8JEDgwnpGzo63F+vy+nWkba4T2KHHvNSpcvwDMQxVZEAVwX8Tr8JzDnOSp79bgESVdelo+6pp2qZU=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Mon, 9 Sep
 2024 12:49:00 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.7918.031; Mon, 9 Sep 2024
 12:49:00 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update suspend status for aborting from
 deeper suspend
Thread-Topic: [PATCH] drm/amdgpu: update suspend status for aborting from
 deeper suspend
Thread-Index: AQHa/Q/9qItUk6VUqUSLe/ZtzNgwobJI0iLQgAI5rwCAA/tWMA==
Date: Mon, 9 Sep 2024 12:49:00 +0000
Message-ID: <DS7PR12MB60057926E8C172D3EB5A332EFB992@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20240902081311.2918278-1-Prike.Liang@amd.com>
 <DS7PR12MB600580C6E52BE6734FD7F0F7FB9D2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <BN9PR12MB5146FB172036F9601B38C3E6F79E2@BN9PR12MB5146.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5146FB172036F9601B38C3E6F79E2@BN9PR12MB5146.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-06T17:34:05.544Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH0PR12MB5630:EE_
x-ms-office365-filtering-correlation-id: 6e7df1ed-612d-44ce-0a6a-08dcd0cdc6c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3KgW1pnCU+m4bnUUrth+4TyLDZwdBm1adfQk02IV/3dDfLcky6LrziO00nQL?=
 =?us-ascii?Q?e5B1TeEgqerwLzzFD+5sF5yzz3Oz9CUQMA0VmCDTTVgHcZGyBvz04ux/9JBU?=
 =?us-ascii?Q?I0KMXPWUJkNrVKlsMGwbt1iD+AFoSQcWF/4jv0eg4nci++NT+T7SZYPJgbM7?=
 =?us-ascii?Q?Ay5jAG+MwJcAnvOS1gvoCH94Gx4o2aKOLb9OVOhJV45BwNuV1uThwBt0pICg?=
 =?us-ascii?Q?0wJl2pHLYQBMklfY3Rv/Bei0kRpsmJfD1s3rRmyOQRm1CZ4Zag58PUn0sRkQ?=
 =?us-ascii?Q?lJkEBwQPCPgoo1Sje4ZkBtk+KgdZ6nypLtj5FYXnK0YoD+SZmGy/cmPFCQ39?=
 =?us-ascii?Q?iE1XaDhOdFxvqet2p2mnGWOgNc/N4TxoVCo9MSL9o2g/mQ+asn3h8JEJDArK?=
 =?us-ascii?Q?5efHBQmlos50x1EPJUPOjDS4LyVi2BXeYXYbgc8hZs8OU79/1YU7Y0NZJt/1?=
 =?us-ascii?Q?tG56Kfg6JyamPNAmpY4tBmm2IlHzuNmmucW8H5bhICTwgyydtFwQr9010ZJy?=
 =?us-ascii?Q?qpoSVWoZauK1aw8/HVDb1wvNVjruW8t1v0MqR8ZzOHKSDBJi0CHQx+pSSZ/v?=
 =?us-ascii?Q?6csbtc/cKhUChSnvkGwePDLAkE+qZBh+0Xa7JLlF1YibMzkLp3HXokGFM3u1?=
 =?us-ascii?Q?PGRFKYjfbU2ilgG2S6D6KjUVVKT98n1j5hpMe4scOlQDG/bRsz5/Ze3gupFl?=
 =?us-ascii?Q?VEpZG7+H/DTPqQ3VejIFBu23mh778EhYN5Lpos7ZO0FKYEInUXfuKXAsXuEv?=
 =?us-ascii?Q?O5M35ydmNUK8vPw3ZZdtIKnk5/Zg+0N2uy1kqyYA5MiU9CRSb8kB4Jwupk0x?=
 =?us-ascii?Q?S8yq51b3vRNG3GvcalJ4cvPOXOVhJYa8CFkFFf2uzzSjdfneXRrTtOnxa1xT?=
 =?us-ascii?Q?tGpugS65UbhaUCzxx8c7qJWnjZgV1iA5eomK1Sq5Q6yZS2yfoga7aYTqO+UU?=
 =?us-ascii?Q?aI+Qfok33Hx+OhlNeE9+ExMtfFPwHikb8Z1XkiV55XSnGdqGzgi56aJd9FgY?=
 =?us-ascii?Q?GvnEIBYb6TbP/IcE1EdF0W2a773j55ro5d80LaJ0meFyeCoyV7H4PJG/nkaF?=
 =?us-ascii?Q?A+QaiDOnt9s5KzZl2r93ax22qiUCGR+6pYhPNazCWw3mL/sLeZln6P32zi3i?=
 =?us-ascii?Q?Au1Jia0two2EAAw1BOeuaR5UPLyPxiXq8EjVz3YMtiw6iO1zeYGAwLx+8peB?=
 =?us-ascii?Q?ICsndIeO40SVxTWcZWRi6LnY20+yjyjd1+eaYGemuYAj5acoOpKsvD8OBCIv?=
 =?us-ascii?Q?mURB1gVE9eP6l7Vzq9BM4WVLPxbR7lzq6Z8vELhYy+EBlr/ceNS2UYYWy0Bz?=
 =?us-ascii?Q?zhdJWfWEldcC2skm16mwTeGsJNSUghUaGf7/pN6Eriy+B+83avWWxtYuQ9FN?=
 =?us-ascii?Q?FyFt3ubsCM+PLmTQZpw/bFCZ5zS9728Kz6wXPA691kxZcqNcsg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LNgrJZyu0MzUR74Hq56zBk7gP51sj7Cbrwlet0myAqWeCh5P4b0YUNsuxqsR?=
 =?us-ascii?Q?BmonAm8mMif9ikFHbt8VIK9gAJEVRD7ff9g3fVsdd9ncrP+fon374d1SoacC?=
 =?us-ascii?Q?wr0Ujhy57HVwji9FDIZ2UXXPSUlNFU4ZHT/QIj6saoJUfD+F+JFC1S4vid3x?=
 =?us-ascii?Q?zcsW6PU9Xlo9xzEda3jaOtozucsUT1ZTazOyw5F6KYjsslGEGhG3/ab+ENRW?=
 =?us-ascii?Q?92xR51E+jmUc/v47fNSxjgEsGby4BKo4sZxsh+E5+43ZspXT56NwEwuyXXxq?=
 =?us-ascii?Q?y0WAPhGGJRxGQLK2ilkP4wws4xEz0wFdJWoFx9gpocf5vtETtj2gzFwFZ2hb?=
 =?us-ascii?Q?WQRosz4JFVQnU/IJmYYDakv6uT9DUz/C/99F1IC9QAeEDSNO2bemamTG3pHA?=
 =?us-ascii?Q?qs+GhMRBr5X09WVvd9+NN4jwQVI7mqouLI1gxQQP554iMZcdIpruPv0zrM59?=
 =?us-ascii?Q?b34+6Yvomypcac0X/1cy8srpqTToDcbPD2zzSyiUU93slskWzCXmZcwQzmaw?=
 =?us-ascii?Q?+/1xmAYzGWyNiA1eVAzzx4G8eWy5vwF6+YRs1Ztt0SIi5dxvtx8HgF3WbTAi?=
 =?us-ascii?Q?c3sqbhb01X5kbFeTwK+QZNqS77ir/jl5bCebabcYRZy0wTtfGTGMvqBNE12B?=
 =?us-ascii?Q?FEOcXs54apSuE/r0CXZk1KNcxAH/YyxS4x89Obd11OO3L8qI2jRbMZ1l4Y4s?=
 =?us-ascii?Q?34V5N+XLhg53XQ2Cfn0fHrgLciDTcTmUto4L12aDKK4F52yVUPg34zBDRRDr?=
 =?us-ascii?Q?nUJ8qd8QeTEH9ADcImpfWOPe12xmp2EFUIuQp4UnM3oU1iJnLvwe1+2zBK3z?=
 =?us-ascii?Q?jX1SWLY95gGeYigbVeNB90P8ivA7HK0EEzSjJl3lU8DSXaBNOyjDj7C0gse5?=
 =?us-ascii?Q?Nkznn4rUBAWjqk5JnXvCp8Z5jv9wTbLELEDhlkPPchrFtAC6KxFcd8g35Vw7?=
 =?us-ascii?Q?xRC6e2k4cBHqUV54iJmZSO/waCCoEvfiQOp3XIqIi0qRj1beRuvxYY6qHgb2?=
 =?us-ascii?Q?NE/V173sFoEaVdZgfUtiW56p9GxDMeVYb6bczM6/cAmbrto02uvicGsQBYPz?=
 =?us-ascii?Q?I5p4LOVRky7kH+0KQx4QlNP6CHfSyh7m+4M3YqPEt7ysMuc5Siu6cEtDwXtU?=
 =?us-ascii?Q?n+iy8V3XvNlei5XdlfZ+s8mrcmIaUZ5xzfTtQyNvZ5eGeuZ0XYzb+A6GHnrt?=
 =?us-ascii?Q?EdC2bNUJadFfEe0ow3OuQJ+p7MW2njVjL8Y0tSyKqgrkavjAiH12Z4zPJIwL?=
 =?us-ascii?Q?pHJFMUtlH2sia5tlnXUnq7T0yw6ds0K+AQQ+LvYxoa9DCzJTMIzB4o/7g5ex?=
 =?us-ascii?Q?XRYQy6QOvFSM0am6LiIrhLfn4GmGn7xaHm4urbqlqYaVAAq33tZfcTNbkFYb?=
 =?us-ascii?Q?XJnirfQscPezSIXC+BXMTaD2dTy7SQaqVYKlJdPoYcNahMiEg9VKwQrQs038?=
 =?us-ascii?Q?BpDwc0xwEWJRAH6+hgUcSUG7FVzWYMSCN2aIlzLKYZ5Du2ywDwKF4VBjTydj?=
 =?us-ascii?Q?H8W6jRn3QU5Vbdp1OReI4XoqUM5k+Aug7BV/Yo1wzOsmwlb/zr3B4pBnveG5?=
 =?us-ascii?Q?Pj107PdsnVSGLnrJUj8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR12MB60057926E8C172D3EB5A332EFB992DS7PR12MB6005namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7df1ed-612d-44ce-0a6a-08dcd0cdc6c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 12:49:00.1059 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: obctNEZr8B6qAdyLrQZ7fW7qtCEeHBXqIe1m1IZrDtJ86JVptcabLJCE9t2RU8Ow
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630
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

--_000_DS7PR12MB60057926E8C172D3EB5A332EFB992DS7PR12MB6005namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Previously, the S3 process aborted before calling the noirq suspend, and th=
is issue was successfully sorted by checking the suspend_complete flag. How=
ever, there are now some S3 suspend cases, such as pm_test platform/core mo=
de, which abort the S3 process after the noirq suspend. In these cases of a=
bort, the issue cannot be sorted out by setting the suspend_complete flag i=
n the noirq suspend callback, and it's fine to use the MP0 SOL register dir=
ectly to determine whether to reset the GPU on resume. However, on the GFX9=
 series, the driver still needs to rely on the suspend_complete flag to det=
ermine whether it needs to skip reprogramming the clear state register valu=
es during resume from suspend abort cases, so now it sounds that the suspen=
d_complete flag cannot be completely removed.

Thanks,
Prikec

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Saturday, September 7, 2024 1:34 AM
To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: update suspend status for aborting from de=
eper suspend


[AMD Official Use Only - AMD Internal Distribution Only]

Can you elaborate on how this fails?  Seems like maybe we should just get r=
id of adev->suspend_complete and just check the MP0 SOL register to determi=
ne whether or not we need to reset the GPU on resume.

Alex

________________________________
From: Liang, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>
Sent: Thursday, September 5, 2024 3:36 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: RE: [PATCH] drm/amdgpu: update suspend status for aborting from de=
eper suspend

[AMD Official Use Only - AMD Internal Distribution Only]

According to the ChromeOS team test, this patch can resolve the S3 suspend =
abort from deeper sleep, which occurs when suspension aborts after calling =
the noirq suspend and before executing the _S3 and turning off the power ra=
il.

Could this patch get a review or acknowledgment?

Thanks,
Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>
> Sent: Monday, September 2, 2024 4:13 PM
> To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuche=
r@amd.com>>; Liang, Prike
> <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>
> Subject: [PATCH] drm/amdgpu: update suspend status for aborting from
> deeper suspend
>
> There're some other suspend abort cases which can call the noirq suspend
> except for executing _S3 method. In those cases need to process as
> incomplete suspendsion.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com<mailto:Prike.Liang@amd.co=
m>>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 8d16dacdc172..cf701bb8fc79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -587,11 +587,13 @@ static bool soc15_need_reset_on_resume(struct
> amdgpu_device *adev)
>        * 2) S3 suspend abort and TOS already launched.
>        */
>       if (adev->flags & AMD_IS_APU && adev->in_s3 &&
> -                     !adev->suspend_complete &&
> -                     sol_reg)
> +                     sol_reg) {
> +             adev->suspend_complete =3D false;
>               return true;
> -
> -     return false;
> +     } else {
> +             adev->suspend_complete =3D true;
> +             return false;
> +     }
>  }
>
>  static int soc15_asic_reset(struct amdgpu_device *adev)
> --
> 2.34.1

--_000_DS7PR12MB60057926E8C172D3EB5A332EFB992DS7PR12MB6005namp_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
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
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Previously, the S3 =
process aborted before calling the noirq suspend, and this issue was succes=
sfully sorted by checking the suspend_complete flag. However, there are now=
 some S3 suspend cases, such as pm_test
 platform/core mode, which abort the S3 process after the noirq suspend. In=
 these cases of abort, the issue cannot be sorted out by setting the suspen=
d_complete flag in the noirq suspend callback, and it&#8217;s fine to use t=
he MP0 SOL register directly to determine
 whether to reset the GPU on resume. However, on the GFX9 series, the drive=
r still needs to rely on the suspend_complete flag to determine whether it =
needs to skip reprogramming the clear state register values during resume f=
rom suspend abort cases, so now
 it sounds that the suspend_complete flag cannot be completely removed. <o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-ligatures:standa=
rdcontextual">Thanks,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-ligatures:standa=
rdcontextual">Prikec<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Deucher, Alexander &lt;Alexand=
er.Deucher@amd.com&gt;
<br>
<b>Sent:</b> Saturday, September 7, 2024 1:34 AM<br>
<b>To:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: update suspend status for aborting =
from deeper suspend<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal=
 Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Can you elaborate on how=
 this fails?&nbsp; Seems like maybe we should just get rid of adev-&gt;susp=
end_complete and just check the MP0 SOL register to determine whether or no=
t we need to reset the GPU on resume.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Alex<o:p></o:p></span></=
p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Liang,=
 Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Liang@amd.com</a>&g=
t;<br>
<b>Sent:</b> Thursday, September 5, 2024 3:36 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: update suspend status for aborting =
from deeper suspend</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"BM_BEGIN">=
</a><span style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;=
,serif">[AMD Official Use Only - AMD Internal Distribution Only]<br>
<br>
According to the ChromeOS team test, this patch can resolve the S3 suspend =
abort from deeper sleep, which occurs when suspension aborts after calling =
the noirq suspend and before executing the _S3 and turning off the power ra=
il.<br>
<br>
Could this patch get a review or acknowledgment?<br>
<br>
Thanks,<br>
Prike<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Liang, Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Li=
ang@amd.com</a>&gt;<br>
&gt; Sent: Monday, September 2, 2024 4:13 PM<br>
&gt; To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.fre=
edesktop.org</a><br>
&gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com=
">Alexander.Deucher@amd.com</a>&gt;; Liang, Prike<br>
&gt; &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Liang@amd.com</a>&gt;=
<br>
&gt; Subject: [PATCH] drm/amdgpu: update suspend status for aborting from<b=
r>
&gt; deeper suspend<br>
&gt;<br>
&gt; There're some other suspend abort cases which can call the noirq suspe=
nd<br>
&gt; except for executing _S3 method. In those cases need to process as<br>
&gt; incomplete suspendsion.<br>
&gt;<br>
&gt; Signed-off-by: Prike Liang &lt;<a href=3D"mailto:Prike.Liang@amd.com">=
Prike.Liang@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/soc15.c | 10 ++++++----<br>
&gt;&nbsp; 1 file changed, 6 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; index 8d16dacdc172..cf701bb8fc79 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; @@ -587,11 +587,13 @@ static bool soc15_need_reset_on_resume(struct<br=
>
&gt; amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 2) S3 suspend abort and TO=
S already launched.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_AP=
U &amp;&amp; adev-&gt;in_s3 &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;suspend_compl=
ete &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sol_reg)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sol_reg) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;suspend_complete =3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return true;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;suspend_complete =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; static int soc15_asic_reset(struct amdgpu_device *adev)<br>
&gt; --<br>
&gt; 2.34.1</span><span style=3D"font-family:&quot;Times New Roman&quot;,se=
rif"><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DS7PR12MB60057926E8C172D3EB5A332EFB992DS7PR12MB6005namp_--
