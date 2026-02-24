Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B653EFB810
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 08:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EF6510E519;
	Tue, 24 Feb 2026 08:41:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OqbayTaL";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23CBD10E512
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 08:41:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKw6x5UjRyWsQSBnzmxq7BJFM7pzuOeFWNmbYYqjOeT4aQtQF1YoFKQ9UeJJ1z+qPyOCIUs0pZHlfe7bux6x9cSZerOXVrZHq5sYP3MN/VQg2FDZyRrKtjnuq6BCw7/iOzbP/+Mx8s8uoWIsYAVIl1Q7umf6LKB5CKlvfoA0cwcwBls04WXOWsoBPLtsw4GH/KEKULSW1Tu4FGiwRg7NvdV6Uc8L61W1gy4ndDt6aI4FG40apkMxEbRhMiXYn+WHcoLz+0bnAGn1YmSGFMGUipykOisgJx2vkaL4YP9wmbFdn14zKurId2BzHe7GvVwFCTT4GjrNynyU7gEaiufICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gpkb3J9aws/PcoGk36QcEs3T2nSfI5wzYl9H9RBrJMI=;
 b=mJdZRwtR8ca8ZZz4LTpTcpPZEwla6tBHRpuzuLfT9OzjDvRZRXGTMn9qvBizRCG7ym8r9+fablVn9vfVnNYeOi4xwbu7i3wcC4Js/dQ83ZIRTwDx2O8Il+3F5nNENKq3P/xiBfJ64bTOwbdohimWZz7PUmVYasuIzvCAYBqSHBzGYvfVZ4S8sR6dad4g5KlJD7wsqZ7Y5adE/KPIsIvOvPZA4fXdhNNzGR+dUgmu1RIkASkIVTKS6X3PrPl0MnO5WDasXb55+q4ycBm7dG8FEtd+jnH2sOR3SDVM7SyNTfxoazuKD3/NxAFt9mFDLyJTRb6nb8U2zenK/GvWc7VSKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gpkb3J9aws/PcoGk36QcEs3T2nSfI5wzYl9H9RBrJMI=;
 b=OqbayTaLt6jNGzEKQ4xaIH7hNNfLHUGqMuBHQ8hly0Dylt7ngu5L/jryAESIbOo0jZ5h3k5ndTVp4lswyZQ5f7scunuNVKox6kRZ0gMIxm659t+UFTOEklAkDfkY9cQbfOj/PL8IeaNN/B8mnupl2/SepWsd+6vaLbbVeVHrEI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 08:41:27 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 08:41:26 +0000
Message-ID: <1d38bf92-19c8-46ad-9319-2487f59958ec@amd.com>
Date: Tue, 24 Feb 2026 14:11:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] drm/amdgpu/userq: initialize gobj_read/write in
 amdgpu_userq_signal_ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260224082443.4002292-1-sunil.khatri@amd.com>
 <7f851448-e4b8-46eb-9f38-4d45e0321e6c@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <7f851448-e4b8-46eb-9f38-4d45e0321e6c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::16) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: c9683e20-296b-4832-0a60-08de73807f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zm9rRUZWMVN1d2hmbDBtTFR4TmtYZWkwbDZ3K0xURE45Z1ZHTWpDU1FoSFJx?=
 =?utf-8?B?UUVjN1BsOXFMTDl0QkFua2NOaVd2UE9xd1RFUGRET2czejBQVTI3V2E5MlRn?=
 =?utf-8?B?T0RabVZTQWUvekVhTDB0djdVOWxCeHZJNUpaL0pZWUxGUi9wYzhBdm1JakRt?=
 =?utf-8?B?MndjZlR1NU1sUnpadkF2V0FhZVdPV1VVdCtZSEx2WUZia3lpdk80dzR0dDBM?=
 =?utf-8?B?czBDNW4yaEFlRG90bjkvK1FGTVlXVmk3U29wTFExaHZ5ejBVelFpU093bnEx?=
 =?utf-8?B?R0M2UU9RdXZaN2ZGb3ZNRmpJYmdnd0I1MVdwRVkrVVpEYnVYSWwwL2x2MEZx?=
 =?utf-8?B?RGd5UVdvdmZiakx0V2JYYy9FNDI2VDJ6ejJXWEV3TVg3NnUxUkFzVDVrOTJj?=
 =?utf-8?B?RW1pL0M1WXBMRUZadU9OcEdDTkZvTEphdWlDc1gyOWVUTkd0MGNyeml5RE5L?=
 =?utf-8?B?cGcreDU5Y0RQS29OUDVJKzFRTVdhNGc5eXBna0w0a01kRUFwZkVYNU53Vk05?=
 =?utf-8?B?eWFMYW1TcXREY1hjZTVCV0g2Qm5sUWFvSG13bFRISHJhZytsQk5ObVQrSTFs?=
 =?utf-8?B?WnpVQ25nWXVZck8zN293TEZtaFl1QnpzVUw4YnpvZFZYSnV2ZkNJMlAzU0Y5?=
 =?utf-8?B?a0prRHN5UE52cXNOUWZ4RVFBdCszZ0xHVElQcDZMdldiNUtHaEdTdC9pQUgr?=
 =?utf-8?B?cWlpdkFkT1FpSDd2L09hVEpKZThhaXA4T0p5bFQvSlRUampNWEpPalk1bDNJ?=
 =?utf-8?B?ZThZMjZ1YWEwYlUzWkFNOFBwZ0FyK0czZ0JrcVZEK3Z1RXRFNTkyR3VteTFY?=
 =?utf-8?B?aVhRR3NHaHZEMFA4SGdiYWhpOHcwdm1rZnprdzJKQjNpVnQ2WHdkNEw4NjBE?=
 =?utf-8?B?QWhjdldscUVuZ2tkZ2V6RzczOTVkaW8xN0hnYkRPb25JK05aQ3hLcjRZY2Rz?=
 =?utf-8?B?UWlQLzVuenBmcGVEN2pINkwreldEUmZSdnFoNzdZOHJxY1hjQXM0ZVFoaER3?=
 =?utf-8?B?RFRnbVFJeEZGdFlkaTFmcmRjb0p3c3NZMmVFOUYvb1Bob3RBNUFNSTVTTWFR?=
 =?utf-8?B?cVNkbjZiUHVLbFVtbElBNnZnNjhvL0VubUQ1L2lxdXpaUmpmRTBmTkc5Mm1U?=
 =?utf-8?B?NHloR2tiSUFZWG1LM09PK21ta0R2cWRreFBXMUVJTkVHeDBqd3pjVURGa1Qw?=
 =?utf-8?B?bEpscTNrb3l0SWFqVDZQZzVoL09ZNmVUWFhkQk5KdHVvVzdYWFExU2dsbVNR?=
 =?utf-8?B?WVF0Znd4c1gzZWtwcVdRVWRRa2xyQlBuamowQjJ1RTdCdWVxdUFNc2pUNW9l?=
 =?utf-8?B?bk54eWtBNGI1THZDcC9UWUZjZUFMZHgvb0owanFIak9Vd3V2VllxQlZVclor?=
 =?utf-8?B?MHI0b1JrdWR2ckd4N3FoWEVLOWY3ZGNZUkp4N3hKTmhkUkNLR0NpWDFndHhG?=
 =?utf-8?B?RzAwbmN4TDFHR2xOTWpndXo3RjdEREpCaHFGN1Z0bDJwdldKSkVQL25VemhT?=
 =?utf-8?B?MnpDV1dXT1NjekVydjY3Qm5IUklGQ3VzY2xVVXhhU1NZejEyYnoxT3EyUEVN?=
 =?utf-8?B?YlFXQW1vdjBwNUtsNVJ2QjJlRjB5cFUrVG5uSWFyU083dDNjelJ1SHVjblpS?=
 =?utf-8?B?VWtFUFhrT1I3RGhkNk5udmZ4aHgxbUlBMi90TFhaZ3FKOEc1VWE5dE5jRHgy?=
 =?utf-8?B?M3hhR0xZU3U3eVFqNGlLTXhURmVpSUZxaEZSMGdiKzBKaHdCT2w1OFkyWHFz?=
 =?utf-8?B?TThOTERVcWRFSVd2ZkRmUTRJNG14WXZKSGlSL1RNY1JBK3cvTVg1VWhOeGhq?=
 =?utf-8?B?dFUwT28zbGdMODJwRHpDL3FlS1lCSk9xSE4wa3RqODJUd3FKNzZldUhvSWZy?=
 =?utf-8?B?eXA1WHdka2xmeU5ET0FFODBKSUh3N3ZkaEF2Z2lhWjlidExYdTVGejMyVndN?=
 =?utf-8?B?eFJLbmVTZVloN1NJVXdmWUNWYzlvQ0thUzRDUG1PcklIZkVybU8wZFo2ZW1l?=
 =?utf-8?B?d01CSzNoblIxeG11cnZOdG1VL1FGUXJFQWh4Wk5qSzdENXV1QVluRE9BNmJY?=
 =?utf-8?B?eHBvUHllemU5OUZ6alF4ZVpqM0NXZmloUGNpU1pRSUZGVUFMSFJmK1FIS2g5?=
 =?utf-8?Q?Apec=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk9uNWtyY05aTEdPbWdTWUtzaW5uT0M2Y1c2Ymp4QXhQcGpXQlJabyt6NzhR?=
 =?utf-8?B?S21KU291RkRYMklYZDJWVFgwd0lNKzZtVm1Ed01tTzR1cCtyT2QxN2FKVk1H?=
 =?utf-8?B?L3lYTlFneDBMd1c4MGd5V29IajlEUktlTE9MbDZYTHRwR3R3aGY4VHVGc1Fm?=
 =?utf-8?B?SlpYc3R6Rm9GWkVWckZtaTNqbTNBWisrdUQ3WXZnaFJnblJVRVZIclBFSWRv?=
 =?utf-8?B?d3MvdVpNRDBPc0RoUTlmWkZnY09RRGpLWGY0dHhuS0J4c3hxR2Vsb2dPRXlG?=
 =?utf-8?B?NDNRZWV3dnZyOFFxMFQrRHRNRWxYSGx2M0xUN1h1U3RhMXJMM2RqYUVMcDNw?=
 =?utf-8?B?VFF4dElvT2k2UDlnV29FemRTZmZuc3BIc0xlaFF0S0YwOEFqM1QvTTZ4aE9P?=
 =?utf-8?B?SnNwbG9rY2hKeEhQazhjN29UdENsd0hUbFhQL0gyZjJ0T0pnRy9HeHkzN21n?=
 =?utf-8?B?Ukx1Mnh1c1VvMGZ5dFNSNzgrd1gwSXVYZG1xbG9FR1l2aVBidVM0VGNMbVBU?=
 =?utf-8?B?ekJneXVTbFIvczFJLzBBSXVJSFkyRG9NR3E5SmV0ZkUxd1FkQTFQNlk1cXRI?=
 =?utf-8?B?YWlyblZLckxGeHlZdEhYNGhnMWFuZm5qZUdrRUJ5VFZGd1k3NUY0d0hBcW53?=
 =?utf-8?B?eVEzMkVBS21Gb0RmSi9lT1NZOUFYTThBc1lZOGM0Z05kb3R1WkQrTGlmWlJK?=
 =?utf-8?B?ZkdGd1Q1RDIyWUR5d3djRmJ0RnUxWjZaU0J5SlF6aFBMRXliYmlvanVkWDJN?=
 =?utf-8?B?dWo0dWZDMGtseU5RbnpLdldwTW5Wa3hzNThTSjU5RnU0NDZZUFA1OG84QXgr?=
 =?utf-8?B?ZWF2cTJZSm0wcVgrRjl4K3d5cGZxL05EMWhNSUEwL0hGNnhKVmF4Y2Zrcjhr?=
 =?utf-8?B?b05sOUk5MXlzMEJxVmIzUER2cy9aYVkvNitxTjhTbTBkQlU0dTJHMlZoaTM1?=
 =?utf-8?B?dS9hNTRzSGhUelU2cmgyczFsVEFwR3RFTTBzcUZsRlBSaTVuR2FIUlA4aFpM?=
 =?utf-8?B?WTVGT0l3M1VhRDNkWURFbXRqL25rZEowdWxOcllNcXExNFdHanFvZXh0R0tY?=
 =?utf-8?B?T3JQdGpRYVpNR2IxREJCbmpnOFB3aEE3MENNeCtYajFtMzdDSGp2MWVVc2Ey?=
 =?utf-8?B?YnpSVXJBcDd5VnB0c2hYSlpuOG1NVE9wRExXZERuS3dVNC9ObW9rbWpheGx1?=
 =?utf-8?B?ZnBHUThTem1HK1RBTTQrUjZTeFpLL0lBM2M0QTI3M0c2QTJGVWNPa3V3T3Jk?=
 =?utf-8?B?cnlRL2toZGdzbjZiV3J0eUVGaFIyN084S2hQeDZ3M0wyVm1PdzVqM0pCQ1hV?=
 =?utf-8?B?Sk12TmhMNU1zS1R6V1hBWVdSRFpuRkszL2JwRkJNWFMrbzB1SndVNWN0Yzdx?=
 =?utf-8?B?NDhaT0U0MEw1bjdJN3VicDVzRGxsYTlYWlFTUEJockNPdS9DL0JkeDN2RjFN?=
 =?utf-8?B?eFVDYmtqd0VpMnl0MklGV1pYMmQ2UCtoK21WNm5vdzZ4T3U3SkUzZW1PTzZG?=
 =?utf-8?B?bGt3YTRUTWhCb0FnS25RbkNCa0QybjhrTk5yUStvWmFEMzVMVXdiWUdueHZE?=
 =?utf-8?B?aHRjQmpFcUpOOFVqTUkvZ3NJaGJhb2RYRWo2MEdTeDJYYlFaTk12bit4UzJJ?=
 =?utf-8?B?bHFHYUorbU56Vm5HRko0OXRTV2pNTkY5VjFnN2RYWHpvV0FRaFVmcklwZ0Fv?=
 =?utf-8?B?am5tbnFLM0drbmxVeEZPZjBCMDk1WmMzK3NLZU5NdENNVTJzT3g2dTFHODJu?=
 =?utf-8?B?cXNpc1RCK2crQVJvbEh1cFU1eHhORVB3UWRIaXI2dmUzT0ZFeVFySnp5THZw?=
 =?utf-8?B?YkxMMlFKbDhtcGE3dTE2OVpTY3loT1dUNC90MGNPUmNCVHJTbTV0ZWoremxF?=
 =?utf-8?B?OHVLd21DaHN1aGRoajI4OTBnY3JlWFZ0d1dHUUpMckZRaVpHWWgxdUU4WUpJ?=
 =?utf-8?B?d3UzejU0VElGeCt4ZTY3eEN5VWFHTElHaTRoZlVpTVMvZHFNem14eXdPN2Jm?=
 =?utf-8?B?T3paZ2YwU3lwYUkyQVZINFIxZHc1NG1GRmVKVytzYlRRN01JU2kveGREVFJS?=
 =?utf-8?B?Z0M1THpxQjJtR1pVUytzVHZOS1pJVHdFc1ZhbnNIekhtOVdKNitQVE9EeTV2?=
 =?utf-8?B?b2Fjb0FyUlkzampzcTM1cFNrSHZYbGI1LzBTbXJvQUl5MUs2NHRhSG5QTTVJ?=
 =?utf-8?B?TzBYay8zaTBzZHBjWVN4d2x2emg2T0xDREZXcGxXRzJvdzVOWUNxUlhpc1dH?=
 =?utf-8?B?SG14RzdRdFF0NWJZY1NVY3plaUlZSXZqOUpWdFkxTUVhd3VlRnUvZDNzV1ZB?=
 =?utf-8?B?NUR1OHg5Q293ZEVkWEZoTFhuMEJqb3dZd0JHb1V2K0Iyd1htdWUrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9683e20-296b-4832-0a60-08de73807f9f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:41:26.8256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuntlkBm2CISEWW5w6suZ1hYIihTIJ3phP99Z6yQXRs7shlaNqrncTReqVuJI+sBzGxxGMEGFeSrD+d+SNV3UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211
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


On 24-02-2026 02:09 pm, Christian König wrote:
> On 2/24/26 09:24, Sunil Khatri wrote:
>> In case num_read_bo_handles or num_write_bo_handles is zero the ptrs
>> remain uninitialized and during free cause a fault. So to handle such
>> cases we better set the gobj_read and gobj_write to NULL.
> Mhm, that doesn't sounds correct to me.
>
> When count is zero drm_gem_objects_lookup() sets the resulting pointer to NULL:
>
> int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>                             int count, struct drm_gem_object ***objs_out)
> {
>          struct drm_gem_object **objs;
>          u32 *handles;
>          int ret;
>
>          *objs_out = NULL;
>
>          if (!count)
>                  return 0;
>
>
> But could be that this was only added by Srinis patch and previously we didn't do that correctly.

For now i see the crash due to random ptr access. ASDN does not have the 
above code and we need to fix it for now.

Regards
Sunil Khatri

>
> Regards,
> Christian.
>
>> Fixes: 3cf117572294 ("drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgpu_userq_signal_ioctl")
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 18e77b61b201..e53e14e3bf2d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -465,7 +465,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>   	const unsigned int num_read_bo_handles = args->num_bo_read_handles;
>>   	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>   	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>> -	struct drm_gem_object **gobj_write, **gobj_read;
>> +	struct drm_gem_object **gobj_write = NULL, **gobj_read = NULL;
>>   	u32 *syncobj_handles, num_syncobj_handles;
>>   	struct amdgpu_userq_fence *userq_fence;
>>   	struct amdgpu_usermode_queue *queue;
